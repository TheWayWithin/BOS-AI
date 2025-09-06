/**
 * BOS-AI MCP Fallback Orchestrator
 * Intelligent multi-tier fallback system for MCP operations
 * Version: 1.0.0
 */

const MCPRegistryManager = require('./registry-manager');
const MCPDetector = require('./detector');

class FallbackOrchestrator {
  constructor() {
    this.registryManager = new MCPRegistryManager();
    this.detector = new MCPDetector();
    this.fallbackMetrics = new Map();
    this.fallbackStrategies = this.initializeFallbackStrategies();
  }

  /**
   * Initialize fallback strategies for common capabilities
   */
  initializeFallbackStrategies() {
    return {
      repository_access: {
        primary: 'github',
        alternatives: ['git_cli'],
        webFallback: {
          type: 'WebFetch',
          baseUrl: 'https://api.github.com',
          authHeader: 'Authorization: token ${GITHUB_TOKEN}',
          rateLimited: true
        },
        manualFallback: 'Please provide repository information manually',
        cache: {
          enabled: true,
          duration: 1800000, // 30 minutes
          path: '/Users/jamiewatters/DevProjects/BOS-AI/workspace/cache/repository'
        }
      },

      market_research: {
        primary: 'firecrawl',
        alternatives: ['context7'],
        webFallback: {
          type: 'WebSearch',
          query: 'market analysis {topic} trends 2024 2025 competitive landscape'
        },
        manualFallback: 'Please provide market research data or reports',
        cache: {
          enabled: true,
          duration: 3600000, // 1 hour
          path: '/Users/jamiewatters/DevProjects/BOS-AI/workspace/cache/market_research'
        }
      },

      data_analytics: {
        primary: 'stripe',
        alternatives: ['postgres'],
        webFallback: {
          type: 'WebFetch',
          baseUrl: 'https://dashboard.stripe.com',
          authHeader: 'Authorization: Bearer ${STRIPE_API_KEY}',
          rateLimited: true
        },
        manualFallback: 'Please export analytics data from your dashboard',
        cache: {
          enabled: true,
          duration: 3600000, // 1 hour
          path: '/Users/jamiewatters/DevProjects/BOS-AI/workspace/cache/analytics'
        }
      },

      file_operations: {
        primary: 'filesystem',
        alternatives: [],
        webFallback: {
          type: 'Direct',
          tool: 'Write'
        },
        manualFallback: 'Please provide file content or perform file operations manually',
        cache: {
          enabled: false
        }
      },

      code_diagnostics: {
        primary: 'ide',
        alternatives: [],
        webFallback: {
          type: 'Direct',
          tool: 'Read'
        },
        manualFallback: 'Please run diagnostics manually and provide results',
        cache: {
          enabled: true,
          duration: 600000, // 10 minutes
          path: '/Users/jamiewatters/DevProjects/BOS-AI/workspace/cache/diagnostics'
        }
      },

      issue_tracking: {
        primary: 'linear',
        alternatives: ['github'],
        webFallback: {
          type: 'WebFetch',
          baseUrl: 'https://api.linear.app/graphql',
          authHeader: 'Authorization: ${LINEAR_API_KEY}'
        },
        manualFallback: 'Please check your project management tool manually',
        cache: {
          enabled: true,
          duration: 1800000, // 30 minutes
          path: '/Users/jamiewatters/DevProjects/BOS-AI/workspace/cache/issues'
        }
      },

      team_communication: {
        primary: 'slack',
        alternatives: [],
        webFallback: {
          type: 'WebFetch',
          baseUrl: 'https://hooks.slack.com/services',
          rateLimited: true
        },
        manualFallback: 'Please send message manually through your communication platform',
        cache: {
          enabled: false
        }
      }
    };
  }

  /**
   * Execute operation with intelligent fallback
   * @param {string} capability - Required capability
   * @param {string} operation - Operation to perform
   * @param {Object} params - Operation parameters
   * @param {Object} options - Execution options
   * @returns {Promise<Object>} Operation result
   */
  async executeWithFallback(capability, operation, params = {}, options = {}) {
    const startTime = Date.now();
    const executionId = `${capability}_${operation}_${Date.now()}`;
    const strategy = this.fallbackStrategies[capability];
    
    if (!strategy) {
      throw new Error(`No fallback strategy defined for capability: ${capability}`);
    }

    console.log(`[${executionId}] Starting fallback execution for ${capability}.${operation}`);

    const result = {
      executionId,
      capability,
      operation,
      params,
      success: false,
      data: null,
      source: null,
      fallbackLevel: 0,
      totalTime: 0,
      attempts: [],
      error: null
    };

    // Level 1: Primary MCP
    try {
      console.log(`[${executionId}] Trying primary MCP: ${strategy.primary}`);
      const primaryResult = await this.tryPrimaryMCP(strategy.primary, operation, params, options);
      
      result.success = true;
      result.data = primaryResult;
      result.source = 'primary_mcp';
      result.fallbackLevel = 1;
      result.attempts.push({
        level: 1,
        method: 'primary_mcp',
        mcpId: strategy.primary,
        success: true,
        responseTime: Date.now() - startTime
      });

      this.trackFallbackUsage(capability, 'primary', true, Date.now() - startTime);
      return result;

    } catch (error) {
      console.warn(`[${executionId}] Primary MCP failed:`, error.message);
      result.attempts.push({
        level: 1,
        method: 'primary_mcp',
        mcpId: strategy.primary,
        success: false,
        error: error.message,
        responseTime: Date.now() - startTime
      });
    }

    // Level 2: Alternative MCPs
    if (strategy.alternatives && strategy.alternatives.length > 0) {
      for (const altMcp of strategy.alternatives) {
        try {
          console.log(`[${executionId}] Trying alternative MCP: ${altMcp}`);
          const altResult = await this.tryAlternativeMCP(altMcp, operation, params, options);
          
          result.success = true;
          result.data = altResult;
          result.source = 'alternative_mcp';
          result.fallbackLevel = 2;
          result.attempts.push({
            level: 2,
            method: 'alternative_mcp',
            mcpId: altMcp,
            success: true,
            responseTime: Date.now() - startTime
          });

          this.trackFallbackUsage(capability, 'alternative', true, Date.now() - startTime);
          return result;

        } catch (error) {
          console.warn(`[${executionId}] Alternative MCP ${altMcp} failed:`, error.message);
          result.attempts.push({
            level: 2,
            method: 'alternative_mcp', 
            mcpId: altMcp,
            success: false,
            error: error.message,
            responseTime: Date.now() - startTime
          });
        }
      }
    }

    // Level 3: Web API Fallback
    if (strategy.webFallback) {
      try {
        console.log(`[${executionId}] Trying web fallback: ${strategy.webFallback.type}`);
        const webResult = await this.tryWebFallback(strategy.webFallback, operation, params, options);
        
        result.success = true;
        result.data = webResult;
        result.source = 'web_fallback';
        result.fallbackLevel = 3;
        result.attempts.push({
          level: 3,
          method: 'web_fallback',
          type: strategy.webFallback.type,
          success: true,
          responseTime: Date.now() - startTime
        });

        this.trackFallbackUsage(capability, 'web', true, Date.now() - startTime);
        return result;

      } catch (error) {
        console.warn(`[${executionId}] Web fallback failed:`, error.message);
        result.attempts.push({
          level: 3,
          method: 'web_fallback',
          type: strategy.webFallback.type,
          success: false,
          error: error.message,
          responseTime: Date.now() - startTime
        });
      }
    }

    // Level 4: Cache Fallback (if enabled)
    if (strategy.cache?.enabled) {
      try {
        console.log(`[${executionId}] Trying cache fallback`);
        const cacheResult = await this.tryCacheFallback(strategy.cache, operation, params, options);
        
        result.success = true;
        result.data = cacheResult;
        result.source = 'cache_fallback';
        result.fallbackLevel = 4;
        result.attempts.push({
          level: 4,
          method: 'cache_fallback',
          success: true,
          responseTime: Date.now() - startTime
        });

        this.trackFallbackUsage(capability, 'cache', true, Date.now() - startTime);
        return result;

      } catch (error) {
        console.warn(`[${executionId}] Cache fallback failed:`, error.message);
        result.attempts.push({
          level: 4,
          method: 'cache_fallback',
          success: false,
          error: error.message,
          responseTime: Date.now() - startTime
        });
      }
    }

    // Level 5: Manual Fallback
    console.log(`[${executionId}] All automated fallbacks failed, requesting manual input`);
    const manualResult = await this.requestManualInput(strategy.manualFallback, operation, params, options);
    
    result.success = manualResult.success || false;
    result.data = manualResult;
    result.source = 'manual_fallback';
    result.fallbackLevel = 5;
    result.attempts.push({
      level: 5,
      method: 'manual_fallback',
      success: result.success,
      responseTime: Date.now() - startTime
    });

    result.totalTime = Date.now() - startTime;
    this.trackFallbackUsage(capability, 'manual', result.success, result.totalTime);
    
    return result;
  }

  /**
   * Try primary MCP execution
   */
  async tryPrimaryMCP(mcpId, operation, params, options) {
    // Check if MCP is available
    const mcpConfig = await this.registryManager.getMCP(mcpId);
    
    if (!mcpConfig || mcpConfig.status !== 'connected') {
      throw new Error(`Primary MCP ${mcpId} is not available (status: ${mcpConfig?.status || 'not found'})`);
    }

    // Simulate MCP execution - in real implementation, this would use the actual MCP client
    console.log(`Executing ${mcpId}.${operation} with params:`, params);
    
    // Mock successful execution
    return {
      success: true,
      data: `Result from ${mcpId}.${operation}`,
      mcpId,
      operation,
      params,
      timestamp: new Date().toISOString()
    };
  }

  /**
   * Try alternative MCP execution
   */
  async tryAlternativeMCP(mcpId, operation, params, options) {
    const mcpConfig = await this.registryManager.getMCP(mcpId);
    
    if (!mcpConfig || mcpConfig.status !== 'connected') {
      throw new Error(`Alternative MCP ${mcpId} is not available`);
    }

    // Mock execution
    return {
      success: true,
      data: `Alternative result from ${mcpId}.${operation}`,
      mcpId,
      operation,
      params,
      timestamp: new Date().toISOString()
    };
  }

  /**
   * Try web API fallback
   */
  async tryWebFallback(fallbackConfig, operation, params, options) {
    const { type, baseUrl, query, tool, authHeader, rateLimited } = fallbackConfig;
    
    switch (type) {
      case 'WebFetch':
        return await this.executeWebFetch(fallbackConfig, operation, params);
      case 'WebSearch':
        return await this.executeWebSearch(fallbackConfig, operation, params);
      case 'Direct':
        return await this.executeDirectTool(fallbackConfig, operation, params);
      default:
        throw new Error(`Unsupported web fallback type: ${type}`);
    }
  }

  async executeWebFetch(config, operation, params) {
    // Build URL with parameters
    const url = this.buildFallbackURL(config.baseUrl, operation, params);
    
    console.log(`WebFetch fallback: ${url}`);
    
    // Mock WebFetch execution
    return {
      success: true,
      data: `WebFetch result for ${operation}`,
      source: 'web_api',
      url,
      timestamp: new Date().toISOString()
    };
  }

  async executeWebSearch(config, operation, params) {
    // Build search query from template
    const query = this.buildSearchQuery(config.query, params);
    
    console.log(`WebSearch fallback: ${query}`);
    
    // Mock WebSearch execution
    return {
      success: true,
      data: `WebSearch result for: ${query}`,
      source: 'web_search',
      query,
      timestamp: new Date().toISOString()
    };
  }

  async executeDirectTool(config, operation, params) {
    const { tool } = config;
    
    console.log(`Direct tool fallback: ${tool}`);
    
    // Mock direct tool execution
    return {
      success: true,
      data: `Direct ${tool} result for ${operation}`,
      source: 'direct_tool',
      tool,
      timestamp: new Date().toISOString()
    };
  }

  /**
   * Try cached data fallback
   */
  async tryCacheFallback(cacheConfig, operation, params, options) {
    const fs = require('fs');
    const path = require('path');
    
    const cacheKey = this.generateCacheKey(operation, params);
    const cachePath = path.join(cacheConfig.path, `${cacheKey}.json`);
    
    try {
      // Ensure cache directory exists
      if (!fs.existsSync(cacheConfig.path)) {
        fs.mkdirSync(cacheConfig.path, { recursive: true });
      }

      // Try to read cached data
      if (fs.existsSync(cachePath)) {
        const cacheData = JSON.parse(fs.readFileSync(cachePath, 'utf8'));
        
        // Check if cache is still valid
        const cacheAge = Date.now() - new Date(cacheData.timestamp).getTime();
        if (cacheAge < cacheConfig.duration) {
          console.log(`Cache hit: ${cacheKey} (age: ${Math.round(cacheAge / 1000)}s)`);
          return {
            ...cacheData.data,
            source: 'cache',
            cacheAge: Math.round(cacheAge / 1000)
          };
        } else {
          console.log(`Cache expired: ${cacheKey} (age: ${Math.round(cacheAge / 1000)}s)`);
          fs.unlinkSync(cachePath); // Remove expired cache
        }
      }
      
      throw new Error('No valid cache found');
      
    } catch (error) {
      throw new Error(`Cache fallback failed: ${error.message}`);
    }
  }

  /**
   * Request manual input from user
   */
  async requestManualInput(message, operation, params, options) {
    console.warn('All automated fallbacks failed, requesting manual input');
    
    const requestId = `manual_${Date.now()}`;
    const requestFile = `/Users/jamiewatters/DevProjects/BOS-AI/workspace/manual-requests/request-${requestId}.json`;
    
    try {
      await this.createManualRequest(requestFile, message, operation, params);
      
      return {
        success: false,
        requiresManualInput: true,
        message: `Manual input required: ${message}`,
        requestFile: requestFile,
        requestId: requestId,
        instructions: this.generateManualInstructions(operation, params),
        timestamp: new Date().toISOString()
      };
    } catch (error) {
      return {
        success: false,
        error: `Failed to create manual request: ${error.message}`,
        message: message,
        timestamp: new Date().toISOString()
      };
    }
  }

  /**
   * Generate manual instructions based on operation
   */
  generateManualInstructions(operation, params) {
    const instructions = {
      market_research: `Please research ${params.topic || 'the specified topic'} and provide:
        1. Market size and growth trends
        2. Key competitors and their positioning
        3. Customer segments and needs
        4. Market opportunities and threats`,
        
      repository_analysis: `Please analyze the repository ${params.repo || 'specified repository'} and provide:
        1. Repository structure and organization
        2. Key technologies and dependencies
        3. Recent activity and contributors
        4. Code quality indicators`,
        
      data_analytics: `Please export analytics data for ${params.period || 'the specified period'} including:
        1. Revenue metrics and trends
        2. Customer acquisition and retention
        3. Product usage statistics
        4. Performance indicators`,
        
      default: `Please complete the ${operation} operation with the provided parameters and return the results in a structured format.`
    };

    return instructions[operation] || instructions.default;
  }

  /**
   * Track fallback usage for optimization
   */
  trackFallbackUsage(capability, level, success, responseTime) {
    const key = `${capability}:${level}`;
    
    if (!this.fallbackMetrics.has(key)) {
      this.fallbackMetrics.set(key, {
        attempts: 0,
        successes: 0,
        totalResponseTime: 0,
        averageResponseTime: 0,
        lastUsed: null,
        errors: []
      });
    }
    
    const metrics = this.fallbackMetrics.get(key);
    metrics.attempts++;
    if (success) metrics.successes++;
    metrics.totalResponseTime += responseTime;
    metrics.averageResponseTime = metrics.totalResponseTime / metrics.attempts;
    metrics.lastUsed = new Date().toISOString();
    
    // Log metrics for analysis
    console.log(`Fallback metrics [${key}]: ${metrics.successes}/${metrics.attempts} success rate, ${Math.round(metrics.averageResponseTime)}ms avg`);
  }

  /**
   * Get fallback performance metrics
   */
  getFallbackMetrics() {
    const metrics = {};
    
    for (const [key, data] of this.fallbackMetrics) {
      const [capability, level] = key.split(':');
      
      if (!metrics[capability]) {
        metrics[capability] = {};
      }
      
      metrics[capability][level] = {
        attempts: data.attempts,
        successes: data.successes,
        successRate: data.attempts > 0 ? Math.round((data.successes / data.attempts) * 100) : 0,
        averageResponseTime: Math.round(data.averageResponseTime),
        lastUsed: data.lastUsed
      };
    }
    
    return metrics;
  }

  // Helper methods
  buildFallbackURL(baseUrl, operation, params) {
    const queryParams = new URLSearchParams();
    Object.entries(params).forEach(([key, value]) => {
      if (value !== undefined && value !== null) {
        queryParams.append(key, String(value));
      }
    });
    
    const queryString = queryParams.toString();
    return queryString ? `${baseUrl}/${operation}?${queryString}` : `${baseUrl}/${operation}`;
  }

  buildSearchQuery(template, params) {
    let query = template;
    Object.entries(params).forEach(([key, value]) => {
      const placeholder = `{${key}}`;
      query = query.replace(new RegExp(placeholder, 'g'), String(value || ''));
    });
    return query;
  }

  resolveAuthHeader(template) {
    return template.replace(/\${([^}]+)}/g, (match, varName) => {
      return process.env[varName] || match;
    });
  }

  generateCacheKey(operation, params) {
    const crypto = require('crypto');
    const content = JSON.stringify({ operation, params }, Object.keys(params).sort());
    return crypto.createHash('md5').update(content).digest('hex');
  }

  async createManualRequest(filePath, message, operation, params) {
    const fs = require('fs');
    const path = require('path');
    
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    const request = {
      timestamp: new Date().toISOString(),
      message,
      operation,
      params,
      instructions: this.generateManualInstructions(operation, params),
      status: 'pending',
      responseFile: filePath.replace('.json', '-response.json')
    };
    
    fs.writeFileSync(filePath, JSON.stringify(request, null, 2));
    console.log(`Manual request created: ${filePath}`);
  }

  /**
   * Clear fallback metrics
   */
  clearMetrics() {
    this.fallbackMetrics.clear();
    console.log('Fallback metrics cleared');
  }
}

module.exports = FallbackOrchestrator;