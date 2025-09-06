/**
 * BOS-AI MCP Detection System
 * Handles runtime MCP availability checking and capability matching
 * Version: 1.0.0
 */

const { exec } = require('child_process');
const { promisify } = require('util');
const MCPRegistryManager = require('./registry-manager');

const execAsync = promisify(exec);

class MCPDetector {
  constructor() {
    this.registryManager = new MCPRegistryManager();
    this.detectionCache = new Map();
    this.cacheTimeout = 300000; // 5 minutes
  }

  /**
   * Detect all available MCPs and update registry
   * @param {boolean} forceRefresh - Force refresh even if cached
   * @returns {Promise<Object>} Detection results
   */
  async detectAvailableMCPs(forceRefresh = false) {
    const cacheKey = 'all_mcps';
    
    // Check cache first
    if (!forceRefresh && this.detectionCache.has(cacheKey)) {
      const cached = this.detectionCache.get(cacheKey);
      if (Date.now() - cached.timestamp < this.cacheTimeout) {
        console.log('Using cached MCP detection results');
        return cached.data;
      }
    }

    console.log('Detecting available MCPs...');
    
    const detectionResults = {
      timestamp: new Date().toISOString(),
      totalDetected: 0,
      connected: 0,
      failed: 0,
      mcps: {},
      errors: []
    };

    try {
      // Get currently installed MCPs from Claude Code
      const installedMCPs = await this.getInstalledMCPs();
      
      // Test each MCP
      for (const mcpInfo of installedMCPs) {
        const mcpId = mcpInfo.name;
        console.log(`Testing MCP: ${mcpId}`);
        
        try {
          const status = await this.testMCPConnection(mcpId, mcpInfo);
          
          detectionResults.mcps[mcpId] = {
            name: mcpInfo.displayName || mcpId,
            status: status.status,
            transport: mcpInfo.transport || 'stdio',
            endpoint: mcpInfo.command || mcpInfo.endpoint,
            responseTime: status.responseTime,
            error: status.error,
            capabilities: await this.detectMCPCapabilities(mcpId, status.status === 'connected'),
            tier: this.determineMCPTier(mcpId),
            priority: this.getMCPPriority(mcpId)
          };
          
          if (status.status === 'connected') {
            detectionResults.connected++;
          } else {
            detectionResults.failed++;
          }
          
          detectionResults.totalDetected++;
          
          // Update registry with current status
          await this.registryManager.updateMCPStatus(mcpId, {
            status: status.status,
            metrics: {
              response_time_ms: status.responseTime,
              last_test: new Date().toISOString()
            }
          });
          
        } catch (error) {
          console.error(`Error testing MCP ${mcpId}:`, error.message);
          detectionResults.errors.push({
            mcpId,
            error: error.message
          });
          detectionResults.failed++;
          detectionResults.totalDetected++;
        }
      }
      
      // Cache results
      this.detectionCache.set(cacheKey, {
        data: detectionResults,
        timestamp: Date.now()
      });
      
      console.log(`MCP detection complete: ${detectionResults.connected}/${detectionResults.totalDetected} connected`);
      return detectionResults;
      
    } catch (error) {
      console.error('MCP detection failed:', error.message);
      detectionResults.errors.push({
        general: error.message
      });
      return detectionResults;
    }
  }

  /**
   * Get list of installed MCPs from Claude Code
   * @returns {Promise<Array>} Array of installed MCP info
   */
  async getInstalledMCPs() {
    try {
      console.log('Getting installed MCPs from Claude Code...');
      
      // Try to get MCP list from claude command
      const { stdout, stderr } = await execAsync('claude mcp list', { timeout: 10000 });
      
      if (stderr) {
        console.warn('Claude MCP list stderr:', stderr);
      }
      
      // Parse the output - this is a simplified parser
      // Real implementation would need to handle the actual Claude Code output format
      const mcps = this.parseClaudeMCPList(stdout);
      
      console.log(`Found ${mcps.length} installed MCPs`);
      return mcps;
      
    } catch (error) {
      console.error('Failed to get installed MCPs:', error.message);
      
      // Fallback to default Tier 1 MCPs
      console.log('Using default MCP configuration');
      return this.getDefaultMCPs();
    }
  }

  /**
   * Parse Claude MCP list output
   * @param {string} output - Command output
   * @returns {Array} Parsed MCP list
   */
  parseClaudeMCPList(output) {
    const mcps = [];
    const lines = output.split('\n').filter(line => line.trim());
    
    for (const line of lines) {
      // Skip headers and empty lines
      if (line.includes('Name') && line.includes('Status') || !line.trim()) {
        continue;
      }
      
      // Simple parsing - would need to be more robust for production
      const parts = line.split(/\s+/);
      if (parts.length >= 2) {
        mcps.push({
          name: parts[0],
          status: parts[1] || 'unknown',
          displayName: parts.slice(2).join(' ') || parts[0]
        });
      }
    }
    
    return mcps;
  }

  /**
   * Get default MCP configuration when detection fails
   * @returns {Array} Default MCP list
   */
  getDefaultMCPs() {
    return [
      {
        name: 'github',
        displayName: 'GitHub MCP',
        transport: 'stdio',
        command: 'npx @modelcontextprotocol/server-github',
        tier: 1
      },
      {
        name: 'filesystem',
        displayName: 'Filesystem MCP', 
        transport: 'stdio',
        command: 'npx @modelcontextprotocol/server-filesystem',
        tier: 1
      },
      {
        name: 'ide',
        displayName: 'IDE MCP',
        transport: 'stdio', 
        command: 'mcp-ide-server',
        tier: 1
      }
    ];
  }

  /**
   * Test individual MCP connection
   * @param {string} mcpId - MCP identifier
   * @param {Object} mcpInfo - MCP information
   * @returns {Promise<Object>} Connection test result
   */
  async testMCPConnection(mcpId, mcpInfo) {
    const startTime = Date.now();
    
    try {
      // Try to test the MCP connection
      const { stdout, stderr } = await execAsync(
        `claude mcp test ${mcpId}`,
        { timeout: 15000 } // 15 second timeout
      );
      
      const responseTime = Date.now() - startTime;
      
      if (stderr && !stderr.includes('warning')) {
        return {
          status: 'error',
          responseTime,
          error: stderr.trim()
        };
      }
      
      return {
        status: 'connected',
        responseTime,
        output: stdout?.trim()
      };
      
    } catch (error) {
      const responseTime = Date.now() - startTime;
      
      // Classify the error
      if (error.message.includes('timeout')) {
        return {
          status: 'degraded',
          responseTime,
          error: 'Connection timeout'
        };
      }
      
      if (error.message.includes('not found') || error.message.includes('command not found')) {
        return {
          status: 'disconnected',
          responseTime,
          error: 'MCP not installed or not found'
        };
      }
      
      return {
        status: 'error',
        responseTime,
        error: error.message
      };
    }
  }

  /**
   * Detect MCP capabilities
   * @param {string} mcpId - MCP identifier
   * @param {boolean} isConnected - Whether MCP is connected
   * @returns {Promise<Array>} Array of capabilities
   */
  async detectMCPCapabilities(mcpId, isConnected) {
    // If not connected, return default capabilities based on MCP type
    if (!isConnected) {
      return this.getDefaultCapabilities(mcpId);
    }

    try {
      // Try to get capabilities from MCP
      // This would involve calling MCP-specific capability detection
      // For now, return default capabilities
      return this.getDefaultCapabilities(mcpId);
      
    } catch (error) {
      console.warn(`Failed to detect capabilities for ${mcpId}:`, error.message);
      return this.getDefaultCapabilities(mcpId);
    }
  }

  /**
   * Get default capabilities for known MCPs
   * @param {string} mcpId - MCP identifier
   * @returns {Array} Array of capabilities
   */
  getDefaultCapabilities(mcpId) {
    const capabilityMap = {
      github: [
        { name: 'repository_access', operations: ['list_repos', 'get_repo', 'get_file', 'search_code'] },
        { name: 'issue_tracking', operations: ['list_issues', 'create_issue', 'update_issue'] },
        { name: 'pr_management', operations: ['list_prs', 'create_pr', 'update_pr'] }
      ],
      filesystem: [
        { name: 'file_operations', operations: ['read_file', 'write_file', 'list_directory'] },
        { name: 'workspace_management', operations: ['create_workspace', 'manage_files'] }
      ],
      ide: [
        { name: 'code_diagnostics', operations: ['get_diagnostics', 'format_code'] },
        { name: 'code_execution', operations: ['execute_code', 'run_tests'] }
      ],
      stripe: [
        { name: 'payment_analytics', operations: ['get_payments', 'get_customers', 'get_metrics'] },
        { name: 'revenue_data', operations: ['get_revenue', 'get_subscriptions'] }
      ],
      firecrawl: [
        { name: 'web_scraping', operations: ['crawl_website', 'extract_data'] },
        { name: 'market_research', operations: ['research_market', 'analyze_competitors'] }
      ],
      linear: [
        { name: 'project_management', operations: ['list_issues', 'create_issue', 'update_issue'] },
        { name: 'team_collaboration', operations: ['list_projects', 'assign_tasks'] }
      ]
    };

    return capabilityMap[mcpId] || [
      { name: 'general', operations: ['query', 'execute'] }
    ];
  }

  /**
   * Determine MCP tier based on importance
   * @param {string} mcpId - MCP identifier
   * @returns {number} Tier number (1-3)
   */
  determineMCPTier(mcpId) {
    const tierMap = {
      // Tier 1: Essential
      github: 1,
      filesystem: 1,
      ide: 1,
      
      // Tier 2: High Value
      stripe: 2,
      firecrawl: 2,
      linear: 2,
      slack: 2,
      
      // Tier 3: Specialized
      hubspot: 3,
      notion: 3,
      postgres: 3,
      redis: 3
    };

    return tierMap[mcpId] || 3;
  }

  /**
   * Get MCP priority for sorting
   * @param {string} mcpId - MCP identifier
   * @returns {number} Priority score (higher = more important)
   */
  getMCPPriority(mcpId) {
    const priorityMap = {
      github: 100,
      filesystem: 95,
      ide: 90,
      stripe: 85,
      firecrawl: 80,
      linear: 75,
      slack: 70,
      hubspot: 60,
      notion: 55,
      postgres: 50
    };

    return priorityMap[mcpId] || 10;
  }

  /**
   * Get MCP for specific capability with caching
   * @param {string} capability - Required capability
   * @param {number[]} preferredTiers - Preferred tiers
   * @returns {Promise<Object|null>} Best MCP for capability
   */
  async getMCPForCapability(capability, preferredTiers = [1, 2, 3]) {
    const cacheKey = `capability_${capability}_${preferredTiers.join(',')}`;
    
    // Check cache
    if (this.detectionCache.has(cacheKey)) {
      const cached = this.detectionCache.get(cacheKey);
      if (Date.now() - cached.timestamp < this.cacheTimeout) {
        return cached.data;
      }
    }

    // Get from registry
    const result = await this.registryManager.getBestMCPForCapability(capability, preferredTiers);
    
    // Cache result
    this.detectionCache.set(cacheKey, {
      data: result,
      timestamp: Date.now()
    });

    return result;
  }

  /**
   * Clear detection cache
   */
  clearCache() {
    this.detectionCache.clear();
    console.log('MCP detection cache cleared');
  }

  /**
   * Get cache statistics
   * @returns {Object} Cache statistics
   */
  getCacheStats() {
    return {
      entries: this.detectionCache.size,
      timeout: this.cacheTimeout,
      keys: Array.from(this.detectionCache.keys())
    };
  }
}

module.exports = MCPDetector;