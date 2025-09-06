#!/bin/bash
# BOS-AI MCP Automation Installation Script
# Automated installation of Tier 1 MCPs with comprehensive error handling
# Version: 1.0.0

set -euo pipefail

# === CONFIGURATION ===
readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly WORKSPACE_DIR="/Users/jamiewatters/DevProjects/BOS-AI/workspace"
readonly CONFIG_DIR="$WORKSPACE_DIR/config"
readonly LOG_DIR="$WORKSPACE_DIR/logs"
readonly CACHE_DIR="$WORKSPACE_DIR/cache"

# Files
readonly LOG_FILE="$LOG_DIR/mcp-install-$(date +%Y%m%d-%H%M%S).log"
readonly REGISTRY_FILE="$CONFIG_DIR/mcp-registry.yaml"
readonly STATUS_FILE="$CONFIG_DIR/mcp-status.yaml"
readonly BACKUP_DIR="$CONFIG_DIR/backup"

# Configuration
readonly INSTALLATION_TIMEOUT=300  # 5 minutes
readonly HEALTH_CHECK_TIMEOUT=30   # 30 seconds
readonly MAX_RETRY_ATTEMPTS=3

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# === LOGGING FUNCTIONS ===
log() {
  local level="$1"
  shift
  local message="$*"
  local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  
  # Log to file
  echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE" >/dev/null
  
  # Log to console with colors
  case "$level" in
    ERROR)
      echo -e "${RED}❌ $message${NC}" >&2
      ;;
    WARN)
      echo -e "${YELLOW}⚠️  $message${NC}"
      ;;
    INFO)
      echo -e "${BLUE}ℹ️  $message${NC}"
      ;;
    SUCCESS)
      echo -e "${GREEN}✅ $message${NC}"
      ;;
    DEBUG)
      if [[ "${DEBUG:-}" == "1" ]]; then
        echo -e "🔍 $message"
      fi
      ;;
    *)
      echo "$message"
      ;;
  esac
}

log_info() { log "INFO" "$@"; }
log_warn() { log "WARN" "$@"; }
log_error() { log "ERROR" "$@"; }
log_success() { log "SUCCESS" "$@"; }
log_debug() { log "DEBUG" "$@"; }

# === UTILITY FUNCTIONS ===
show_header() {
  echo ""
  echo "🚀 BOS-AI MCP Installation Script v$SCRIPT_VERSION"
  echo "=================================================="
  echo "Started at: $(date)"
  echo "Log file: $LOG_FILE"
  echo ""
}

# Create required directories
init_directories() {
  log_info "Initializing directory structure"
  
  local dirs=("$CONFIG_DIR" "$LOG_DIR" "$BACKUP_DIR" "$CACHE_DIR")
  
  for dir in "${dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
      mkdir -p "$dir" || {
        log_error "Failed to create directory: $dir"
        exit 1
      }
      log_debug "Created directory: $dir"
    fi
  done
  
  log_success "Directory structure initialized"
}

# Check system prerequisites
check_prerequisites() {
  log_info "Checking system prerequisites"
  
  # Check Claude Code CLI
  if ! command -v claude &> /dev/null; then
    log_error "Claude Code CLI not found"
    log_info "Please install Claude Code first: https://claude.ai/code"
    exit 1
  fi
  
  # Get Claude Code version
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
      log_warn "Node.js version $node_version detected. Version 18+ recommended for optimal MCP compatibility"
    fi
  else
    log_warn "Node.js not found. Some MCPs may require Node.js runtime"
  fi
  
  # Check npm
  if command -v npm &> /dev/null; then
    local npm_version=$(npm --version)
    log_success "npm detected: v$npm_version"
  else
    log_warn "npm not found. Some MCPs may require npm for installation"
  fi
  
  # Check git
  if command -v git &> /dev/null; then
    local git_version=$(git --version)
    log_success "Git detected: $git_version"
  else
    log_warn "Git not found. GitHub MCP may have limited functionality"
  fi
  
  log_success "Prerequisites check completed"
}

# Backup existing configuration
backup_existing_config() {
  if [[ -f "$REGISTRY_FILE" ]]; then
    local backup_file="$BACKUP_DIR/mcp-registry-$(date +%Y%m%d-%H%M%S).yaml"
    cp "$REGISTRY_FILE" "$backup_file" || {
      log_error "Failed to backup existing registry"
      exit 1
    }
    log_info "Backed up existing registry to: $backup_file"
  fi
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
    log_debug "Installation attempt $attempt/$max_attempts for $name"
    
    # Build claude mcp add command
    local cmd_args=("mcp" "add" "$name" "--scope" "$scope")
    
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
    log_debug "Running: claude ${cmd_args[*]}"
    
    if timeout "$INSTALLATION_TIMEOUT" claude "${cmd_args[@]}" 2>&1 | tee -a "$LOG_FILE"; then
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
      local delay=$((attempt * 3))  # Progressive delay: 3s, 6s, 9s
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
  
  log_debug "Verifying installation of $mcp_name"
  
  # Give MCP a moment to initialize
  sleep 2
  
  # Basic connection test
  if timeout "$HEALTH_CHECK_TIMEOUT" claude mcp test "$mcp_name" &>/dev/null; then
    log_debug "$mcp_name verification passed"
    return 0
  else
    log_debug "$mcp_name verification failed"
    return 1
  fi
}

# Install Tier 1 (Essential) MCPs
install_tier1_mcps() {
  log_info "Installing Tier 1 (Essential) MCPs"
  echo "====================================="
  
  # Define Tier 1 MCPs with their configuration
  # Format: "name transport endpoint scope required description"
  local -a tier1_mcps=(
    "github stdio npx\ @modelcontextprotocol/server-github project true GitHub repository operations and issue tracking"
    "filesystem stdio npx\ @modelcontextprotocol/server-filesystem\ $WORKSPACE_DIR project true Local file system operations"
    # IDE MCP should already be available in Claude Code
  )
  
  local installed=0
  local failed=0
  local total=${#tier1_mcps[@]}
  
  log_info "Installing $total essential MCPs..."
  
  for mcp_config in "${tier1_mcps[@]}"; do
    # Parse configuration (space-delimited, handle escaped spaces)
    IFS=' ' read -r -a config <<< "$mcp_config"
    local name="${config[0]}"
    local transport="${config[1]}"
    local endpoint="${config[2]/\\ / }"  # Unescape spaces
    local scope="${config[3]}"
    local required="${config[4]}"
    local description="${config[5]}"
    
    log_info "Installing $name: $description"
    
    if install_mcp "$name" "$transport" "$endpoint" "$scope" "$required"; then
      ((installed++))
      log_success "✓ $name installed successfully"
    else
      ((failed++))
      log_error "✗ $name installation failed"
    fi
    
    log_info "Progress: $((installed + failed))/$total completed"
    echo ""
  done
  
  # Installation summary
  echo ""
  log_info "Tier 1 Installation Summary:"
  log_info "  Total MCPs: $total"
  log_info "  Installed: $installed"  
  log_info "  Failed: $failed"
  log_info "  Success Rate: $(( installed * 100 / total ))%"
  
  # Validate minimum requirements
  local minimum_required=1  # Need at least 1 Tier 1 MCP for basic functionality
  if [[ $installed -lt $minimum_required ]]; then
    log_error "Insufficient Tier 1 MCPs installed ($installed/$minimum_required minimum required)"
    log_error "BOS-AI may not function optimally. Please resolve installation issues."
    
    # Don't exit - allow partial functionality
    log_warn "Continuing with partial MCP installation..."
  else
    log_success "Minimum MCP requirements satisfied"
  fi
  
  log_success "Tier 1 MCP installation phase completed"
}

# Check for optional Tier 2 MCPs
check_tier2_mcps() {
  log_info "Checking for Tier 2 MCP prerequisites"
  
  local tier2_available=0
  
  # Check for GitHub token
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    log_success "GitHub token detected - GitHub MCP can access private repositories"
    ((tier2_available++))
  else
    log_info "GitHub token not found - GitHub MCP will have limited functionality"
    log_info "Set GITHUB_TOKEN environment variable for full GitHub integration"
  fi
  
  # Check for Stripe API key
  if [[ -n "${STRIPE_API_KEY:-}" ]]; then
    log_success "Stripe API key detected - revenue analytics available"
    ((tier2_available++))
  else
    log_info "Stripe API key not found - revenue analytics unavailable"
    log_info "Set STRIPE_API_KEY environment variable for financial data integration"
  fi
  
  # Check for Linear API key
  if [[ -n "${LINEAR_API_KEY:-}" ]]; then
    log_success "Linear API key detected - project management integration available"
    ((tier2_available++))
  else
    log_info "Linear API key not found - project management integration unavailable"
    log_info "Set LINEAR_API_KEY environment variable for Linear integration"
  fi
  
  if [[ $tier2_available -gt 0 ]]; then
    log_info "Found $tier2_available Tier 2 MCP prerequisites"
    log_info "Run with --install-tier2 flag to install optional MCPs"
  else
    log_info "No Tier 2 MCP prerequisites found - skipping optional installations"
  fi
}

# Generate initial MCP registry
generate_initial_registry() {
  log_info "Generating MCP registry"
  
  # Create registry template
  cat > "$REGISTRY_FILE" << EOF
version: "1.0"
metadata:
  registry_format_version: "1.0.0"
  created: "$(date -Iseconds)"
  last_updated: "$(date -Iseconds)"
  update_frequency: 300
  health_check_interval: 300
  installation_script_version: "$SCRIPT_VERSION"

registry:
  # Registry entries will be populated by the update script
  # This file is managed by BOS-AI MCP automation system
EOF
  
  log_success "Initial registry created: $REGISTRY_FILE"
  
  # Update registry with current MCP status using Node.js script
  if [[ -f "$SCRIPT_DIR/../src/mcp/detector.js" ]]; then
    log_info "Updating registry with installed MCP data"
    
    # Run detection script
    if node -e "
      const MCPDetector = require('$SCRIPT_DIR/../src/mcp/detector.js');
      const detector = new MCPDetector();
      detector.detectAvailableMCPs(true).then(results => {
        console.log('Detection completed:', results.connected + '/' + results.totalDetected + ' MCPs connected');
      }).catch(err => {
        console.error('Detection failed:', err.message);
        process.exit(1);
      });
    " 2>&1 | tee -a "$LOG_FILE"; then
      log_success "Registry populated with MCP data"
    else
      log_warn "Registry update failed, registry may be incomplete"
    fi
  else
    log_warn "MCP detector not found, registry will have basic structure only"
  fi
}

# Run comprehensive health check
run_health_check() {
  log_info "Running initial health check"
  
  # Check if health check script exists
  local health_script="$SCRIPT_DIR/check-mcp-status.sh"
  if [[ -x "$health_script" ]]; then
    if "$health_script" --quiet; then
      log_success "Health check passed - all MCPs functioning properly"
    else
      local health_exit_code=$?
      case $health_exit_code in
        1)
          log_warn "Health check completed with warnings (some MCPs degraded)"
          ;;
        2)
          log_error "Health check detected critical issues"
          ;;
        *)
          log_error "Health check failed with unknown error (exit code: $health_exit_code)"
          ;;
      esac
    fi
  else
    log_warn "Health check script not found, performing basic verification"
    
    # Basic verification - check if claude mcp list works
    if claude mcp list &>/dev/null; then
      log_success "Basic MCP system verification passed"
    else
      log_error "Basic MCP system verification failed"
    fi
  fi
}

# Display installation summary and next steps
show_summary() {
  local end_time=$(date +%s)
  local start_time="${START_TIME:-$end_time}"
  local duration=$((end_time - start_time))
  
  echo ""
  log_success "BOS-AI MCP Installation Completed"
  echo "=================================="
  log_info "Total Installation Time: ${duration}s"
  log_info "Installation Log: $LOG_FILE"
  log_info "Registry File: $REGISTRY_FILE"
  
  # Show installed MCPs
  echo ""
  log_info "Installed MCPs:"
  if claude mcp list 2>/dev/null; then
    claude mcp list 2>/dev/null | sed 's/^/  /' || log_warn "Could not retrieve detailed MCP list"
  else
    log_warn "Could not retrieve MCP list - this may indicate installation issues"
  fi
  
  # Show environment recommendations
  echo ""
  log_info "🔧 Environment Setup Recommendations:"
  echo "  1. Set environment variables for enhanced MCP functionality:"
  echo "     export GITHUB_TOKEN=your_github_token_here"
  echo "     export STRIPE_API_KEY=your_stripe_key_here" 
  echo "     export LINEAR_API_KEY=your_linear_key_here"
  echo ""
  
  # Next steps
  log_info "📝 Next Steps:"
  echo "  1. Run './scripts/check-mcp-status.sh' to verify all connections"  
  echo "  2. Check the registry at: $REGISTRY_FILE"
  echo "  3. Review installation log: $LOG_FILE"
  echo "  4. Test BOS-AI agents - they now have enhanced MCP capabilities"
  echo ""
  log_success "🎉 BOS-AI MCP Installation Complete!"
  echo ""
  log_info "Your BOS-AI agents now have access to automated MCP integrations."
  log_info "They will automatically detect and use available MCPs, with intelligent"
  log_info "fallback to alternative methods when MCPs are unavailable."
}

# Handle installation errors
handle_installation_error() {
  local exit_code=$1
  log_error "Installation encountered an error (exit code: $exit_code)"
  log_info "Check the log file for details: $LOG_FILE"
  log_info "You can:"
  log_info "  1. Fix the issue and re-run the installation"
  log_info "  2. Continue with partial MCP functionality"
  log_info "  3. Install MCPs manually using 'claude mcp add' commands"
}

# === ARGUMENT PARSING ===
INSTALL_TIER2=false
DEBUG=false
QUIET=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --install-tier2)
      INSTALL_TIER2=true
      shift
      ;;
    --debug)
      DEBUG=1
      shift
      ;;
    --quiet)
      QUIET=true
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --install-tier2  Install Tier 2 MCPs (requires API keys)"
      echo "  --debug          Enable debug output"
      echo "  --quiet          Suppress non-essential output"
      echo "  --help, -h       Show this help message"
      echo ""
      exit 0
      ;;
    *)
      log_error "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# === MAIN EXECUTION ===
main() {
  local start_time=$(date +%s)
  START_TIME=$start_time
  
  # Initialize logging directory first
  mkdir -p "$LOG_DIR" 2>/dev/null || true
  
  if [[ "$QUIET" != "true" ]]; then
    show_header
  fi
  
  log_info "BOS-AI MCP Installation Starting"
  log_debug "Script arguments: $*"
  log_debug "Environment: Node $(node --version 2>/dev/null || echo 'not found'), npm $(npm --version 2>/dev/null || echo 'not found')"
  
  # Execute installation steps
  init_directories
  backup_existing_config
  check_prerequisites
  install_tier1_mcps
  check_tier2_mcps
  generate_initial_registry
  run_health_check
  
  if [[ "$QUIET" != "true" ]]; then
    show_summary
  fi
  
  log_success "Installation completed successfully"
}

# === ERROR HANDLING ===
cleanup() {
  local exit_code=$?
  
  if [[ $exit_code -ne 0 ]]; then
    handle_installation_error $exit_code
  fi
  
  exit $exit_code
}

# Set up signal handlers
trap cleanup EXIT
trap 'log_error "Installation interrupted by user"; exit 130' INT TERM

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi