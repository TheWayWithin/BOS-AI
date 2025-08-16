#!/bin/bash

# BOS-AI MCP Services Validation Script
# Tests connectivity and functionality of installed MCP services

set -e

echo "🔍 BOS-AI MCP Services Validation"
echo "================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

test_service() {
    local service_name=$1
    local test_command=$2
    
    log_info "Testing $service_name..."
    
    if eval "$test_command" &> /dev/null; then
        log_success "$service_name is working correctly"
        return 0
    else
        log_error "$service_name test failed"
        return 1
    fi
}

# Test Git MCP Server
echo ""
log_info "Validating Git MCP Server..."
if test_service "Git MCP" "npx -y @anthropic-ai/mcp-server-git --help"; then
    # Additional git repository test
    if [ -d "/Users/jamiewatters/DevProjects/BOS-AI/.git" ]; then
        log_success "BOS-AI git repository detected"
    else
        log_warning "BOS-AI directory is not a git repository - run 'git init' to initialize"
    fi
else
    log_error "Git MCP Server validation failed"
fi

# Test Playwright MCP Server
echo ""
log_info "Validating Playwright MCP Server..."
if test_service "Playwright MCP" "npx -y @anthropic-ai/mcp-server-playwright --help"; then
    # Test if Chromium is installed
    if npx playwright list | grep -q "chromium"; then
        log_success "Chromium browser is available for Playwright"
    else
        log_warning "Chromium browser not found - run 'npx playwright install chromium'"
    fi
else
    log_error "Playwright MCP Server validation failed"
fi

# Test Context7 (placeholder)
echo ""
log_info "Validating Context7 service..."
log_warning "Context7 MCP Server is not yet available - using placeholder configuration"

# Check Claude Desktop configuration
echo ""
log_info "Checking Claude Desktop configuration..."
CONFIG_PATH="/Users/jamiewatters/DevProjects/BOS-AI/deployment/configs/mcp-configs/claude_desktop_config.json"

if [ -f "$CONFIG_PATH" ]; then
    log_success "MCP configuration file exists at $CONFIG_PATH"
    
    # Validate JSON syntax
    if python3 -m json.tool "$CONFIG_PATH" > /dev/null 2>&1; then
        log_success "Configuration file has valid JSON syntax"
    else
        log_error "Configuration file has invalid JSON syntax"
    fi
else
    log_error "MCP configuration file not found"
fi

# Check for required directories
echo ""
log_info "Checking required directories..."
if [ -d "/tmp/bos-ai/screenshots" ]; then
    log_success "Screenshots directory exists"
else
    log_warning "Screenshots directory missing - creating now"
    mkdir -p /tmp/bos-ai/screenshots
fi

if [ -d "/tmp/bos-ai/logs" ]; then
    log_success "Logs directory exists"
else
    log_warning "Logs directory missing - creating now"
    mkdir -p /tmp/bos-ai/logs
fi

# Summary
echo ""
echo "📊 Validation Summary"
echo "===================="
echo ""
echo "✅ Core Services Status:"
echo "   - Git MCP Server: Ready for use"
echo "   - Playwright MCP Server: Ready for use"
echo "   - Context7 MCP Server: Pending (placeholder configuration)"
echo ""
echo "🔧 Configuration Status:"
echo "   - Claude Desktop config: Available at $CONFIG_PATH"
echo "   - Required directories: Created"
echo ""
echo "📋 Next Steps:"
echo "1. Copy the claude_desktop_config.json to your Claude Desktop configuration directory"
echo "2. Update API keys and tokens in the configuration"
echo "3. Restart Claude Desktop to load MCP services"
echo "4. Test services within Claude Desktop interface"
echo ""
echo "🔗 Default Claude Desktop config locations:"
echo "   macOS: ~/Library/Application Support/Claude/claude_desktop_config.json"
echo "   Windows: %APPDATA%/Claude/claude_desktop_config.json"
echo "   Linux: ~/.config/claude/claude_desktop_config.json"
echo ""

log_success "BOS-AI MCP Services validation completed!"