#!/usr/bin/env node
/**
 * BOS-AI MCP System Test Suite
 * Basic functionality validation for the MCP automation system
 * Version: 1.0.0
 */

const path = require('path');
const fs = require('fs');

// Import our MCP modules
const MCPRegistryManager = require('./src/mcp/registry-manager');
const MCPDetector = require('./src/mcp/detector');
const FallbackOrchestrator = require('./src/mcp/fallback-orchestrator');
const MCPAgentIntegration = require('./src/mcp/agent-integration');

// Test configuration
const TEST_CONFIG = {
  workspaceDir: '/Users/jamiewatters/DevProjects/BOS-AI/workspace',
  registryPath: '/Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-registry.yaml',
  verbose: process.argv.includes('--verbose') || process.argv.includes('-v'),
  quick: process.argv.includes('--quick')
};

// Test results tracking
let testsRun = 0;
let testsPassed = 0;
let testsFailed = 0;
const failedTests = [];

// Logging utilities
const log = (message) => console.log(`[TEST] ${message}`);
const logVerbose = (message) => TEST_CONFIG.verbose && console.log(`[VERBOSE] ${message}`);
const logError = (message) => console.error(`[ERROR] ${message}`);
const logSuccess = (message) => console.log(`[SUCCESS] ${message}`);

// Test assertion utilities
function assert(condition, message) {
  testsRun++;
  if (condition) {
    testsPassed++;
    logVerbose(`✅ PASS: ${message}`);
  } else {
    testsFailed++;
    failedTests.push(message);
    logError(`❌ FAIL: ${message}`);
  }
}

function assertEqual(actual, expected, message) {
  assert(actual === expected, `${message} (expected: ${expected}, actual: ${actual})`);
}

function assertNotNull(value, message) {
  assert(value !== null && value !== undefined, `${message} (value was ${value})`);
}

function assertTrue(condition, message) {
  assert(condition === true, message);
}

// Test suite functions
async function testRegistryManager() {
  log('Testing MCP Registry Manager...');
  
  try {
    const registry = new MCPRegistryManager(TEST_CONFIG.registryPath);
    
    // Test 1: Registry loading
    const registryData = await registry.loadRegistry();
    assertNotNull(registryData, 'Registry data should be loaded');
    assertNotNull(registryData.version, 'Registry should have version');
    assertEqual(registryData.version, '1.0', 'Registry version should be 1.0');
    
    // Test 2: Registry validation
    assertTrue(typeof registryData.metadata === 'object', 'Registry should have metadata');
    assertTrue(typeof registryData.registry === 'object', 'Registry should have registry section');
    
    // Test 3: Adding MCP entry
    const testMCP = {
      name: 'Test MCP',
      status: 'connected',
      tier: 1,
      capabilities: [{ name: 'test_capability', operations: ['test'] }]
    };
    
    await registry.addOrUpdateMCP('test-mcp', testMCP);
    
    const retrievedMCP = await registry.getMCP('test-mcp');
    assertNotNull(retrievedMCP, 'Added MCP should be retrievable');
    assertEqual(retrievedMCP.name, 'Test MCP', 'Retrieved MCP should have correct name');
    
    // Test 4: Health summary
    const healthSummary = await registry.getHealthSummary();
    assertNotNull(healthSummary, 'Health summary should be available');
    assertTrue(typeof healthSummary.total === 'number', 'Health summary should have total count');
    
    // Test 5: Capability search
    const mcpsForCapability = await registry.getMCPsForCapability('test_capability');
    assertTrue(Array.isArray(mcpsForCapability), 'Should return array for capability search');
    
    // Cleanup
    await registry.removeMCP('test-mcp');
    
    logSuccess('Registry Manager tests completed');
    
  } catch (error) {
    logError(`Registry Manager test failed: ${error.message}`);
    assert(false, `Registry Manager should not throw errors: ${error.message}`);
  }
}

async function testMCPDetector() {
  log('Testing MCP Detector...');
  
  try {
    const detector = new MCPDetector();
    
    // Test 1: Detector initialization
    assertNotNull(detector, 'Detector should be created');
    assertTrue(typeof detector.detectAvailableMCPs === 'function', 'Detector should have detectAvailableMCPs method');
    
    // Test 2: Default MCPs
    const defaultMCPs = detector.getDefaultMCPs();
    assertTrue(Array.isArray(defaultMCPs), 'Should return array of default MCPs');
    assertTrue(defaultMCPs.length > 0, 'Should have at least one default MCP');
    
    // Test 3: MCP capabilities
    const githubCapabilities = detector.getDefaultCapabilities('github');
    assertTrue(Array.isArray(githubCapabilities), 'Should return array of capabilities');
    assertTrue(githubCapabilities.length > 0, 'GitHub should have capabilities');
    
    // Test 4: MCP tier determination
    const githubTier = detector.determineMCPTier('github');
    assertEqual(githubTier, 1, 'GitHub should be Tier 1');
    
    const stripeTier = detector.determineMCPTier('stripe');
    assertEqual(stripeTier, 2, 'Stripe should be Tier 2');
    
    // Test 5: MCP priority
    const githubPriority = detector.getMCPPriority('github');
    assertTrue(githubPriority > 0, 'GitHub should have positive priority');
    
    // Test 6: Cache operations
    const cacheStats = detector.getCacheStats();
    assertNotNull(cacheStats, 'Should return cache statistics');
    assertTrue(typeof cacheStats.entries === 'number', 'Cache stats should have entries count');
    
    // Only run detection if not in quick mode (it's slow)
    if (!TEST_CONFIG.quick) {
      const detectionResults = await detector.detectAvailableMCPs();
      assertNotNull(detectionResults, 'Detection should return results');
      assertTrue(typeof detectionResults.totalDetected === 'number', 'Should have total count');
    }
    
    logSuccess('MCP Detector tests completed');
    
  } catch (error) {
    logError(`MCP Detector test failed: ${error.message}`);
    assert(false, `MCP Detector should not throw errors: ${error.message}`);
  }
}

async function testFallbackOrchestrator() {
  log('Testing Fallback Orchestrator...');
  
  try {
    const orchestrator = new FallbackOrchestrator();
    
    // Test 1: Orchestrator initialization
    assertNotNull(orchestrator, 'Orchestrator should be created');
    assertTrue(typeof orchestrator.executeWithFallback === 'function', 'Should have executeWithFallback method');
    
    // Test 2: Fallback strategies
    assertTrue(typeof orchestrator.fallbackStrategies === 'object', 'Should have fallback strategies');
    assertNotNull(orchestrator.fallbackStrategies.repository_access, 'Should have repository_access strategy');
    assertNotNull(orchestrator.fallbackStrategies.market_research, 'Should have market_research strategy');
    
    // Test 3: Helper methods
    const testUrl = orchestrator.buildFallbackURL('https://api.example.com', 'test', { param1: 'value1' });
    assertTrue(testUrl.includes('api.example.com'), 'Should build correct URL');
    assertTrue(testUrl.includes('param1=value1'), 'Should include parameters');
    
    const testQuery = orchestrator.buildSearchQuery('search for {topic}', { topic: 'test' });
    assertEqual(testQuery, 'search for test', 'Should replace query parameters');
    
    // Test 4: Cache key generation
    const cacheKey = orchestrator.generateCacheKey('test_operation', { param: 'value' });
    assertTrue(typeof cacheKey === 'string', 'Should generate string cache key');
    assertTrue(cacheKey.length > 0, 'Cache key should not be empty');
    
    // Test 5: Fallback metrics
    orchestrator.trackFallbackUsage('test_capability', 'primary', true, 100);
    const metrics = orchestrator.getFallbackMetrics();
    assertNotNull(metrics, 'Should return fallback metrics');
    assertNotNull(metrics.test_capability, 'Should have metrics for test capability');
    
    // Only run full execution test if not in quick mode
    if (!TEST_CONFIG.quick) {
      logVerbose('Testing fallback execution (this may take time)...');
      const result = await orchestrator.executeWithFallback('market_research', 'test_operation', { topic: 'test' });
      assertNotNull(result, 'Should return execution result');
      assertTrue(typeof result.success === 'boolean', 'Result should have success flag');
    }
    
    logSuccess('Fallback Orchestrator tests completed');
    
  } catch (error) {
    logError(`Fallback Orchestrator test failed: ${error.message}`);
    assert(false, `Fallback Orchestrator should not throw errors: ${error.message}`);
  }
}

async function testAgentIntegration() {
  log('Testing Agent Integration...');
  
  try {
    const integration = new MCPAgentIntegration('test-agent');
    
    // Test 1: Integration initialization
    assertNotNull(integration, 'Integration should be created');
    assertEqual(integration.agentName, 'test-agent', 'Should set agent name correctly');
    
    // Test 2: Agent capabilities loading
    assertTrue(Array.isArray(integration.agentCapabilities), 'Should load agent capabilities');
    assertTrue(integration.agentCapabilities.length > 0, 'Should have at least one capability');
    
    // Test 3: Known agent capabilities
    const strategistIntegration = new MCPAgentIntegration('strategist');
    const strategistCapabilities = strategistIntegration.agentCapabilities;
    assertTrue(strategistCapabilities.length > 2, 'Strategist should have multiple capabilities');
    
    const hasMarketResearch = strategistCapabilities.some(cap => cap.name === 'market_research');
    assertTrue(hasMarketResearch, 'Strategist should have market research capability');
    
    // Test 4: MCP status tracking
    const status = integration.getMCPStatus();
    assertNotNull(status, 'Should return MCP status');
    assertEqual(status.agent, 'test-agent', 'Status should have correct agent name');
    assertTrue(typeof status.capabilities === 'number', 'Should have capabilities count');
    
    // Test 5: Integration report
    const report = integration.generateIntegrationReport();
    assertNotNull(report, 'Should generate integration report');
    assertEqual(report.agent, 'test-agent', 'Report should have correct agent name');
    assertTrue(Array.isArray(report.recommendations), 'Should have recommendations array');
    
    // Test 6: Prompt enhancement
    const promptEnhancement = integration.generatePromptEnhancement();
    assertTrue(typeof promptEnhancement === 'string', 'Should generate prompt enhancement');
    assertTrue(promptEnhancement.includes('MCP INTEGRATION'), 'Should contain integration header');
    assertTrue(promptEnhancement.includes('TEST-AGENT'), 'Should contain agent name');
    
    // Only run full initialization if not in quick mode
    if (!TEST_CONFIG.quick) {
      logVerbose('Testing full agent initialization (this may take time)...');
      const initResult = await integration.initialize();
      assertNotNull(initResult, 'Should return initialization result');
      assertTrue(typeof initResult.success === 'boolean', 'Should have success flag');
      assertTrue(initResult.agent === 'test-agent', 'Should have correct agent name');
    }
    
    logSuccess('Agent Integration tests completed');
    
  } catch (error) {
    logError(`Agent Integration test failed: ${error.message}`);
    assert(false, `Agent Integration should not throw errors: ${error.message}`);
  }
}

async function testFileSystem() {
  log('Testing File System Setup...');
  
  try {
    // Test 1: Workspace directory structure
    assertTrue(fs.existsSync(TEST_CONFIG.workspaceDir), 'Workspace directory should exist');
    assertTrue(fs.existsSync(path.join(TEST_CONFIG.workspaceDir, 'config')), 'Config directory should exist');
    assertTrue(fs.existsSync(path.join(TEST_CONFIG.workspaceDir, 'logs')), 'Logs directory should exist');
    assertTrue(fs.existsSync(path.join(TEST_CONFIG.workspaceDir, 'cache')), 'Cache directory should exist');
    
    // Test 2: Required files
    assertTrue(fs.existsSync(TEST_CONFIG.registryPath), 'Registry file should exist');
    
    const envTemplate = '/Users/jamiewatters/DevProjects/BOS-AI/.env.mcp-template';
    assertTrue(fs.existsSync(envTemplate), 'Environment template should exist');
    
    // Test 3: Scripts
    const installScript = '/Users/jamiewatters/DevProjects/BOS-AI/scripts/install-bos-ai-mcps.sh';
    assertTrue(fs.existsSync(installScript), 'Installation script should exist');
    
    const healthScript = '/Users/jamiewatters/DevProjects/BOS-AI/scripts/check-mcp-status.sh';
    assertTrue(fs.existsSync(healthScript), 'Health check script should exist');
    
    // Test 4: File permissions (Unix-like systems)
    if (process.platform !== 'win32') {
      const installStats = fs.statSync(installScript);
      assertTrue((installStats.mode & parseInt('111', 8)) > 0, 'Installation script should be executable');
      
      const healthStats = fs.statSync(healthScript);
      assertTrue((healthStats.mode & parseInt('111', 8)) > 0, 'Health check script should be executable');
    }
    
    logSuccess('File System tests completed');
    
  } catch (error) {
    logError(`File System test failed: ${error.message}`);
    assert(false, `File System setup should be correct: ${error.message}`);
  }
}

async function testYAMLRegistryParsing() {
  log('Testing YAML Registry Parsing...');
  
  try {
    // Test that the default registry file is valid YAML and has expected structure
    const yaml = require('js-yaml');
    const registryContent = fs.readFileSync(TEST_CONFIG.registryPath, 'utf8');
    
    // Test 1: Valid YAML
    const registryData = yaml.load(registryContent);
    assertNotNull(registryData, 'Registry should parse as valid YAML');
    
    // Test 2: Required sections
    assertNotNull(registryData.version, 'Registry should have version');
    assertNotNull(registryData.metadata, 'Registry should have metadata');
    assertNotNull(registryData.registry, 'Registry should have registry section');
    
    // Test 3: Metadata structure
    assertNotNull(registryData.metadata.registry_format_version, 'Should have format version');
    assertNotNull(registryData.metadata.created, 'Should have creation date');
    
    // Test 4: Registry entries
    const registryEntries = Object.keys(registryData.registry);
    assertTrue(registryEntries.length > 0, 'Should have at least one registry entry');
    
    // Test 5: Required MCP structure
    for (const mcpId of registryEntries) {
      const mcpConfig = registryData.registry[mcpId];
      assertNotNull(mcpConfig.name, `MCP ${mcpId} should have name`);
      assertNotNull(mcpConfig.tier, `MCP ${mcpId} should have tier`);
      assertTrue([1, 2, 3].includes(mcpConfig.tier), `MCP ${mcpId} should have valid tier (1-3)`);
      
      if (mcpConfig.capabilities) {
        assertTrue(Array.isArray(mcpConfig.capabilities), `MCP ${mcpId} capabilities should be array`);
      }
    }
    
    // Test 6: Specific MCP configurations
    if (registryData.registry.github) {
      const github = registryData.registry.github;
      assertEqual(github.tier, 1, 'GitHub should be Tier 1');
      assertTrue(github.capabilities.length > 0, 'GitHub should have capabilities');
      assertNotNull(github.auth, 'GitHub should have auth configuration');
    }
    
    logSuccess('YAML Registry Parsing tests completed');
    
  } catch (error) {
    logError(`YAML Registry Parsing test failed: ${error.message}`);
    assert(false, `Registry YAML should be valid: ${error.message}`);
  }
}

// Main test runner
async function runTests() {
  console.log('🧪 BOS-AI MCP System Test Suite v1.0.0');
  console.log('==========================================');
  
  if (TEST_CONFIG.quick) {
    console.log('⚡ Running in quick mode (skipping slow tests)');
  }
  
  if (TEST_CONFIG.verbose) {
    console.log('🔍 Verbose mode enabled');
  }
  
  console.log('');
  
  const startTime = Date.now();
  
  try {
    // Run all test suites
    await testFileSystem();
    await testYAMLRegistryParsing();
    await testRegistryManager();
    await testMCPDetector();
    await testFallbackOrchestrator();
    await testAgentIntegration();
    
  } catch (error) {
    logError(`Unexpected test suite error: ${error.message}`);
    testsFailed++;
  }
  
  const endTime = Date.now();
  const duration = (endTime - startTime) / 1000;
  
  // Display results
  console.log('');
  console.log('📊 Test Results Summary');
  console.log('=======================');
  console.log(`Total Tests: ${testsRun}`);
  console.log(`Passed: ${testsPassed}`);
  console.log(`Failed: ${testsFailed}`);
  console.log(`Duration: ${duration.toFixed(2)}s`);
  console.log('');
  
  if (testsFailed > 0) {
    console.log('❌ Failed Tests:');
    failedTests.forEach(test => console.log(`  - ${test}`));
    console.log('');
    process.exit(1);
  } else {
    console.log('✅ All tests passed!');
    console.log('');
    console.log('🎉 BOS-AI MCP System is ready for use!');
    console.log('');
    console.log('Next steps:');
    console.log('1. Run: ./scripts/install-bos-ai-mcps.sh');
    console.log('2. Test: ./scripts/check-mcp-status.sh');
    console.log('3. Configure API keys in .env file');
    process.exit(0);
  }
}

// Handle uncaught errors
process.on('unhandledRejection', (error) => {
  logError(`Unhandled rejection: ${error.message}`);
  process.exit(1);
});

process.on('uncaughtException', (error) => {
  logError(`Uncaught exception: ${error.message}`);
  process.exit(1);
});

// Run tests if this file is executed directly
if (require.main === module) {
  runTests().catch(error => {
    logError(`Test runner failed: ${error.message}`);
    process.exit(1);
  });
}

module.exports = { runTests, TEST_CONFIG };