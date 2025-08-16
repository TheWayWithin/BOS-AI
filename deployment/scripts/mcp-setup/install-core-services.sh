#!/bin/bash

# BOS-AI MCP Core Services Installation Script
# Installs the essential MCP services for the BOS Framework agent ecosystem

set -e  # Exit on any error

echo "🚀 BOS-AI MCP Core Services Installation"
echo "======================================"

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

# Check prerequisites
log_info "Checking prerequisites..."

# Check Node.js and npm
if ! command -v node &> /dev/null; then
    log_error "Node.js is required but not installed"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    log_error "npm is required but not installed"
    exit 1
fi

NODE_VERSION=$(node --version)
NPM_VERSION=$(npm --version)
log_success "Node.js $NODE_VERSION and npm $NPM_VERSION detected"

# Create necessary directories
log_info "Creating BOS-AI directories..."
mkdir -p /tmp/bos-ai/screenshots
mkdir -p /tmp/bos-ai/logs
log_success "Directories created"

# Install Core MCP Services
echo ""
log_info "Installing Core MCP Services..."

# 1. Git MCP Server (Official Anthropic)
log_info "Installing Git MCP Server..."
if npx -y @anthropic-ai/mcp-server-git --version &> /dev/null; then
    log_success "Git MCP Server installed successfully"
else
    log_warning "Git MCP Server installation may have issues - will retry during first use"
fi

# 2. Playwright MCP Server (Official Anthropic)
log_info "Installing Playwright MCP Server..."
if npx -y @anthropic-ai/mcp-server-playwright --version &> /dev/null; then
    log_success "Playwright MCP Server installed successfully"
    
    # Install Playwright browsers
    log_info "Installing Playwright browsers..."
    npx playwright install chromium
    log_success "Chromium browser installed for Playwright"
else
    log_warning "Playwright MCP Server installation may have issues - will retry during first use"
fi

# 3. Context7 MCP Server (if available)
log_info "Checking Context7 MCP Server availability..."
# Note: Context7 may not have an official MCP server yet
# This is a placeholder for when it becomes available
log_warning "Context7 MCP Server not yet available - using placeholder configuration"

echo ""
log_success "Core MCP Services installation completed!"

# Display next steps
echo ""
echo "🔧 Next Steps:"
echo "=============="
echo "1. Copy the claude_desktop_config.json to your Claude Desktop config location"
echo "2. Update API keys in the configuration file"
echo "3. Restart Claude Desktop to load the MCP services"
echo "4. Test connectivity using the validation script"
echo ""
echo "Configuration file location:"
echo "$(pwd)/../../configs/mcp-configs/claude_desktop_config.json"
echo ""
echo "Run the validation script:"
echo "bash $(pwd)/validate-mcp-services.sh"
echo ""

log_success "BOS-AI MCP Core Services setup completed!"