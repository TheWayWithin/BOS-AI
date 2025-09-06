/**
 * BOS-AI MCP Agent Integration Module
 * Provides MCP awareness and integration capabilities for BOS-AI agents
 * Version: 1.0.0
 */

const MCPRegistryManager = require('./registry-manager');
const MCPDetector = require('./detector');
const FallbackOrchestrator = require('./fallback-orchestrator');

class MCPAgentIntegration {
  constructor(agentName = 'unknown') {
    this.agentName = agentName;
    this.registryManager = new MCPRegistryManager();
    this.detector = new MCPDetector();
    this.fallbackOrchestrator = new FallbackOrchestrator();
    
    this.agentCapabilities = this.loadAgentCapabilities(agentName);
    this.mcpStatus = new Map();
    this.initialized = false;
  }

  /**
   * Initialize MCP integration for the agent
   * @returns {Promise<Object>} Initialization result
   */
  async initialize() {
    console.log(`Initializing MCP integration for agent: ${this.agentName}`);
    
    const startTime = Date.now();
    const result = {
      agent: this.agentName,
      success: false,
      mcpsDetected: 0,
      mcpsAvailable: 0,
      capabilities: [],
      fallbacksConfigured: 0,
      initializationTime: 0,
      warnings: [],
      errors: []
    };

    try {
      // 1. Load agent capabilities
      result.capabilities = this.agentCapabilities;
      console.log(`Agent capabilities loaded: ${result.capabilities.length} capabilities`);

      // 2. Detect available MCPs
      const detectionResults = await this.detector.detectAvailableMCPs();
      result.mcpsDetected = detectionResults.totalDetected;
      result.mcpsAvailable = detectionResults.connected;

      // 3. Map capabilities to available MCPs
      const capabilityMap = await this.buildCapabilityMap();
      
      // 4. Configure fallbacks
      result.fallbacksConfigured = this.configureFallbacks(capabilityMap);

      // 5. Cache MCP status for runtime access
      await this.cacheRuntimeStatus();

      result.success = true;
      this.initialized = true;

      console.log(`MCP integration initialized: ${result.mcpsAvailable}/${result.mcpsDetected} MCPs available`);

    } catch (error) {
      console.error('MCP integration initialization failed:', error.message);
      result.errors.push(error.message);
    }

    result.initializationTime = Date.now() - startTime;
    return result;
  }

  /**
   * Load agent-specific capabilities configuration
   * @param {string} agentName - Agent identifier
   * @returns {Array} Agent capabilities
   */
  loadAgentCapabilities(agentName) {
    // Default capability mappings for known agents
    const agentCapabilityMap = {
      strategist: [
        { name: 'market_research', priority: 'high', mcpPreference: ['firecrawl', 'context7'] },
        { name: 'repository_access', priority: 'high', mcpPreference: ['github'] },
        { name: 'file_operations', priority: 'medium', mcpPreference: ['filesystem'] },
        { name: 'competitive_analysis', priority: 'medium', mcpPreference: ['firecrawl'] }
      ],
      
      analyst: [
        { name: 'data_analytics', priority: 'high', mcpPreference: ['stripe', 'postgres'] },
        { name: 'repository_access', priority: 'high', mcpPreference: ['github'] },
        { name: 'market_research', priority: 'medium', mcpPreference: ['firecrawl'] },
        { name: 'file_operations', priority: 'medium', mcpPreference: ['filesystem'] }
      ],
      
      coordinator: [
        { name: 'project_management', priority: 'high', mcpPreference: ['linear'] },
        { name: 'issue_tracking', priority: 'high', mcpPreference: ['linear', 'github'] },
        { name: 'team_communication', priority: 'medium', mcpPreference: ['slack'] },
        { name: 'file_operations', priority: 'medium', mcpPreference: ['filesystem'] }
      ],
      
      developer: [
        { name: 'repository_access', priority: 'high', mcpPreference: ['github'] },
        { name: 'code_diagnostics', priority: 'high', mcpPreference: ['ide'] },
        { name: 'file_operations', priority: 'high', mcpPreference: ['filesystem'] },
        { name: 'issue_tracking', priority: 'medium', mcpPreference: ['github', 'linear'] }
      ],
      
      'revenue-optimization': [
        { name: 'data_analytics', priority: 'high', mcpPreference: ['stripe'] },
        { name: 'customer_insights', priority: 'high', mcpPreference: ['stripe', 'hubspot'] },
        { name: 'market_research', priority: 'medium', mcpPreference: ['firecrawl'] }
      ],
      
      'market-intelligence': [
        { name: 'market_research', priority: 'high', mcpPreference: ['firecrawl'] },
        { name: 'competitive_analysis', priority: 'high', mcpPreference: ['firecrawl'] },
        { name: 'web_scraping', priority: 'medium', mcpPreference: ['firecrawl'] }
      ],
      
      'customer-success': [
        { name: 'customer_insights', priority: 'high', mcpPreference: ['stripe', 'hubspot'] },
        { name: 'team_communication', priority: 'medium', mcpPreference: ['slack'] },
        { name: 'issue_tracking', priority: 'medium', mcpPreference: ['linear', 'github'] }
      ]
    };

    // Return capabilities for the agent or default set
    return agentCapabilityMap[agentName] || [
      { name: 'file_operations', priority: 'medium', mcpPreference: ['filesystem'] },
      { name: 'repository_access', priority: 'low', mcpPreference: ['github'] }
    ];
  }

  /**
   * Build capability to MCP mapping
   * @returns {Promise<Map>} Capability map
   */
  async buildCapabilityMap() {
    const capabilityMap = new Map();
    
    for (const capability of this.agentCapabilities) {
      const availableMCPs = await this.registryManager.getMCPsForCapability(capability.name);
      
      // Filter by agent preference if specified
      let preferredMCPs = availableMCPs;
      if (capability.mcpPreference && capability.mcpPreference.length > 0) {
        preferredMCPs = availableMCPs.filter(mcp => 
          capability.mcpPreference.includes(mcp.mcpId)
        );
        
        // If no preferred MCPs available, fall back to all available
        if (preferredMCPs.length === 0) {
          preferredMCPs = availableMCPs;
        }
      }
      
      capabilityMap.set(capability.name, {
        ...capability,
        availableMCPs: preferredMCPs,
        bestMCP: preferredMCPs.length > 0 ? preferredMCPs[0] : null,
        fallbackRequired: preferredMCPs.length === 0
      });
    }
    
    return capabilityMap;
  }

  /**
   * Configure fallback strategies
   * @param {Map} capabilityMap - Capability to MCP mapping
   * @returns {number} Number of fallbacks configured
   */
  configureFallbacks(capabilityMap) {
    let fallbacksConfigured = 0;
    
    for (const [capabilityName, capabilityInfo] of capabilityMap) {
      if (capabilityInfo.fallbackRequired || capabilityInfo.availableMCPs.length === 0) {
        console.log(`Fallback required for capability: ${capabilityName}`);
        fallbacksConfigured++;
      }
    }
    
    return fallbacksConfigured;
  }

  /**
   * Cache runtime MCP status for quick access
   */
  async cacheRuntimeStatus() {
    try {
      const healthSummary = await this.registryManager.getHealthSummary();
      const allMCPs = await this.registryManager.getAllMCPs();
      
      this.mcpStatus.clear();
      
      for (const [mcpId, mcpConfig] of Object.entries(allMCPs)) {
        this.mcpStatus.set(mcpId, {
          id: mcpId,
          status: mcpConfig.status,
          capabilities: mcpConfig.capabilities || [],
          responseTime: mcpConfig.metrics?.response_time_ms || null,
          tier: mcpConfig.tier,
          lastCheck: mcpConfig.last_check
        });
      }
      
      console.log(`Cached status for ${this.mcpStatus.size} MCPs`);
      
    } catch (error) {
      console.warn('Failed to cache MCP status:', error.message);
    }
  }

  /**
   * Check if MCP is available for capability
   * @param {string} capability - Capability name
   * @returns {Promise<Object|null>} Available MCP or null
   */
  async getMCPForCapability(capability) {
    if (!this.initialized) {
      console.warn('MCP integration not initialized, initializing now...');
      await this.initialize();
    }

    try {
      const bestMCP = await this.registryManager.getBestMCPForCapability(capability);
      
      if (bestMCP && bestMCP.config.status === 'connected') {
        return {
          mcpId: bestMCP.mcpId,
          name: bestMCP.name,
          status: 'available',
          responseTime: bestMCP.responseTime,
          tier: bestMCP.tier
        };
      }
      
      return null;
      
    } catch (error) {
      console.error(`Error getting MCP for capability ${capability}:`, error.message);
      return null;
    }
  }

  /**
   * Execute operation with MCP and automatic fallback
   * @param {string} capability - Required capability
   * @param {string} operation - Operation to perform
   * @param {Object} params - Operation parameters
   * @param {Object} options - Execution options
   * @returns {Promise<Object>} Execution result
   */
  async executeWithMCP(capability, operation, params = {}, options = {}) {
    if (!this.initialized) {
      await this.initialize();
    }

    console.log(`Agent ${this.agentName} executing ${capability}.${operation}`);
    
    try {
      const result = await this.fallbackOrchestrator.executeWithFallback(
        capability, 
        operation, 
        params, 
        { ...options, agentName: this.agentName }
      );
      
      console.log(`Execution completed via ${result.source} (level ${result.fallbackLevel})`);
      
      return result;
      
    } catch (error) {
      console.error(`Execution failed for ${capability}.${operation}:`, error.message);
      
      return {
        success: false,
        capability,
        operation,
        params,
        error: error.message,
        source: 'error',
        fallbackLevel: 0,
        agentName: this.agentName
      };
    }
  }

  /**
   * Get agent's MCP status summary
   * @returns {Object} Status summary
   */
  getMCPStatus() {
    const summary = {
      agent: this.agentName,
      initialized: this.initialized,
      capabilities: this.agentCapabilities.length,
      mcpsTotal: this.mcpStatus.size,
      mcpsConnected: 0,
      mcpsDegraded: 0,
      mcpsDisconnected: 0,
      capabilityCoverage: new Map()
    };

    // Count MCP statuses
    for (const [mcpId, status] of this.mcpStatus) {
      switch (status.status) {
        case 'connected':
          summary.mcpsConnected++;
          break;
        case 'degraded':
          summary.mcpsDegraded++;
          break;
        default:
          summary.mcpsDisconnected++;
          break;
      }
    }

    // Calculate capability coverage
    for (const capability of this.agentCapabilities) {
      const availableMCPs = Array.from(this.mcpStatus.values()).filter(mcp => 
        mcp.capabilities.some(cap => 
          typeof cap === 'object' ? cap.name === capability.name : cap === capability.name
        ) && mcp.status === 'connected'
      );
      
      summary.capabilityCoverage.set(capability.name, {
        priority: capability.priority,
        mcpsAvailable: availableMCPs.length,
        bestMCP: availableMCPs.length > 0 ? availableMCPs[0].id : null,
        fallbackRequired: availableMCPs.length === 0
      });
    }

    return summary;
  }

  /**
   * Generate MCP integration report for agent
   * @returns {Object} Integration report
   */
  generateIntegrationReport() {
    const status = this.getMCPStatus();
    const report = {
      agent: this.agentName,
      timestamp: new Date().toISOString(),
      status: status,
      recommendations: [],
      issues: [],
      enhancements: []
    };

    // Analyze status and generate recommendations
    const healthyPercentage = status.mcpsTotal > 0 ? 
      (status.mcpsConnected / status.mcpsTotal) * 100 : 0;

    if (healthyPercentage < 50) {
      report.issues.push('Low MCP availability may impact agent performance');
      report.recommendations.push('Run ./scripts/check-mcp-status.sh to diagnose MCP issues');
    }

    // Check capability coverage
    for (const [capability, coverage] of status.capabilityCoverage) {
      if (coverage.fallbackRequired && coverage.priority === 'high') {
        report.issues.push(`High-priority capability '${capability}' has no MCP coverage`);
        report.recommendations.push(`Configure MCP for ${capability} or verify API credentials`);
      }
    }

    // Enhancement suggestions
    if (status.mcpsConnected > 0 && healthyPercentage >= 80) {
      report.enhancements.push('Consider enabling Tier 2 MCPs for enhanced capabilities');
    }

    return report;
  }

  /**
   * Generate agent prompt enhancement for MCP integration
   * @returns {string} Prompt enhancement text
   */
  generatePromptEnhancement() {
    const status = this.getMCPStatus();
    const mcpList = Array.from(this.mcpStatus.entries())
      .filter(([_, status]) => status.status === 'connected')
      .map(([mcpId, _]) => mcpId);

    const promptEnhancement = `
## MCP INTEGRATION STATUS FOR ${this.agentName.toUpperCase()}

**Available MCPs**: ${mcpList.join(', ') || 'None'}
**Capability Coverage**: ${status.capabilities}/${this.agentCapabilities.length} capabilities have MCP support

### MCP-Enhanced Tool Selection:
1. **Primary**: Use available MCP tools when possible
2. **Fallback**: Automatic fallback to Web tools when MCPs unavailable
3. **Manual**: Request user input for critical operations if all automated methods fail

### Your MCP Capabilities:
${this.agentCapabilities.map(cap => {
  const coverage = status.capabilityCoverage.get(cap.name);
  const mcpStatus = coverage && coverage.bestMCP ? '✅' : '⚠️';
  return `- **${cap.name}** (${cap.priority}): ${mcpStatus} ${coverage?.bestMCP || 'Fallback only'}`;
}).join('\n')}

### Usage Instructions:
- Before executing operations, the system will automatically detect available MCPs
- MCPs will be used when available, with intelligent fallback to alternative methods
- No user intervention required - the system handles MCP failures gracefully
- Performance and usage metrics are tracked automatically

**Integration Status**: ${status.mcpsConnected > 0 ? 'Active' : 'Fallback Mode'}
    `;

    return promptEnhancement.trim();
  }

  /**
   * Clean up resources
   */
  cleanup() {
    this.mcpStatus.clear();
    this.initialized = false;
    console.log(`MCP integration cleanup completed for agent: ${this.agentName}`);
  }
}

module.exports = MCPAgentIntegration;