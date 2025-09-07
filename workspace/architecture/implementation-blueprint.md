# BOS-AI MCP Automation - Implementation Blueprint

**Document Version:** 1.0  
**Created:** January 6, 2025  
**Owner:** Architect Agent  
**Status:** Ready for Development  

## Implementation Overview

This blueprint provides the concrete development plan for implementing the BOS-AI MCP automation system, including directory structures, file specifications, development phases, and detailed task breakdowns.

## Directory Structure

```
/workspace/
├── config/                           # Configuration & Registry
│   ├── mcp-registry.yaml            # Main MCP registry (generated)
│   ├── mcp-config.yaml              # User preferences (optional)
│   ├── mcp-status.yaml              # Runtime status (generated)
│   ├── mcp-templates/               # MCP configuration templates
│   │   ├── github-template.yaml
│   │   ├── stripe-template.yaml
│   │   └── tier1-defaults.yaml
│   └── backup/                       # Configuration backups
│
├── scripts/                          # Installation & Management Scripts
│   ├── install-mcps.sh              # Master installation script
│   ├── mcp-health-check.sh          # Health monitoring script
│   ├── update-registry.sh           # Registry update automation
│   ├── mcp-diagnostics.sh           # Troubleshooting utilities
│   └── utils/                        # Script utilities
│       ├── logging.sh               # Shared logging functions
│       ├── validation.sh            # Configuration validation
│       └── backup.sh                # Backup utilities
│
├── lib/                              # Core Libraries
│   ├── mcp-detection.js             # MCP discovery & detection
│   ├── connection-manager.js        # Connection pooling & management
│   ├── fallback-orchestrator.js     # Intelligent fallback system
│   ├── registry-manager.js          # Registry operations
│   ├── health-monitor.js            # Health checking service
│   ├── metrics-collector.js         # Performance metrics
│   └── utils/                        # Library utilities
│       ├── logger.js                # Structured logging
│       ├── cache.js                 # Caching utilities
│       └── crypto.js                # Credential encryption
│
├── agents/                           # Agent Integration Updates
│   ├── integration/                  # MCP integration templates
│   │   ├── mcp-detection-template.md # Standard MCP detection protocol
│   │   ├── fallback-template.md     # Standard fallback protocol
│   │   └── error-handling-template.md # Standard error handling
│   ├── updated/                      # Updated agent files
│   │   ├── strategist-mcp.md        # Strategist with MCP integration
│   │   ├── analyst-mcp.md           # Analyst with MCP integration
│   │   └── coordinator-mcp.md       # Coordinator with MCP integration
│   └── patches/                      # Agent modification patches
│       ├── strategist.patch
│       ├── analyst.patch
│       └── coordinator.patch
│
├── logs/                             # Logging & Monitoring
│   ├── mcp-install.log              # Installation logs (generated)
│   ├── mcp-health.log               # Health check logs (generated)
│   ├── mcp-failures.log             # Error tracking (generated)
│   ├── mcp-performance.log          # Performance metrics (generated)
│   └── archive/                      # Log rotation storage
│
├── cache/                            # Caching & Performance
│   ├── registry/                     # Registry cache
│   ├── connections/                  # Connection cache
│   ├── responses/                    # Response cache
│   └── metrics/                      # Metrics cache
│
├── tests/                            # Testing Infrastructure
│   ├── unit/                         # Unit tests
│   │   ├── registry-manager.test.js
│   │   ├── connection-manager.test.js
│   │   └── fallback-orchestrator.test.js
│   ├── integration/                  # Integration tests
│   │   ├── mcp-installation.test.sh
│   │   ├── agent-integration.test.js
│   │   └── fallback-scenarios.test.js
│   ├── performance/                  # Performance tests
│   │   ├── load-test.js
│   │   └── connection-stress.test.js
│   ├── fixtures/                     # Test data
│   │   ├── mock-registry.yaml
│   │   ├── test-mcps/
│   │   └── test-scenarios.json
│   └── mocks/                        # Mock MCPs for testing
│       ├── mock-github.js
│       ├── mock-stripe.js
│       └── mock-failing.js
│
├── docs/                             # Documentation
│   ├── installation-guide.md        # User installation guide
│   ├── troubleshooting.md           # Common issues & solutions
│   ├── api-reference.md             # API documentation
│   ├── agent-integration-guide.md   # Guide for agent developers
│   └── architecture-decisions.md    # ADRs and design decisions
│
└── tools/                            # Development Tools
    ├── mcp-analyzer.js              # MCP capability analyzer
    ├── registry-validator.js        # Registry validation tool
    ├── performance-profiler.js      # Performance analysis
    └── diagnostic-reporter.js       # System diagnostic tool
```

## Phase 1 Implementation Plan (Week 1)

### Phase 1 Goals
- Foundation components operational
- Tier 1 MCPs (GitHub, Filesystem, IDE) automated installation  
- Basic agent integration for 3 priority agents
- Core fallback system functional

### Phase 1 Tasks & Timeline

#### Day 1: Core Infrastructure
```yaml
tasks:
  - name: "Create directory structure"
    deliverables:
      - "/workspace/config/ directory with templates"
      - "/workspace/scripts/ directory with utilities"
      - "/workspace/lib/ directory structure"
    time_estimate: "2 hours"
    
  - name: "Implement registry manager"
    deliverables:
      - "lib/registry-manager.js with YAML parsing"
      - "Basic registry validation"
      - "Registry update mechanisms"
    time_estimate: "4 hours"
    
  - name: "Create logging infrastructure"
    deliverables:
      - "lib/utils/logger.js with structured logging"
      - "scripts/utils/logging.sh for bash scripts"
      - "Log rotation and archiving"
    time_estimate: "2 hours"
```

#### Day 2: Installation System  
```yaml
tasks:
  - name: "Master installation script"
    deliverables:
      - "scripts/install-mcps.sh with error handling"
      - "Tier 1 MCP installation logic"  
      - "Backup and rollback mechanisms"
    time_estimate: "6 hours"
    
  - name: "Registry generation"
    deliverables:
      - "scripts/update-registry.sh"
      - "MCP capability detection"
      - "Status tracking integration"
    time_estimate: "2 hours"
```

#### Day 3: Health Monitoring
```yaml
tasks:
  - name: "Health check system"
    deliverables:
      - "scripts/mcp-health-check.sh with comprehensive testing"
      - "lib/health-monitor.js for programmatic checks"
      - "Status reporting and alerting"
    time_estimate: "5 hours"
    
  - name: "Connection management"
    deliverables:
      - "lib/connection-manager.js with pooling"
      - "Connection timeout and retry logic"
      - "Performance tracking"
    time_estimate: "3 hours"
```

#### Day 4: Agent Integration
```yaml
tasks:
  - name: "Agent integration templates"
    deliverables:
      - "agents/integration/mcp-detection-template.md"
      - "Standard MCP integration protocol"
      - "Error handling templates"
    time_estimate: "3 hours"
    
  - name: "Update priority agents"
    deliverables:
      - "Updated strategist agent with MCP detection"
      - "Updated analyst agent with MCP integration"
      - "Updated coordinator agent with MCP support"
    time_estimate: "5 hours"
```

#### Day 5: Fallback System
```yaml
tasks:
  - name: "Fallback orchestrator"
    deliverables:
      - "lib/fallback-orchestrator.js with multi-tier fallbacks"
      - "WebFetch/WebSearch integration"
      - "Fallback performance tracking"
    time_estimate: "4 hours"
    
  - name: "Testing & validation"
    deliverables:
      - "Basic unit tests for core components"
      - "Integration test for full installation flow"
      - "Fallback scenario validation"
    time_estimate: "4 hours"
```

### Phase 1 Deliverables Checklist

- [ ] **Registry System** 
  - [ ] YAML registry schema implemented
  - [ ] Registry validation and updating
  - [ ] Configuration template system
  
- [ ] **Installation Automation**
  - [ ] Master installation script (`install-mcps.sh`)
  - [ ] Tier 1 MCP detection and installation
  - [ ] Error handling and rollback
  
- [ ] **Health Monitoring**
  - [ ] Health check script (`mcp-health-check.sh`)
  - [ ] Status tracking and reporting
  - [ ] Performance metrics collection
  
- [ ] **Agent Integration**
  - [ ] 3 priority agents updated with MCP detection
  - [ ] Standardized MCP integration protocol
  - [ ] Error handling and fallback logic
  
- [ ] **Fallback System**
  - [ ] Multi-tier fallback orchestration
  - [ ] WebFetch/WebSearch integration
  - [ ] Performance and usage tracking

## Phase 1 File Specifications

### Core Registry Manager (`lib/registry-manager.js`)

```javascript
// Registry Manager - Core MCP registry operations
const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
const { createLogger } = require('./utils/logger');

class RegistryManager {
  constructor(registryPath = '/workspace/config/mcp-registry.yaml') {
    this.registryPath = registryPath;
    this.logger = createLogger('RegistryManager');
    this.cache = new Map();
    this.cacheTimeout = 60000; // 1 minute
  }
  
  /**
   * Load and parse MCP registry
   * @returns {Object} Parsed registry object
   */
  async loadRegistry() {
    try {
      const registryContent = await fs.promises.readFile(this.registryPath, 'utf8');
      const registry = yaml.load(registryContent);
      
      // Validate registry format
      this.validateRegistry(registry);
      
      // Update cache
      this.cache.set('registry', {
        data: registry,
        timestamp: Date.now()
      });
      
      this.logger.info('Registry loaded successfully', {
        mcpCount: Object.keys(registry.registry || {}).length,
        version: registry.version
      });
      
      return registry;
    } catch (error) {
      this.logger.error('Failed to load registry', { error: error.message });
      throw error;
    }
  }
  
  /**
   * Get available MCPs for specific capability
   * @param {string} capability - Required capability
   * @returns {Array} Array of matching MCP IDs
   */
  async getMCPsForCapability(capability) {
    const registry = await this.loadRegistry();
    const matchingMCPs = [];
    
    for (const [mcpId, config] of Object.entries(registry.registry)) {
      if (config.status === 'connected' && 
          config.capabilities.some(cap => cap.name === capability)) {
        matchingMCPs.push({
          mcpId,
          priority: config.priority || 0,
          tier: config.tier,
          responseTime: config.metrics?.response_time_ms || Infinity
        });
      }
    }
    
    // Sort by priority (descending) and response time (ascending)
    return matchingMCPs.sort((a, b) => {
      if (a.priority !== b.priority) return b.priority - a.priority;
      return a.responseTime - b.responseTime;
    });
  }
  
  /**
   * Update MCP status in registry
   * @param {string} mcpId - MCP identifier
   * @param {Object} statusUpdate - Status update object
   */
  async updateMCPStatus(mcpId, statusUpdate) {
    const registry = await this.loadRegistry();
    
    if (!registry.registry[mcpId]) {
      throw new Error(`MCP '${mcpId}' not found in registry`);
    }
    
    // Update status fields
    Object.assign(registry.registry[mcpId], {
      ...statusUpdate,
      last_check: new Date().toISOString()
    });
    
    // Update metadata
    registry.metadata.last_updated = new Date().toISOString();
    
    // Save registry
    await this.saveRegistry(registry);
    
    this.logger.info('MCP status updated', { mcpId, statusUpdate });
  }
  
  /**
   * Validate registry structure and content
   * @param {Object} registry - Registry object to validate
   */
  validateRegistry(registry) {
    if (!registry.version) {
      throw new Error('Registry missing version field');
    }
    
    if (!registry.metadata || !registry.registry) {
      throw new Error('Registry missing required sections');
    }
    
    // Validate each MCP entry
    for (const [mcpId, config] of Object.entries(registry.registry)) {
      this.validateMCPConfig(mcpId, config);
    }
  }
  
  validateMCPConfig(mcpId, config) {
    const required = ['name', 'transport', 'endpoint', 'status', 'tier'];
    
    for (const field of required) {
      if (!config[field]) {
        throw new Error(`MCP '${mcpId}' missing required field: ${field}`);
      }
    }
    
    if (!['stdio', 'http', 'sse'].includes(config.transport)) {
      throw new Error(`MCP '${mcpId}' has invalid transport: ${config.transport}`);
    }
    
    if (![1, 2, 3].includes(config.tier)) {
      throw new Error(`MCP '${mcpId}' has invalid tier: ${config.tier}`);
    }
  }
  
  /**
   * Save registry to file
   * @param {Object} registry - Registry object to save
   */
  async saveRegistry(registry) {
    const yamlContent = yaml.dump(registry, {
      indent: 2,
      lineWidth: 120,
      sortKeys: false
    });
    
    // Create backup before saving
    await this.createBackup();
    
    await fs.promises.writeFile(this.registryPath, yamlContent, 'utf8');
    
    // Clear cache to force reload
    this.cache.delete('registry');
  }
  
  /**
   * Create backup of current registry
   */
  async createBackup() {
    if (fs.existsSync(this.registryPath)) {
      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const backupPath = `/workspace/config/backup/mcp-registry-${timestamp}.yaml`;
      
      await fs.promises.mkdir(path.dirname(backupPath), { recursive: true });
      await fs.promises.copyFile(this.registryPath, backupPath);
      
      this.logger.info('Registry backup created', { backupPath });
    }
  }
}

module.exports = RegistryManager;
```

### Master Installation Script (`scripts/install-mcps.sh`)

```bash
#!/bin/bash
# Master Installation Script for BOS-AI MCP Automation
# Version: 1.0
# Purpose: Automated installation of Tier 1 MCPs with comprehensive error handling

set -euo pipefail

# === CONFIGURATION ===
readonly SCRIPT_VERSION="1.0"
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly WORKSPACE_DIR="/workspace"
readonly CONFIG_DIR="$WORKSPACE_DIR/config"
readonly LOG_DIR="$WORKSPACE_DIR/logs"

# Files
readonly LOG_FILE="$LOG_DIR/mcp-install-$(date +%Y%m%d-%H%M%S).log"
readonly REGISTRY_FILE="$CONFIG_DIR/mcp-registry.yaml"
readonly STATUS_FILE="$CONFIG_DIR/mcp-status.yaml"

# Configuration
readonly INSTALLATION_TIMEOUT=300  # 5 minutes
readonly HEALTH_CHECK_TIMEOUT=30   # 30 seconds
readonly MAX_RETRY_ATTEMPTS=3

# === UTILITY FUNCTIONS ===
source "$SCRIPT_DIR/utils/logging.sh"  # Load logging utilities

# Create required directories
init_directories() {
  log_info "Initializing directory structure"
  
  local dirs=("$CONFIG_DIR" "$LOG_DIR" "$CONFIG_DIR/backup" "$WORKSPACE_DIR/cache")
  
  for dir in "${dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
      mkdir -p "$dir" || {
        log_error "Failed to create directory: $dir"
        exit 1
      }
    fi
  done
  
  log_success "Directory structure initialized"
}

# Check system prerequisites
check_prerequisites() {
  log_info "Checking system prerequisites"
  
  # Check Claude Code CLI
  if ! command -v claude &> /dev/null; then
    log_error "Claude Code CLI not found. Please install Claude Code first."
    log_info "Visit: https://claude.ai/code for installation instructions"
    exit 1
  fi
  
  local claude_version
  if claude_version=$(claude version 2>/dev/null); then
    log_success "Claude Code detected: $claude_version"
  else
    log_warn "Could not determine Claude Code version"
  fi
  
  # Check Node.js for npm-based MCPs
  if command -v node &> /dev/null; then
    local node_version=$(node --version)
    local major_version=$(echo "$node_version" | sed 's/v\([0-9]*\).*/\1/')
    
    if [[ "$major_version" -ge 18 ]]; then
      log_success "Node.js detected: $node_version"
    else
      log_warn "Node.js version $node_version detected. Version 18+ recommended."
    fi
  else
    log_warn "Node.js not found. Some MCPs may require Node.js runtime."
  fi
  
  # Check npm
  if command -v npm &> /dev/null; then
    local npm_version=$(npm --version)
    log_success "npm detected: v$npm_version"
  else
    log_warn "npm not found. Some MCPs may require npm for installation."
  fi
  
  log_success "Prerequisites check completed"
}

# Install individual MCP with error handling and retries
install_mcp() {
  local name="$1"
  local transport="$2" 
  local endpoint="$3"
  local scope="$4"
  local required="${5:-false}"
  
  log_info "Installing MCP: $name"
  
  local attempt=1
  local max_attempts=$MAX_RETRY_ATTEMPTS
  
  while [[ $attempt -le $max_attempts ]]; do
    log_info "Installation attempt $attempt/$max_attempts for $name"
    
    # Build claude mcp add command
    local cmd_args=("$name" "--scope" "$scope")
    
    case "$transport" in
      "stdio")
        cmd_args+=("--server" "$endpoint")
        ;;
      "http")
        cmd_args+=("--transport" "http" "$endpoint")
        ;;
      "sse")
        cmd_args+=("--transport" "sse" "$endpoint")
        ;;
      *)
        log_error "Unsupported transport type for $name: $transport"
        return 1
        ;;
    esac
    
    # Execute installation with timeout
    if timeout "$INSTALLATION_TIMEOUT" claude mcp add "${cmd_args[@]}" 2>&1 | tee -a "$LOG_FILE"; then
      log_success "MCP '$name' installed successfully on attempt $attempt"
      
      # Verify installation with health check
      if verify_mcp_installation "$name"; then
        log_success "MCP '$name' installation verified"
        return 0
      else
        log_warn "MCP '$name' installed but failed verification"
      fi
    else
      local exit_code=$?
      log_error "MCP '$name' installation failed on attempt $attempt (exit code: $exit_code)"
    fi
    
    ((attempt++))
    
    if [[ $attempt -le $max_attempts ]]; then
      local delay=$((attempt * 5))  # Exponential backoff: 5s, 10s, 15s
      log_info "Retrying in ${delay} seconds..."
      sleep $delay
    fi
  done
  
  # All attempts failed
  log_error "Failed to install MCP '$name' after $max_attempts attempts"
  
  if [[ "$required" == "true" ]]; then
    log_error "Required MCP '$name' failed to install. Aborting installation."
    exit 1
  fi
  
  return 1
}

# Verify MCP installation with health check
verify_mcp_installation() {
  local mcp_name="$1"
  
  log_info "Verifying installation of $mcp_name"
  
  # Basic connection test
  if timeout "$HEALTH_CHECK_TIMEOUT" claude mcp test "$mcp_name" &>/dev/null; then
    log_success "$mcp_name verification passed"
    return 0
  else
    log_error "$mcp_name verification failed"
    return 1
  fi
}

# Install Tier 1 (Essential) MCPs
install_tier1_mcps() {
  log_info "Installing Tier 1 (Essential) MCPs"
  log_info "====================================="""
  
  local -a tier1_mcps=(
    # Format: "name transport endpoint scope required"
    "github stdio npx\ @modelcontextprotocol/server-github project true"
    "filesystem stdio npx\ @modelcontextprotocol/server-filesystem\ $WORKSPACE_DIR project true"
    "ide stdio npx\ @modelcontextprotocol/server-ide project false"
  )
  
  local installed=0
  local failed=0
  local total=${#tier1_mcps[@]}
  
  for mcp_config in "${tier1_mcps[@]}"; do
    # Parse configuration
    IFS=' ' read -r -a config <<< "$mcp_config"
    local name="${config[0]}"
    local transport="${config[1]}"
    local endpoint="${config[2]/\\ / }"  # Unescape spaces
    local scope="${config[3]}"
    local required="${config[4]}"
    
    if install_mcp "$name" "$transport" "$endpoint" "$scope" "$required"; then
      ((installed++))
    else
      ((failed++))
    fi
    
    log_info "Progress: $((installed + failed))/$total completed"
  done
  
  log_info "Tier 1 Installation Summary:"
  log_info "  Total MCPs: $total"
  log_info "  Installed: $installed"  
  log_info "  Failed: $failed"
  log_info "  Success Rate: $(( installed * 100 / total ))%"
  
  # Validate minimum requirements
  local minimum_required=2  # Need at least 2 of 3 Tier 1 MCPs
  if [[ $installed -lt $minimum_required ]]; then
    log_error "Insufficient Tier 1 MCPs installed ($installed/$minimum_required minimum required)"
    log_error "BOS-AI may not function properly. Please resolve installation issues."
    exit 1
  fi
  
  log_success "Tier 1 MCP installation completed successfully"
}

# Generate initial MCP registry
generate_initial_registry() {
  log_info "Generating initial MCP registry"
  
  # Create registry template
  cat > "$REGISTRY_FILE" << EOF
version: "1.0"
metadata:
  registry_format_version: "1.0.0"
  created: "$(date -Iseconds)"
  last_updated: "$(date -Iseconds)"
  update_frequency: 300
  health_check_interval: 300

registry:
  # Registry entries will be populated by update-registry.sh
EOF
  
  # Run registry update to populate with actual MCP data
  if [[ -x "$SCRIPT_DIR/update-registry.sh" ]]; then
    log_info "Updating registry with installed MCP data"
    if "$SCRIPT_DIR/update-registry.sh"; then
      log_success "Registry populated with MCP data"
    else
      log_warn "Registry update script failed, registry may be incomplete"
    fi
  else
    log_warn "Registry update script not found, registry will be incomplete"
  fi
  
  log_success "Initial registry created: $REGISTRY_FILE"
}

# Run comprehensive health check
run_health_check() {
  log_info "Running initial health check"
  
  if [[ -x "$SCRIPT_DIR/mcp-health-check.sh" ]]; then
    if "$SCRIPT_DIR/mcp-health-check.sh"; then
      log_success "Health check passed"
    else
      local health_exit_code=$?
      case $health_exit_code in
        1)
          log_warn "Health check completed with warnings (degraded performance)"
          ;;
        2)
          log_error "Health check failed (critical issues detected)"
          ;;
        *)
          log_error "Health check failed with unknown error (exit code: $health_exit_code)"
          ;;
      esac
    fi
  else
    log_warn "Health check script not found, skipping health verification"
  fi
}

# Display installation summary and next steps
show_summary() {
  local end_time=$(date +%s)
  local duration=$((end_time - START_TIME))
  
  echo ""
  log_success "BOS-AI MCP Installation Completed"
  log_info "=================================="
  log_info "Total Installation Time: ${duration}s"
  log_info "Installation Log: $LOG_FILE"
  log_info "Registry File: $REGISTRY_FILE"
  
  # Show installed MCPs
  echo ""
  log_info "Installed MCPs:"
  if claude mcp list &>/dev/null; then
    claude mcp list | sed 's/^/  /'
  else
    log_warn "Could not retrieve MCP list"
  fi
  
  # Next steps
  echo ""
  log_info "📝 Next Steps:"
  echo "  1. Run './scripts/mcp-health-check.sh' to verify all connections"  
  echo "  2. Check the registry at: $REGISTRY_FILE"
  echo "  3. Review installation log: $LOG_FILE"
  echo "  4. Update agent configurations to use MCPs"
  echo ""
  log_success "✅ BOS-AI MCP Installation Complete!"
}

# === MAIN EXECUTION ===
main() {
  local start_time=$(date +%s)
  START_TIME=$start_time
  
  log_info "BOS-AI MCP Installation Script v$SCRIPT_VERSION"
  log_info "================================================"
  log_info "Started at: $(date)"
  log_info "Log file: $LOG_FILE"
  
  # Execute installation steps
  init_directories
  check_prerequisites
  install_tier1_mcps
  generate_initial_registry
  run_health_check
  show_summary
}

# === ERROR HANDLING ===
cleanup() {
  local exit_code=$?
  
  if [[ $exit_code -ne 0 ]]; then
    log_error "Installation failed with exit code: $exit_code"
    log_info "Check the log file for details: $LOG_FILE"
  fi
  
  exit $exit_code
}

# Set up signal handlers
trap cleanup EXIT
trap 'log_error "Installation interrupted by user"; exit 1' INT TERM

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
```

### Agent Integration Template (`agents/integration/mcp-detection-template.md`)

```markdown
# MCP Integration Protocol for BOS-AI Agents
**Version:** 1.0  
**Purpose:** Standardized MCP detection and integration for all BOS-AI agents  

## AGENT MCP INITIALIZATION PROTOCOL

Every BOS-AI agent MUST implement this initialization sequence before executing any tasks:

### Step 1: MCP Registry Check
```bash
# Check if MCP registry exists and is readable
MCP_REGISTRY="/workspace/config/mcp-registry.yaml"
MCP_STATUS="/workspace/config/mcp-status.yaml"

if [[ -f "$MCP_REGISTRY" && -r "$MCP_REGISTRY" ]]; then
    echo "✅ MCP registry detected"
    MCP_ENABLED=true
else
    echo "⚠️ MCP registry not found - using fallback mode"
    MCP_ENABLED=false
fi
```

### Step 2: Agent-Specific MCP Requirements
Each agent defines their MCP requirements:

```yaml
# Agent MCP Requirements: {{AGENT_NAME}}
mcp_requirements:
  primary_capabilities:
    {{#each primary_capabilities}}
    - name: "{{name}}"
      preferred_mcps: {{preferred_mcps}}
      fallback_strategy: "{{fallback_strategy}}"
    {{/each}}
  
  optional_capabilities:
    {{#each optional_capabilities}}
    - name: "{{name}}"
      preferred_mcps: {{preferred_mcps}}
      fallback_strategy: "{{fallback_strategy}}"
    {{/each}}
```

### Step 3: Runtime MCP Detection
```bash
# Function to detect available MCP for capability
detect_mcp_for_capability() {
    local capability="$1"
    local preferred_tiers="${2:-1,2,3}"
    
    if [[ "$MCP_ENABLED" != "true" ]]; then
        return 1
    fi
    
    # Parse registry for matching MCPs (simplified - full implementation would use YAML parser)
    local available_mcp
    available_mcp=$(grep -A 10 "$capability" "$MCP_REGISTRY" 2>/dev/null | head -1)
    
    if [[ -n "$available_mcp" ]]; then
        echo "$available_mcp"
        return 0
    fi
    
    return 1
}
```

### Step 4: Tool Selection Logic
```bash
# Tool selection with automatic fallback
execute_with_mcp_fallback() {
    local capability="$1"
    local operation="$2"
    shift 2
    local params=("$@")
    
    # Try primary MCP first
    if mcp_id=$(detect_mcp_for_capability "$capability"); then
        echo "🔧 Using MCP: $mcp_id for $operation"
        
        if mcp__"${mcp_id}"__"${operation}" "${params[@]}" 2>/dev/null; then
            echo "✅ MCP operation completed successfully"
            return 0
        else
            echo "❌ MCP operation failed, activating fallback"
        fi
    fi
    
    # Execute fallback strategy
    execute_fallback_strategy "$capability" "$operation" "${params[@]}"
}
```

## CAPABILITY-SPECIFIC INTEGRATION

### Repository Operations
```markdown
**Capability:** repository_access
**Primary MCP:** github
**Fallback Strategy:** WebFetch to GitHub API → Git CLI → Manual request

**Implementation:**
```bash
# Repository analysis with MCP fallback
analyze_repository() {
    local repo_url="$1"
    
    if execute_with_mcp_fallback "repository_access" "analyze_repo" "$repo_url"; then
        return 0
    fi
    
    # Fallback implementation
    echo "Using fallback: WebFetch to GitHub API"
    if WebFetch "$repo_url" "Analyze repository structure and recent activity"; then
        return 0
    fi
    
    echo "Manual input required: Please provide repository analysis"
    return 1
}
```

### Market Research
```markdown
**Capability:** market_research
**Primary MCP:** firecrawl
**Fallback Strategy:** WebSearch → WebFetch → Manual research

**Implementation:**
```bash
# Market research with MCP fallback
conduct_market_research() {
    local topic="$1"
    local scope="${2:-comprehensive}"
    
    if execute_with_mcp_fallback "market_research" "research_market" "$topic" "$scope"; then
        return 0
    fi
    
    # Fallback: Use WebSearch
    echo "Using fallback: WebSearch for market research"
    WebSearch "market analysis $topic trends 2024 2025"
}
```

### Data Analytics
```markdown
**Capability:** data_analytics  
**Primary MCP:** stripe
**Fallback Strategy:** WebFetch to service dashboard → Manual data export → Cached data

**Implementation:**
```bash
# Revenue analytics with MCP fallback
get_revenue_metrics() {
    local period="$1"
    local metrics="${2:-revenue,customers,growth}"
    
    if execute_with_mcp_fallback "data_analytics" "get_metrics" "$period" "$metrics"; then
        return 0
    fi
    
    # Fallback: Request manual export
    echo "MCP unavailable. Please export $metrics data for $period from your dashboard."
    echo "Save the data to: /workspace/data/manual-export-$(date +%Y%m%d).csv"
    return 1
}
```

## ERROR HANDLING & LOGGING

### MCP Error Handling
```bash
# Standardized MCP error handling
handle_mcp_error() {
    local mcp_id="$1"
    local operation="$2"
    local error_message="$3"
    local timestamp=$(date -Iseconds)
    
    # Log the error
    cat >> /workspace/logs/mcp-failures.log << EOF
{
  "timestamp": "$timestamp",
  "agent": "{{AGENT_NAME}}",
  "mcp_id": "$mcp_id", 
  "operation": "$operation",
  "error": "$error_message"
}
EOF
    
    echo "❌ MCP Error: $mcp_id.$operation failed - $error_message"
    echo "🔄 Activating fallback strategy"
}
```

### Performance Monitoring
```bash
# Track MCP usage and performance
track_mcp_usage() {
    local mcp_id="$1"
    local operation="$2"
    local start_time="$3"
    local end_time="$4"
    local success="$5"
    
    local response_time=$((end_time - start_time))
    local timestamp=$(date -Iseconds)
    
    cat >> /workspace/logs/mcp-performance.log << EOF
{
  "timestamp": "$timestamp",
  "agent": "{{AGENT_NAME}}",
  "mcp_id": "$mcp_id",
  "operation": "$operation", 
  "response_time": $response_time,
  "success": $success
}
EOF
}
```

## AGENT PROMPT INTEGRATION

### Standard Agent Prompt Template
Add this section to every BOS-AI agent prompt:

```markdown
## MCP INTEGRATION INSTRUCTIONS

**BEFORE STARTING ANY TASK:**
1. Check MCP availability: `cat /workspace/config/mcp-status.yaml`
2. Identify required capabilities for your task
3. Select optimal MCP or prepare fallback strategy

**TOOL USAGE PRIORITY:**
1. **MCP Tools** (if available): `mcp__[service]__[action]`  
2. **Web Fallbacks**: WebFetch for APIs, WebSearch for research
3. **Manual Fallbacks**: Request user input or use cached data

**YOUR MCP CAPABILITIES:**
{{#each agent_capabilities}}
- **{{name}}**: Primary = {{primary_mcp}}, Fallback = {{fallback}}
{{/each}}

**ERROR HANDLING:**
- Auto-fallback on MCP failures (no user interruption needed)
- Log all MCP errors to `/workspace/logs/mcp-failures.log` 
- Report MCP issues in handoff notes for optimization
```

### Example Agent Integration
```markdown
# Strategist Agent with MCP Integration

## STRATEGIST MCP CAPABILITIES
- **market_research**: Primary = firecrawl, Fallback = WebSearch
- **repository_analysis**: Primary = github, Fallback = WebFetch GitHub API  
- **document_creation**: Primary = filesystem, Fallback = Write tool
- **competitive_analysis**: Primary = firecrawl, Fallback = WebSearch

## TASK EXECUTION WITH MCP INTEGRATION

Before creating any strategic analysis:
1. Check available MCPs: `cat /workspace/config/mcp-status.yaml`
2. For market research: Try firecrawl MCP → WebSearch fallback
3. For repo analysis: Try github MCP → WebFetch GitHub API → manual
4. Document using filesystem MCP or Write tool fallback

**Example: Market Research Task**
```bash
# Check if firecrawl MCP available
if detect_mcp_for_capability "market_research"; then
    echo "Using Firecrawl MCP for comprehensive market research"
    mcp__firecrawl__research_market "$INDUSTRY" "$SCOPE"
else
    echo "Using WebSearch fallback for market research"
    WebSearch "market trends $INDUSTRY 2024 analysis competitive landscape"
fi
```
```

## TESTING & VALIDATION

### MCP Integration Testing
```bash
# Test MCP integration for agent
test_agent_mcp_integration() {
    local agent_name="$1"
    
    echo "Testing MCP integration for $agent_name"
    
    # Test MCP detection
    if detect_mcp_for_capability "test_capability"; then
        echo "✅ MCP detection working"
    else
        echo "❌ MCP detection failed"
        return 1
    fi
    
    # Test fallback activation
    if execute_fallback_strategy "test_capability" "test_operation"; then
        echo "✅ Fallback system working"
    else
        echo "❌ Fallback system failed"
        return 1
    fi
    
    echo "✅ $agent_name MCP integration validated"
}
```

## HANDOFF PROTOCOL

### MCP Status Reporting
When handing off to another agent, always include:

```markdown
## MCP STATUS FOR NEXT AGENT

**MCPs Used in This Session:**
- GitHub MCP: ✅ Used for repository analysis (avg response: 150ms)
- Firecrawl MCP: ❌ Unavailable, used WebSearch fallback
- Filesystem MCP: ✅ Used for document creation (avg response: 50ms)

**Fallback Activations:**
- Market research: 2x fallback to WebSearch (firecrawl unavailable)
- Data export: 1x manual fallback (stripe MCP timeout)

**Recommendations:**
- Consider fixing firecrawl MCP connection for next market research tasks
- Stripe MCP showing occasional timeouts, monitor performance
```

This standardized integration ensures all BOS-AI agents can seamlessly use available MCPs while gracefully falling back when needed.
```

## Fallback System Architecture

### Multi-Tier Fallback Strategy

The fallback system implements a four-tier strategy for each capability:

```
Primary MCP → Alternative MCP → Web API → Manual Request
     ↓             ↓              ↓           ↓
  Direct MCP    Secondary MCP   WebFetch/   User Input
  Connection    Connection      WebSearch   or Cache
```

### Fallback Orchestrator (`lib/fallback-orchestrator.js`)

```javascript
// Intelligent Fallback System for MCP Operations
const { createLogger } = require('./utils/logger');
const RegistryManager = require('./registry-manager');

class FallbackOrchestrator {
  constructor() {
    this.logger = createLogger('FallbackOrchestrator');
    this.registryManager = new RegistryManager();
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
          authHeader: 'Authorization: token ${GITHUB_TOKEN}'
        },
        manualFallback: 'Please provide repository information manually'
      },
      
      market_research: {
        primary: 'firecrawl',
        alternatives: ['context7'],
        webFallback: {
          type: 'WebSearch',
          query: 'market analysis {topic} trends 2024 2025'
        },
        manualFallback: 'Please provide market research data'
      },
      
      data_analytics: {
        primary: 'stripe',
        alternatives: ['postgres'],
        webFallback: {
          type: 'WebFetch',
          baseUrl: 'https://dashboard.stripe.com',
          authHeader: 'Authorization: Bearer ${STRIPE_API_KEY}'
        },
        manualFallback: 'Please export analytics data manually',
        cache: {
          enabled: true,
          duration: 3600000, // 1 hour
          path: '/workspace/cache/analytics'
        }
      },

      document_management: {
        primary: 'filesystem',
        alternatives: ['notion'],
        webFallback: {
          type: 'Direct',
          tool: 'Write'
        },
        manualFallback: 'Please provide document content'
      },

      communication: {
        primary: 'slack',
        alternatives: ['email'],
        webFallback: {
          type: 'WebFetch',
          baseUrl: 'https://hooks.slack.com/services'
        },
        manualFallback: 'Please send message manually'
      }
    };
  }

  /**
   * Execute operation with intelligent fallback
   * @param {string} capability - Required capability
   * @param {string} operation - Operation to perform
   * @param {object} params - Operation parameters
   * @param {object} options - Execution options
   * @returns {Promise<object>} Operation result
   */
  async executeWithFallback(capability, operation, params = {}, options = {}) {
    const startTime = Date.now();
    const strategy = this.fallbackStrategies[capability];
    
    if (!strategy) {
      throw new Error(`No fallback strategy defined for capability: ${capability}`);
    }

    this.logger.info('Starting fallback execution', { capability, operation });

    // Level 1: Primary MCP
    try {
      const result = await this.tryPrimaryMCP(strategy.primary, operation, params);
      this.trackFallbackUsage(capability, 'primary', true, Date.now() - startTime);
      return result;
    } catch (error) {
      this.logger.warn('Primary MCP failed', { 
        mcp: strategy.primary, 
        error: error.message 
      });
    }

    // Level 2: Alternative MCPs
    for (const altMcp of strategy.alternatives || []) {
      try {
        const result = await this.tryAlternativeMCP(altMcp, operation, params);
        this.trackFallbackUsage(capability, 'alternative', true, Date.now() - startTime);
        return result;
      } catch (error) {
        this.logger.warn('Alternative MCP failed', { 
          mcp: altMcp, 
          error: error.message 
        });
      }
    }

    // Level 3: Web API Fallback
    if (strategy.webFallback) {
      try {
        const result = await this.tryWebFallback(strategy.webFallback, operation, params);
        this.trackFallbackUsage(capability, 'web', true, Date.now() - startTime);
        return result;
      } catch (error) {
        this.logger.warn('Web fallback failed', { error: error.message });
      }
    }

    // Level 4: Cache Fallback (if enabled)
    if (strategy.cache?.enabled) {
      try {
        const result = await this.tryCacheFallback(strategy.cache, operation, params);
        this.trackFallbackUsage(capability, 'cache', true, Date.now() - startTime);
        return result;
      } catch (error) {
        this.logger.warn('Cache fallback failed', { error: error.message });
      }
    }

    // Level 5: Manual Fallback
    const result = await this.requestManualInput(strategy.manualFallback, operation, params);
    this.trackFallbackUsage(capability, 'manual', true, Date.now() - startTime);
    return result;
  }

  /**
   * Try primary MCP execution
   */
  async tryPrimaryMCP(mcpId, operation, params) {
    // Check if MCP is available and healthy
    const mcpStatus = await this.registryManager.getMCPStatus(mcpId);
    
    if (mcpStatus.status !== 'connected') {
      throw new Error(`Primary MCP ${mcpId} is not available (status: ${mcpStatus.status})`);
    }

    // Execute MCP operation (simplified - actual implementation would use MCP client)
    const result = await this.executeMCPOperation(mcpId, operation, params);
    
    this.logger.info('Primary MCP success', { mcpId, operation });
    return result;
  }

  /**
   * Try alternative MCP execution
   */
  async tryAlternativeMCP(mcpId, operation, params) {
    const mcpStatus = await this.registryManager.getMCPStatus(mcpId);
    
    if (mcpStatus.status !== 'connected') {
      throw new Error(`Alternative MCP ${mcpId} is not available`);
    }

    const result = await this.executeMCPOperation(mcpId, operation, params);
    
    this.logger.info('Alternative MCP success', { mcpId, operation });
    return result;
  }

  /**
   * Try web API fallback
   */
  async tryWebFallback(fallbackConfig, operation, params) {
    switch (fallbackConfig.type) {
      case 'WebFetch':
        return await this.executeWebFetch(fallbackConfig, operation, params);
      case 'WebSearch':
        return await this.executeWebSearch(fallbackConfig, operation, params);
      case 'Direct':
        return await this.executeDirectTool(fallbackConfig, operation, params);
      default:
        throw new Error(`Unsupported web fallback type: ${fallbackConfig.type}`);
    }
  }

  async executeWebFetch(config, operation, params) {
    // Construct URL with parameters
    const url = this.buildFallbackURL(config.baseUrl, operation, params);
    
    // Prepare headers
    const headers = {};
    if (config.authHeader) {
      const authValue = this.resolveAuthHeader(config.authHeader);
      const [header, value] = authValue.split(': ');
      headers[header] = value;
    }

    // Execute WebFetch (simplified - actual implementation would use WebFetch tool)
    this.logger.info('Executing WebFetch fallback', { url });
    return { success: true, data: 'WebFetch result', source: 'web_fallback' };
  }

  async executeWebSearch(config, operation, params) {
    // Build search query from template
    const query = this.buildSearchQuery(config.query, params);
    
    this.logger.info('Executing WebSearch fallback', { query });
    return { success: true, data: 'WebSearch result', source: 'search_fallback' };
  }

  /**
   * Try cached data fallback
   */
  async tryCacheFallback(cacheConfig, operation, params) {
    const fs = require('fs').promises;
    const path = require('path');
    
    const cacheKey = this.generateCacheKey(operation, params);
    const cachePath = path.join(cacheConfig.path, `${cacheKey}.json`);
    
    try {
      const cacheData = await fs.readFile(cachePath, 'utf8');
      const parsedData = JSON.parse(cacheData);
      
      // Check if cache is still valid
      const cacheAge = Date.now() - parsedData.timestamp;
      if (cacheAge < cacheConfig.duration) {
        this.logger.info('Cache fallback success', { cacheKey, age: cacheAge });
        return { ...parsedData.data, source: 'cache_fallback' };
      } else {
        this.logger.warn('Cache expired', { cacheKey, age: cacheAge });
        throw new Error('Cache expired');
      }
    } catch (error) {
      throw new Error(`Cache fallback failed: ${error.message}`);
    }
  }

  /**
   * Request manual input from user
   */
  async requestManualInput(message, operation, params) {
    this.logger.warn('All automated fallbacks failed, requesting manual input');
    
    // Create manual request file for user
    const requestFile = `/workspace/manual-requests/request-${Date.now()}.json`;
    await this.createManualRequest(requestFile, message, operation, params);
    
    return {
      success: false,
      message: `Manual input required. ${message}`,
      requestFile: requestFile,
      source: 'manual_fallback'
    };
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
        averageResponseTime: 0
      });
    }
    
    const metrics = this.fallbackMetrics.get(key);
    metrics.attempts++;
    if (success) metrics.successes++;
    metrics.totalResponseTime += responseTime;
    metrics.averageResponseTime = metrics.totalResponseTime / metrics.attempts;
    
    // Log metrics for analysis
    this.logger.info('Fallback metrics updated', {
      capability,
      level, 
      success,
      responseTime,
      successRate: (metrics.successes / metrics.attempts * 100).toFixed(1),
      averageResponseTime: Math.round(metrics.averageResponseTime)
    });
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
        successRate: (data.successes / data.attempts * 100).toFixed(1),
        averageResponseTime: Math.round(data.averageResponseTime)
      };
    }
    
    return metrics;
  }

  // Helper methods
  buildFallbackURL(baseUrl, operation, params) {
    // Implementation depends on specific API structure
    return `${baseUrl}/${operation}?${new URLSearchParams(params)}`;
  }

  resolveAuthHeader(template) {
    // Replace environment variables in auth header template
    return template.replace(/\${([^}]+)}/g, (match, varName) => {
      return process.env[varName] || match;
    });
  }

  buildSearchQuery(template, params) {
    // Replace parameters in search query template
    return template.replace(/\{([^}]+)\}/g, (match, paramName) => {
      return params[paramName] || match;
    });
  }

  generateCacheKey(operation, params) {
    // Generate deterministic cache key
    const crypto = require('crypto');
    const content = JSON.stringify({ operation, params });
    return crypto.createHash('md5').update(content).digest('hex');
  }

  async createManualRequest(filePath, message, operation, params) {
    const fs = require('fs').promises;
    const path = require('path');
    
    await fs.mkdir(path.dirname(filePath), { recursive: true });
    
    const request = {
      timestamp: new Date().toISOString(),
      message,
      operation,
      params,
      status: 'pending'
    };
    
    await fs.writeFile(filePath, JSON.stringify(request, null, 2));
  }

  // Placeholder for actual MCP execution
  async executeMCPOperation(mcpId, operation, params) {
    // This would integrate with the actual MCP client
    throw new Error('MCP operation failed');
  }
}

module.exports = FallbackOrchestrator;
```

### Fallback Decision Matrix

```yaml
# Fallback decision matrix for common scenarios
fallback_matrix:
  repository_access:
    github_available: "Direct MCP usage"
    github_slow: "Continue with timeout warning"  
    github_failed: "Git CLI → WebFetch GitHub API → Manual"
    
  market_research:
    firecrawl_available: "Direct MCP usage"
    firecrawl_quota_exceeded: "WebSearch with targeted queries"
    firecrawl_failed: "WebSearch → Manual research request"
    
  data_analytics:
    stripe_available: "Direct MCP usage"
    stripe_auth_failed: "Request credential renewal"
    stripe_failed: "WebFetch dashboard → Manual export → Cache"
    
  document_creation:
    filesystem_available: "Direct MCP usage"  
    filesystem_permission_denied: "Use Write tool directly"
    filesystem_failed: "Write tool → Manual document creation"
```

## Phase 2-4 Implementation Roadmap

### Phase 2: Enhanced Automation (Week 2)
```yaml
goals:
  - Intelligent authentication guidance
  - Tier 2 MCP installation automation
  - Advanced configuration management
  - Performance monitoring dashboard

deliverables:
  - OAuth flow automation for supported services
  - Environment variable detection and validation
  - Configuration management UI (web-based)
  - Real-time MCP status dashboard
  - Expanded agent integration (10 additional agents)

tasks:
  authentication:
    - Implement OAuth flow helpers
    - Create credential validation system
    - Build authentication guidance UI
    
  tier2_mcps:
    - Stripe MCP automated installation
    - Linear MCP integration
    - Firecrawl MCP setup
    - Slack MCP configuration
    
  monitoring:
    - Real-time status dashboard
    - Performance metrics collection
    - Alert system for MCP failures
    - Usage analytics tracking
```

### Phase 3: Advanced Features (Week 3-4)
```yaml
goals:
  - Power user configuration options
  - Advanced performance optimization
  - Team deployment features
  - Custom MCP plugin system

deliverables:
  - Advanced configuration management
  - Connection pooling optimization
  - Team deployment scripts
  - Custom MCP development framework
  - Comprehensive testing suite

tasks:
  configuration:
    - Multi-environment config management
    - Team policy enforcement
    - Configuration versioning and rollback
    
  performance:
    - Connection pooling optimization
    - Response caching system
    - Load balancing for multiple MCP instances
    - Performance profiling tools
    
  extensibility:
    - Custom MCP plugin architecture
    - MCP development SDK
    - Community MCP repository
    - Plugin validation and security
```

### Phase 4: Production Readiness (Month 2)
```yaml
goals:
  - Production-grade monitoring
  - Enterprise security features
  - Scalability optimization
  - Comprehensive documentation

deliverables:
  - Enterprise monitoring dashboard
  - Advanced security features
  - Horizontal scaling support
  - Complete documentation suite
  - Certification and compliance

tasks:
  enterprise:
    - SSO integration for team authentication
    - Audit logging and compliance reporting
    - Enterprise security policies
    - Multi-tenant support
    
  scalability:
    - Distributed registry system
    - Load balancing and failover
    - Auto-scaling connection pools
    - Performance optimization
    
  documentation:
    - Complete API documentation
    - Video tutorials and training
    - Best practices guides
    - Troubleshooting playbooks
```

## Technology Stack Decisions

### Core Technologies
- **Registry Format**: YAML (human-readable, Git-friendly, easy parsing)
- **Scripting**: Bash for installation/health checks (universal compatibility)
- **Libraries**: Node.js/JavaScript for core logic (MCP ecosystem alignment)
- **Logging**: Structured JSON logging with file rotation
- **Caching**: Multi-tier file-based caching with TTL

### Integration Technologies
- **MCP Client**: Claude Code MCP system (existing integration)
- **Web Fallbacks**: WebFetch/WebSearch tools (already available)
- **Configuration**: Environment variables + YAML files
- **Monitoring**: File-based metrics with optional web dashboard

### Security Technologies
- **Credential Storage**: OS keychain (macOS Keychain, Windows Credential Manager, Linux Secret Service)
- **Transport Security**: HTTPS/TLS for all network communications
- **Authentication**: API keys + OAuth where supported
- **Authorization**: Minimal privilege principle with scope-based access

## Risk Mitigation Strategies

### Technical Risks
1. **MCP Compatibility Issues**
   - Risk: Community MCPs may have compatibility problems
   - Mitigation: Comprehensive testing matrix, approved MCP list, fallback systems

2. **Performance Bottlenecks**
   - Risk: Multiple MCP connections may impact performance  
   - Mitigation: Connection pooling, caching, parallel execution, timeout management

3. **Authentication Complexity**
   - Risk: Different auth methods across services create setup friction
   - Mitigation: Guided setup wizards, multiple auth method support, graceful degradation

### Operational Risks
1. **Service Dependencies**
   - Risk: External MCP services may become unavailable
   - Mitigation: Multi-tier fallback system, caching, alternative providers

2. **Configuration Drift**
   - Risk: Team configurations may become inconsistent
   - Mitigation: Configuration templates, validation, centralized management

3. **Security Vulnerabilities**
   - Risk: Credential exposure or unauthorized access
   - Mitigation: OS-level secure storage, minimal privileges, regular security audits

## Success Metrics & KPIs

### Phase 1 Success Criteria
- [ ] 95% installation success rate for Tier 1 MCPs
- [ ] <5 minutes average setup time for basic functionality
- [ ] >90% task completion rate even with MCP failures
- [ ] All 3 priority agents successfully integrate MCP detection
- [ ] Fallback system activates within 500ms of MCP failure

### Performance Targets
- Registry load time: <50ms
- MCP detection overhead: <100ms per agent initialization  
- MCP operation timeout: <2 seconds for 95th percentile
- Fallback activation: <500ms switching time
- System memory overhead: <50MB additional usage

### Quality Targets
- Code coverage: >80% for core components
- Documentation coverage: 100% for public APIs
- Zero critical security vulnerabilities
- <1% false positive rate for health checks
- User satisfaction: >4.5/5 rating for setup experience

This implementation blueprint provides the complete foundation for developing the BOS-AI MCP automation system with clear phases, deliverables, and success criteria.

<function_calls>
<invoke name="TodoWrite">
<parameter name="todos">[{"id": "arch-1", "content": "Design overall system architecture with component diagrams and data flows", "status": "completed"}, {"id": "arch-2", "content": "Create technical specifications for MCP registry schema and APIs", "status": "completed"}, {"id": "arch-3", "content": "Design agent integration patterns and MCP detection protocols", "status": "completed"}, {"id": "arch-4", "content": "Define fallback system architecture and routing logic", "status": "in_progress"}, {"id": "arch-5", "content": "Create implementation blueprint with directory structure", "status": "completed"}, {"id": "arch-6", "content": "Update handoff notes with architectural decisions", "status": "pending"}]