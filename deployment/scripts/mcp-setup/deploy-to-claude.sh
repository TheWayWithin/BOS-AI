#!/bin/bash

# BOS-AI MCP Configuration Deployment Script
# Deploys MCP configuration to Claude Desktop

set -e

echo "🚀 BOS-AI MCP Configuration Deployment"
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

# Configuration paths
SOURCE_CONFIG="/Users/jamiewatters/DevProjects/BOS-AI/deployment/configs/mcp-configs/claude_desktop_config.json"
CLAUDE_CONFIG_DIR="$HOME/Library/Application Support/Claude"
CLAUDE_CONFIG_FILE="$CLAUDE_CONFIG_DIR/claude_desktop_config.json"

# Check if source configuration exists
if [ ! -f "$SOURCE_CONFIG" ]; then
    log_error "Source configuration file not found at: $SOURCE_CONFIG"
    exit 1
fi

log_success "Source configuration file found"

# Create Claude configuration directory if it doesn't exist
if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
    log_info "Creating Claude configuration directory..."
    mkdir -p "$CLAUDE_CONFIG_DIR"
    log_success "Claude configuration directory created"
fi

# Backup existing configuration if it exists
if [ -f "$CLAUDE_CONFIG_FILE" ]; then
    BACKUP_FILE="${CLAUDE_CONFIG_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
    log_info "Backing up existing configuration to: $BACKUP_FILE"
    cp "$CLAUDE_CONFIG_FILE" "$BACKUP_FILE"
    log_success "Configuration backed up"
fi

# Copy new configuration
log_info "Deploying BOS-AI MCP configuration..."
cp "$SOURCE_CONFIG" "$CLAUDE_CONFIG_FILE"
log_success "Configuration deployed successfully"

# Validate JSON syntax
if python3 -m json.tool "$CLAUDE_CONFIG_FILE" > /dev/null 2>&1; then
    log_success "Configuration file has valid JSON syntax"
else
    log_error "Configuration file has invalid JSON syntax"
    exit 1
fi

# Display configuration summary
echo ""
echo "📋 Configuration Summary"
echo "======================="
echo "Source: $SOURCE_CONFIG"
echo "Target: $CLAUDE_CONFIG_FILE"
echo ""

# Count enabled and disabled services
ENABLED_COUNT=$(python3 -c "
import json
with open('$CLAUDE_CONFIG_FILE', 'r') as f:
    config = json.load(f)
enabled = sum(1 for service in config['mcpServers'].values() if not service.get('disabled', False))
print(enabled)
" 2>/dev/null || echo "Unknown")

TOTAL_COUNT=$(python3 -c "
import json
with open('$CLAUDE_CONFIG_FILE', 'r') as f:
    config = json.load(f)
print(len(config['mcpServers']))
" 2>/dev/null || echo "Unknown")

echo "📊 Service Status:"
echo "   - Total services configured: $TOTAL_COUNT"
echo "   - Enabled services: $ENABLED_COUNT"
echo "   - Core services ready: Git, Playwright"
echo "   - Pending services: Context7, Supabase, MongoDB, etc."
echo ""

# Display next steps
echo "🔧 Next Steps:"
echo "=============="
echo "1. Update API keys in the configuration file:"
echo "   $CLAUDE_CONFIG_FILE"
echo ""
echo "2. Key updates needed:"
echo "   - Context7 API key (when service becomes available)"
echo "   - Verify GitHub Personal Access Token is valid"
echo "   - Add other service API keys as needed"
echo ""
echo "3. Restart Claude Desktop to load the new configuration"
echo ""
echo "4. Test MCP services within Claude Desktop interface"
echo ""

log_warning "Remember to update API keys before using the services!"
log_success "BOS-AI MCP configuration deployment completed!"

echo ""
echo "🔗 For detailed setup instructions, see:"
echo "/Users/jamiewatters/DevProjects/BOS-AI/docs/technical/mcp-setup-guide.md"