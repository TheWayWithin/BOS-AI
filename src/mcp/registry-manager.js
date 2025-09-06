/**
 * BOS-AI MCP Registry Manager
 * Core component for MCP registry operations, status tracking, and capability mapping
 * Version: 1.0.0
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

class MCPRegistryManager {
  constructor(registryPath = '/Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-registry.yaml') {
    this.registryPath = registryPath;
    this.cache = new Map();
    this.cacheTimeout = 60000; // 1 minute
    this.lastModified = null;
  }

  /**
   * Load and parse MCP registry with caching
   * @returns {Promise<Object>} Parsed registry object
   */
  async loadRegistry() {
    try {
      // Check if file exists
      if (!fs.existsSync(this.registryPath)) {
        console.warn(`Registry file not found: ${this.registryPath}`);
        return this.createDefaultRegistry();
      }

      // Check file modification time for cache invalidation
      const stats = fs.statSync(this.registryPath);
      const currentModified = stats.mtime.getTime();

      // Return cached version if still valid
      if (this.cache.has('registry') && this.lastModified === currentModified) {
        const cached = this.cache.get('registry');
        if (Date.now() - cached.timestamp < this.cacheTimeout) {
          return cached.data;
        }
      }

      // Read and parse registry file
      const registryContent = fs.readFileSync(this.registryPath, 'utf8');
      const registry = yaml.load(registryContent);
      
      // Validate registry format
      this.validateRegistry(registry);
      
      // Update cache
      this.cache.set('registry', {
        data: registry,
        timestamp: Date.now()
      });
      this.lastModified = currentModified;
      
      console.log(`Registry loaded: ${Object.keys(registry.registry || {}).length} MCPs`);
      return registry;

    } catch (error) {
      console.error('Failed to load registry:', error.message);
      
      // Return default registry on error
      console.log('Creating default registry due to error');
      return this.createDefaultRegistry();
    }
  }

  /**
   * Create default registry structure
   * @returns {Object} Default registry object
   */
  createDefaultRegistry() {
    const defaultRegistry = {
      version: "1.0",
      metadata: {
        registry_format_version: "1.0.0",
        created: new Date().toISOString(),
        last_updated: new Date().toISOString(),
        update_frequency: 300,
        health_check_interval: 300
      },
      registry: {}
    };

    return defaultRegistry;
  }

  /**
   * Get available MCPs for specific capability
   * @param {string} capability - Required capability name
   * @param {number[]} preferredTiers - Preferred tier priorities [1, 2, 3]
   * @returns {Promise<Array>} Array of matching MCP configurations
   */
  async getMCPsForCapability(capability, preferredTiers = [1, 2, 3]) {
    try {
      const registry = await this.loadRegistry();
      const matchingMCPs = [];
      
      for (const [mcpId, config] of Object.entries(registry.registry || {})) {
        // Skip if MCP is not connected
        if (config.status !== 'connected') {
          continue;
        }
        
        // Skip if tier not preferred
        if (!preferredTiers.includes(config.tier)) {
          continue;
        }
        
        // Check if MCP has the required capability
        const hasCapability = config.capabilities && config.capabilities.some(cap => 
          typeof cap === 'object' ? cap.name === capability : cap === capability
        );
        
        if (hasCapability) {
          matchingMCPs.push({
            mcpId,
            name: config.name,
            priority: config.priority || 0,
            tier: config.tier,
            responseTime: config.metrics?.response_time_ms || Infinity,
            successRate: config.metrics?.success_rate_24h || 0,
            config: config
          });
        }
      }
      
      // Sort by priority (descending), then tier (ascending), then response time (ascending)
      return matchingMCPs.sort((a, b) => {
        if (a.priority !== b.priority) return b.priority - a.priority;
        if (a.tier !== b.tier) return a.tier - b.tier;
        return a.responseTime - b.responseTime;
      });

    } catch (error) {
      console.error(`Error getting MCPs for capability ${capability}:`, error.message);
      return [];
    }
  }

  /**
   * Get single best MCP for capability
   * @param {string} capability - Required capability name
   * @param {number[]} preferredTiers - Preferred tier priorities
   * @returns {Promise<Object|null>} Best MCP configuration or null
   */
  async getBestMCPForCapability(capability, preferredTiers = [1, 2, 3]) {
    const mcps = await this.getMCPsForCapability(capability, preferredTiers);
    return mcps.length > 0 ? mcps[0] : null;
  }

  /**
   * Update MCP status in registry
   * @param {string} mcpId - MCP identifier
   * @param {Object} statusUpdate - Status update object
   */
  async updateMCPStatus(mcpId, statusUpdate) {
    try {
      const registry = await this.loadRegistry();
      
      if (!registry.registry[mcpId]) {
        console.warn(`MCP '${mcpId}' not found in registry, creating entry`);
        registry.registry[mcpId] = {
          name: mcpId,
          status: 'unknown',
          tier: 3,
          capabilities: []
        };
      }
      
      // Update status fields
      const currentTime = new Date().toISOString();
      Object.assign(registry.registry[mcpId], {
        ...statusUpdate,
        last_check: currentTime
      });

      // Update consecutive failure count
      if (statusUpdate.status === 'connected') {
        registry.registry[mcpId].consecutive_failures = 0;
        registry.registry[mcpId].last_success = currentTime;
      } else if (statusUpdate.status === 'disconnected' || statusUpdate.status === 'error') {
        registry.registry[mcpId].consecutive_failures = (registry.registry[mcpId].consecutive_failures || 0) + 1;
        registry.registry[mcpId].last_failure = currentTime;
      }
      
      // Update registry metadata
      registry.metadata.last_updated = currentTime;
      
      // Save registry
      await this.saveRegistry(registry);
      
      console.log(`MCP status updated: ${mcpId} -> ${statusUpdate.status}`);
      
    } catch (error) {
      console.error(`Failed to update MCP status for ${mcpId}:`, error.message);
    }
  }

  /**
   * Add or update MCP entry in registry
   * @param {string} mcpId - MCP identifier  
   * @param {Object} mcpConfig - Complete MCP configuration
   */
  async addOrUpdateMCP(mcpId, mcpConfig) {
    try {
      const registry = await this.loadRegistry();
      
      // Validate MCP configuration
      this.validateMCPConfig(mcpId, mcpConfig);
      
      // Add/update MCP entry
      registry.registry[mcpId] = {
        ...mcpConfig,
        last_check: new Date().toISOString()
      };
      
      // Update registry metadata
      registry.metadata.last_updated = new Date().toISOString();
      
      // Save registry
      await this.saveRegistry(registry);
      
      console.log(`MCP added/updated: ${mcpId}`);
      
    } catch (error) {
      console.error(`Failed to add/update MCP ${mcpId}:`, error.message);
      throw error;
    }
  }

  /**
   * Get registry health summary
   * @returns {Promise<Object>} Health summary object
   */
  async getHealthSummary() {
    try {
      const registry = await this.loadRegistry();
      const mcps = Object.values(registry.registry || {});
      
      const summary = {
        total: mcps.length,
        connected: 0,
        disconnected: 0,
        degraded: 0,
        unknown: 0,
        tier1: { total: 0, connected: 0 },
        tier2: { total: 0, connected: 0 },
        tier3: { total: 0, connected: 0 },
        lastUpdate: registry.metadata?.last_updated
      };
      
      mcps.forEach(mcp => {
        // Count by status
        summary[mcp.status] = (summary[mcp.status] || 0) + 1;
        
        // Count by tier
        const tier = mcp.tier || 3;
        const tierKey = `tier${tier}`;
        if (summary[tierKey]) {
          summary[tierKey].total++;
          if (mcp.status === 'connected') {
            summary[tierKey].connected++;
          }
        }
      });
      
      // Calculate overall health
      const healthyCount = summary.connected + summary.degraded;
      summary.healthPercentage = summary.total > 0 ? 
        Math.round((healthyCount / summary.total) * 100) : 0;
      
      summary.overallStatus = 
        summary.tier1.connected >= 2 ? 'healthy' :
        summary.tier1.connected >= 1 ? 'degraded' : 'critical';
      
      return summary;
      
    } catch (error) {
      console.error('Failed to get health summary:', error.message);
      return {
        total: 0,
        connected: 0,
        overallStatus: 'unknown',
        error: error.message
      };
    }
  }

  /**
   * Validate registry structure and content
   * @param {Object} registry - Registry object to validate
   */
  validateRegistry(registry) {
    if (!registry || typeof registry !== 'object') {
      throw new Error('Registry must be an object');
    }
    
    if (!registry.version) {
      throw new Error('Registry missing version field');
    }
    
    if (!registry.metadata || !registry.metadata.registry_format_version) {
      throw new Error('Registry missing required metadata');
    }
    
    if (!registry.registry || typeof registry.registry !== 'object') {
      throw new Error('Registry missing registry section');
    }
    
    // Validate each MCP entry
    for (const [mcpId, config] of Object.entries(registry.registry)) {
      try {
        this.validateMCPConfig(mcpId, config);
      } catch (error) {
        console.warn(`MCP ${mcpId} validation warning:`, error.message);
        // Don't fail the entire registry for individual MCP issues
      }
    }
  }

  /**
   * Validate individual MCP configuration
   * @param {string} mcpId - MCP identifier
   * @param {Object} config - MCP configuration object
   */
  validateMCPConfig(mcpId, config) {
    const required = ['name', 'status'];
    
    for (const field of required) {
      if (!config[field]) {
        throw new Error(`MCP '${mcpId}' missing required field: ${field}`);
      }
    }
    
    if (config.transport && !['stdio', 'http', 'sse'].includes(config.transport)) {
      throw new Error(`MCP '${mcpId}' has invalid transport: ${config.transport}`);
    }
    
    if (config.tier && ![1, 2, 3].includes(config.tier)) {
      throw new Error(`MCP '${mcpId}' has invalid tier: ${config.tier}`);
    }

    if (config.status && !['connected', 'disconnected', 'degraded', 'unknown', 'error'].includes(config.status)) {
      throw new Error(`MCP '${mcpId}' has invalid status: ${config.status}`);
    }
  }

  /**
   * Save registry to file
   * @param {Object} registry - Registry object to save
   */
  async saveRegistry(registry) {
    try {
      // Create backup before saving
      await this.createBackup();
      
      const yamlContent = yaml.dump(registry, {
        indent: 2,
        lineWidth: 120,
        sortKeys: false
      });
      
      // Ensure directory exists
      const dir = path.dirname(this.registryPath);
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
      }
      
      fs.writeFileSync(this.registryPath, yamlContent, 'utf8');
      
      // Clear cache to force reload
      this.cache.delete('registry');
      this.lastModified = null;
      
    } catch (error) {
      console.error('Failed to save registry:', error.message);
      throw error;
    }
  }

  /**
   * Create backup of current registry
   */
  async createBackup() {
    if (fs.existsSync(this.registryPath)) {
      try {
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
        const backupDir = path.join(path.dirname(this.registryPath), 'backup');
        const backupPath = path.join(backupDir, `mcp-registry-${timestamp}.yaml`);
        
        // Ensure backup directory exists
        if (!fs.existsSync(backupDir)) {
          fs.mkdirSync(backupDir, { recursive: true });
        }
        
        fs.copyFileSync(this.registryPath, backupPath);
        console.log(`Registry backup created: ${backupPath}`);
        
      } catch (error) {
        console.warn('Failed to create registry backup:', error.message);
      }
    }
  }

  /**
   * Get all registered MCPs
   * @returns {Promise<Object>} Registry entries
   */
  async getAllMCPs() {
    const registry = await this.loadRegistry();
    return registry.registry || {};
  }

  /**
   * Check if MCP exists in registry
   * @param {string} mcpId - MCP identifier
   * @returns {Promise<boolean>} True if MCP exists
   */
  async hasMCP(mcpId) {
    const registry = await this.loadRegistry();
    return !!(registry.registry && registry.registry[mcpId]);
  }

  /**
   * Get MCP configuration by ID
   * @param {string} mcpId - MCP identifier
   * @returns {Promise<Object|null>} MCP configuration or null
   */
  async getMCP(mcpId) {
    const registry = await this.loadRegistry();
    return registry.registry ? registry.registry[mcpId] || null : null;
  }

  /**
   * Remove MCP from registry
   * @param {string} mcpId - MCP identifier
   */
  async removeMCP(mcpId) {
    try {
      const registry = await this.loadRegistry();
      
      if (registry.registry && registry.registry[mcpId]) {
        delete registry.registry[mcpId];
        registry.metadata.last_updated = new Date().toISOString();
        await this.saveRegistry(registry);
        console.log(`MCP removed: ${mcpId}`);
      } else {
        console.warn(`MCP not found for removal: ${mcpId}`);
      }
      
    } catch (error) {
      console.error(`Failed to remove MCP ${mcpId}:`, error.message);
      throw error;
    }
  }
}

module.exports = MCPRegistryManager;