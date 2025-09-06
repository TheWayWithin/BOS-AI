#!/bin/bash
# BOS-AI MCP Health Check Script
# Comprehensive MCP health monitoring and status reporting
# Version: 1.0.0

set -euo pipefail

# === CONFIGURATION ===
readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly WORKSPACE_DIR="/Users/jamiewatters/DevProjects/BOS-AI/workspace"
readonly CONFIG_DIR="$WORKSPACE_DIR/config"
readonly LOG_DIR="$WORKSPACE_DIR/logs"

readonly REGISTRY_FILE="$CONFIG_DIR/mcp-registry.yaml"
readonly STATUS_FILE="$CONFIG_DIR/mcp-status.yaml"
readonly HEALTH_LOG="$LOG_DIR/mcp-health-$(date +%Y%m%d).log"

# Health check timeout (seconds)
readonly HEALTH_CHECK_TIMEOUT=15
readonly CONNECTION_TIMEOUT=10
readonly QUICK_CHECK_TIMEOUT=5

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly GRAY='\033[0;37m'
readonly NC='\033[0m' # No Color

# Options
QUIET=false
QUICK_MODE=false
VERBOSE=false

# === LOGGING FUNCTIONS ===
log_with_color() {
  local color="$1"
  local symbol="$2"
  local message="$3"
  local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  
  # Log to file
  echo "[$timestamp] $message" >> "$HEALTH_LOG"
  
  # Log to console if not quiet
  if [[ "$QUIET" != "true" ]]; then
    echo -e "${color}${symbol} ${message}${NC}"
  fi
}

log_success() { log_with_color "$GREEN" "✅" "$1"; }
log_error() { log_with_color "$RED" "❌" "$1"; }
log_warn() { log_with_color "$YELLOW" "⚠️ " "$1"; }
log_info() { log_with_color "$BLUE" "ℹ️ " "$1"; }
log_debug() { 
  if [[ "$VERBOSE" == "true" ]]; then
    log_with_color "$GRAY" "🔍" "$1"
  fi
}

# === HEALTH CHECK FUNCTIONS ===

# Initialize health check environment
init_health_check() {
  # Ensure log directory exists
  mkdir -p "$LOG_DIR" 2>/dev/null || true
  
  # Clear old log if it exists and is larger than 10MB
  if [[ -f "$HEALTH_LOG" ]] && [[ $(stat -c%s "$HEALTH_LOG" 2>/dev/null || stat -f%z "$HEALTH_LOG" 2>/dev/null || echo 0) -gt 10485760 ]]; then
    mv "$HEALTH_LOG" "${HEALTH_LOG}.old"
    log_info "Rotated large health log file"
  fi
  
  log_info "Health check starting at $(date)"
  log_debug "Using timeout: ${HEALTH_CHECK_TIMEOUT}s, Quick mode: $QUICK_MODE"
}

# Get list of MCPs to check
get_mcps_to_check() {
  local mcps_found=false
  declare -a mcp_list=()
  
  # Try to get MCPs from Claude Code
  if command -v claude &>/dev/null; then
    log_debug "Getting MCP list from Claude Code"
    
    local claude_output
    if claude_output=$(timeout 10 claude mcp list 2>/dev/null); then
      log_debug "Claude MCP list output received"
      
      # Parse the output to extract MCP names
      while IFS= read -r line; do
        # Skip empty lines and headers
        [[ -z "$line" || "$line" == *"Name"* || "$line" == *"---"* ]] && continue
        
        # Extract MCP name (first field)
        local mcp_name=$(echo "$line" | awk '{print $1}')
        if [[ -n "$mcp_name" && "$mcp_name" != "Name" ]]; then
          mcp_list+=("$mcp_name")
          mcps_found=true
        fi
      done <<< "$claude_output"
    else
      log_warn "Could not get MCP list from Claude Code"
    fi
  else
    log_warn "Claude Code CLI not found"
  fi
  
  # If no MCPs found, use default list
  if [[ "$mcps_found" == false ]]; then
    log_info "Using default MCP list for testing"
    mcp_list=("github" "filesystem" "ide")
  fi
  
  printf '%s\n' "${mcp_list[@]}"
}

# Test individual MCP health
check_mcp_health() {
  local mcp_id="$1"
  local start_time=$(date +%s%3N)
  local timeout=${HEALTH_CHECK_TIMEOUT}
  
  if [[ "$QUICK_MODE" == "true" ]]; then
    timeout=$QUICK_CHECK_TIMEOUT
  fi
  
  log_debug "Testing $mcp_id with ${timeout}s timeout"
  
  local status="unknown"
  local error_message=""
  local response_time=0
  local test_output=""
  
  # Try to test the MCP
  if test_output=$(timeout "$timeout" claude mcp test "$mcp_id" 2>&1); then
    status="connected"
    log_debug "$mcp_id test succeeded"
  else
    local exit_code=$?
    log_debug "$mcp_id test failed with exit code $exit_code"
    
    case $exit_code in
      124)
        status="degraded"
        error_message="Connection timeout (>${timeout}s)"
        ;;
      1)
        if [[ "$test_output" == *"not found"* || "$test_output" == *"unknown"* ]]; then
          status="disconnected"
          error_message="MCP not found or not configured"
        else
          status="error"
          error_message="Connection failed"
        fi
        ;;
      *)
        status="error"
        error_message="Test failed with exit code $exit_code"
        ;;
    esac
    
    # Include relevant error details
    if [[ -n "$test_output" && ${#test_output} -lt 200 ]]; then
      error_message="$error_message: $test_output"
    fi
  fi
  
  local end_time=$(date +%s%3N)
  response_time=$((end_time - start_time))
  
  # Determine final status based on response time
  if [[ "$status" == "connected" ]]; then
    if [[ $response_time -gt 5000 ]]; then
      status="degraded"
      error_message="Slow response time (${response_time}ms)"
    fi
  fi
  
  # Output structured result
  cat << EOF
{
  "mcp_id": "$mcp_id",
  "status": "$status",
  "response_time": $response_time,
  "timestamp": "$(date -Iseconds)",
  "error_message": "$error_message"
}
EOF
}

# Parse MCP health check result
parse_health_result() {
  local json_result="$1"
  
  # Simple JSON parsing using basic shell tools
  local mcp_id=$(echo "$json_result" | grep '"mcp_id"' | cut -d'"' -f4)
  local status=$(echo "$json_result" | grep '"status"' | cut -d'"' -f4)
  local response_time=$(echo "$json_result" | grep '"response_time"' | cut -d':' -f2 | tr -d ' ,')
  local error_message=$(echo "$json_result" | grep '"error_message"' | cut -d'"' -f4)
  
  echo "$mcp_id|$status|$response_time|$error_message"
}

# Display health status with appropriate formatting
display_mcp_status() {
  local mcp_id="$1"
  local status="$2"
  local response_time="$3"
  local error_message="$4"
  
  local status_display=""
  local response_display=""
  
  # Format response time
  if [[ $response_time -gt 0 ]]; then
    response_display=" (${response_time}ms)"
  fi
  
  # Format status with colors and symbols
  case "$status" in
    "connected")
      status_display="${GREEN}✅ Connected${NC}${response_display}"
      ;;
    "degraded")
      status_display="${YELLOW}🟡 Degraded${NC}${response_display}"
      ;;
    "disconnected")
      status_display="${RED}❌ Disconnected${NC}"
      ;;
    "error")
      status_display="${RED}🔴 Error${NC}"
      ;;
    *)
      status_display="${GRAY}❓ Unknown${NC}"
      ;;
  esac
  
  # Display result
  if [[ "$QUIET" != "true" ]]; then
    printf "%-15s %s" "$mcp_id" "$status_display"
    if [[ -n "$error_message" && "$VERBOSE" == "true" ]]; then
      echo " - $error_message"
    else
      echo ""
    fi
  fi
}

# Calculate overall health status
calculate_overall_status() {
  local total="$1"
  local connected="$2"
  local degraded="$3"
  local failed="$4"
  
  local healthy=$((connected + degraded))
  local health_percentage=0
  
  if [[ $total -gt 0 ]]; then
    health_percentage=$((healthy * 100 / total))
  fi
  
  local overall_status="unknown"
  
  # Determine overall status
  if [[ $connected -ge 2 ]]; then
    overall_status="healthy"
  elif [[ $connected -ge 1 || $degraded -ge 1 ]]; then
    overall_status="degraded"
  elif [[ $total -eq 0 ]]; then
    overall_status="no_mcps"
  else
    overall_status="critical"
  fi
  
  echo "$overall_status|$health_percentage"
}

# Generate status summary
generate_status_summary() {
  local timestamp="$1"
  local overall_status="$2"
  local health_percentage="$3"
  local total="$4"
  local connected="$5"
  local degraded="$6"
  local failed="$7"
  
  # Create status file
  cat > "$STATUS_FILE" << EOF
# BOS-AI MCP Status Report
# Generated: $timestamp
# Script Version: $SCRIPT_VERSION

last_check: "$timestamp"
overall_status: "$overall_status"
health_percentage: $health_percentage

mcps:
  total: $total
  connected: $connected
  degraded: $degraded
  failed: $failed
  success_rate: $health_percentage

system:
  script_version: "$SCRIPT_VERSION"
  check_duration: "${CHECK_DURATION:-0}s"
  quick_mode: $QUICK_MODE

# Individual MCP statuses will be updated by the registry manager
EOF
  
  log_debug "Status file updated: $STATUS_FILE"
}

# Display comprehensive summary
show_summary() {
  local timestamp="$1"
  local overall_status="$2"
  local health_percentage="$3"
  local total="$4"
  local connected="$5"
  local degraded="$6"
  local failed="$7"
  
  if [[ "$QUIET" == "true" ]]; then
    return
  fi
  
  echo ""
  echo "📊 BOS-AI MCP Health Summary"
  echo "=============================="
  
  # Overall status with appropriate color
  local status_color="$GRAY"
  local status_symbol="❓"
  
  case "$overall_status" in
    "healthy")
      status_color="$GREEN"
      status_symbol="✅"
      ;;
    "degraded")
      status_color="$YELLOW"
      status_symbol="⚠️ "
      ;;
    "critical")
      status_color="$RED"
      status_symbol="❌"
      ;;
    "no_mcps")
      status_color="$BLUE"
      status_symbol="ℹ️ "
      ;;
  esac
  
  echo -e "Overall Status: ${status_color}${status_symbol} ${overall_status^}${NC}"
  echo "Health Percentage: ${health_percentage}%"
  echo ""
  echo "MCP Breakdown:"
  echo "  Total MCPs: $total"
  echo "  Connected: $connected"
  echo "  Degraded: $degraded"
  echo "  Failed: $failed"
  
  if [[ $total -gt 0 ]]; then
    echo "  Success Rate: $(( (connected + degraded) * 100 / total ))%"
  fi
  
  echo ""
  echo "Report Details:"
  echo "  Generated: $timestamp"
  echo "  Status File: $STATUS_FILE"
  echo "  Health Log: $HEALTH_LOG"
  
  # Recommendations based on status
  echo ""
  case "$overall_status" in
    "healthy")
      log_success "All MCPs are functioning properly!"
      ;;
    "degraded")
      log_warn "Some MCPs are experiencing performance issues"
      echo "  💡 Try running with --verbose to see details"
      echo "  💡 Check network connectivity and API credentials"
      ;;
    "critical")
      log_error "Critical MCP failures detected"
      echo "  🔧 Run the installation script to fix MCP configurations"
      echo "  🔧 Check API credentials and network connectivity"
      echo "  🔧 Review the health log for detailed error information"
      ;;
    "no_mcps")
      log_info "No MCPs detected - run installation script to set up MCPs"
      echo "  🚀 Run: ./scripts/install-bos-ai-mcps.sh"
      ;;
  esac
}

# === MAIN HEALTH CHECK ===
run_health_check() {
  local start_time=$(date +%s)
  local timestamp=$(date -Iseconds)
  local total_mcps=0
  local connected_mcps=0
  local degraded_mcps=0
  local failed_mcps=0
  
  log_info "🔍 BOS-AI MCP Health Check v$SCRIPT_VERSION"
  
  if [[ "$QUICK_MODE" == "true" ]]; then
    log_info "Running in quick mode (${QUICK_CHECK_TIMEOUT}s timeout)"
  fi
  
  if [[ "$QUIET" != "true" ]]; then
    echo "=================================="
  fi
  
  # Get MCPs to check
  local mcps_to_check
  mapfile -t mcps_to_check < <(get_mcps_to_check)
  total_mcps=${#mcps_to_check[@]}
  
  if [[ $total_mcps -eq 0 ]]; then
    log_warn "No MCPs found to check"
    echo "$overall_status|0" | IFS='|' read -r overall_status health_percentage
    generate_status_summary "$timestamp" "no_mcps" 0 0 0 0 0
    [[ "$QUIET" != "true" ]] && show_summary "$timestamp" "no_mcps" 0 0 0 0 0
    return 3
  fi
  
  log_info "Checking $total_mcps MCPs..."
  if [[ "$QUIET" != "true" ]]; then
    echo ""
  fi
  
  # Check each MCP
  for mcp_id in "${mcps_to_check[@]}"; do
    log_debug "Checking $mcp_id"
    
    # Get health status
    local health_result
    health_result=$(check_mcp_health "$mcp_id")
    
    # Parse result
    local parsed_result
    parsed_result=$(parse_health_result "$health_result")
    IFS='|' read -r mcp_name status response_time error_message <<< "$parsed_result"
    
    # Count by status
    case "$status" in
      "connected")
        ((connected_mcps++))
        ;;
      "degraded")
        ((degraded_mcps++))
        ;;
      *)
        ((failed_mcps++))
        ;;
    esac
    
    # Display status
    display_mcp_status "$mcp_name" "$status" "$response_time" "$error_message"
  done
  
  # Calculate overall status
  local overall_result
  overall_result=$(calculate_overall_status "$total_mcps" "$connected_mcps" "$degraded_mcps" "$failed_mcps")
  IFS='|' read -r overall_status health_percentage <<< "$overall_result"
  
  # Calculate check duration
  local end_time=$(date +%s)
  CHECK_DURATION=$((end_time - start_time))
  
  # Generate status summary
  generate_status_summary "$timestamp" "$overall_status" "$health_percentage" "$total_mcps" "$connected_mcps" "$degraded_mcps" "$failed_mcps"
  
  # Show summary
  show_summary "$timestamp" "$overall_status" "$health_percentage" "$total_mcps" "$connected_mcps" "$degraded_mcps" "$failed_mcps"
  
  log_info "Health check completed in ${CHECK_DURATION}s"
  
  # Return appropriate exit code
  case "$overall_status" in
    "healthy") return 0 ;;
    "degraded") return 1 ;;
    "critical") return 2 ;;
    "no_mcps") return 3 ;;
    *) return 4 ;;
  esac
}

# === ARGUMENT PARSING ===
while [[ $# -gt 0 ]]; do
  case $1 in
    --quiet|-q)
      QUIET=true
      shift
      ;;
    --quick)
      QUICK_MODE=true
      shift
      ;;
    --verbose|-v)
      VERBOSE=true
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "BOS-AI MCP Health Check Script v$SCRIPT_VERSION"
      echo "Comprehensive health monitoring for Model Context Protocol servers"
      echo ""
      echo "Options:"
      echo "  --quiet, -q     Suppress non-essential output"
      echo "  --quick         Use shorter timeouts for faster checks"
      echo "  --verbose, -v   Show detailed error messages"
      echo "  --help, -h      Show this help message"
      echo ""
      echo "Exit Codes:"
      echo "  0 - All MCPs healthy"
      echo "  1 - Some MCPs degraded (performance issues)"
      echo "  2 - Critical MCP failures"
      echo "  3 - No MCPs found"
      echo "  4 - Unknown error"
      echo ""
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Use --help for usage information" >&2
      exit 1
      ;;
  esac
done

# === MAIN EXECUTION ===
main() {
  init_health_check
  run_health_check
}

# Error handling
cleanup() {
  local exit_code=$?
  if [[ $exit_code -ne 0 && "$QUIET" != "true" ]]; then
    echo ""
    log_error "Health check encountered an error (exit code: $exit_code)"
    log_info "Check the health log for details: $HEALTH_LOG"
  fi
  exit $exit_code
}

trap cleanup EXIT

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi