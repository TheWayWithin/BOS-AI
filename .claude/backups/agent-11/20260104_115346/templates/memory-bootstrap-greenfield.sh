#!/bin/bash

# BOS-AI Memory Bootstrap Script - Greenfield Business Setup
# This script initializes memory files for a new business from business plan documents

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOS_AI_ROOT="$(dirname "$SCRIPT_DIR")"
MEMORIES_DIR="$BOS_AI_ROOT/memories"
WORKSPACE_DIR="$BOS_AI_ROOT/workspace"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 BOS-AI Memory Bootstrap - Greenfield Business Setup${NC}"
echo "=================================================="

# Function to prompt for input with default
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    local result
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " result
        echo "${result:-$default}"
    else
        read -p "$prompt: " result
        echo "$result"
    fi
}

# Function to replace placeholder in file
replace_placeholder() {
    local file="$1"
    local placeholder="$2"
    local value="$3"
    
    if [ -f "$file" ]; then
        sed -i.bak "s|$placeholder|$value|g" "$file" && rm "$file.bak"
    fi
}

# Function to update date placeholders
update_dates() {
    local file="$1"
    local current_date=$(date '+%Y-%m-%d %H:%M:%S')
    
    replace_placeholder "$file" "PLACEHOLDER_DATE" "$current_date"
}

echo -e "${YELLOW}📋 Business Information Collection${NC}"
echo "Please provide the following business information:"
echo

# Collect business vision information
echo -e "${GREEN}Vision & Mission${NC}"
business_mission=$(prompt_with_default "Business Mission Statement")
business_vision=$(prompt_with_default "Business Vision Statement")
core_value_1=$(prompt_with_default "Core Value #1")
core_value_2=$(prompt_with_default "Core Value #2")
core_value_3=$(prompt_with_default "Core Value #3")

# Collect business model information
echo -e "\n${GREEN}Business Model${NC}"
value_proposition=$(prompt_with_default "Value Proposition")
revenue_stream_1=$(prompt_with_default "Primary Revenue Stream")
revenue_stream_2=$(prompt_with_default "Secondary Revenue Stream")
target_market_1=$(prompt_with_default "Primary Target Market")
target_market_2=$(prompt_with_default "Secondary Target Market")

# Collect strategic objectives
echo -e "\n${GREEN}Strategic Objectives${NC}"
objective_1yr_1=$(prompt_with_default "1-Year Objective #1")
objective_1yr_2=$(prompt_with_default "1-Year Objective #2")
objective_1yr_3=$(prompt_with_default "1-Year Objective #3")
objective_3yr_1=$(prompt_with_default "3-Year Objective #1")
objective_3yr_2=$(prompt_with_default "3-Year Objective #2")
objective_5yr_1=$(prompt_with_default "5-Year Objective")

# Collect success metrics
echo -e "\n${GREEN}Success Metrics${NC}"
annual_revenue_target=$(prompt_with_default "Annual Revenue Target" "\$1,000,000")
profit_margin_target=$(prompt_with_default "Profit Margin Target" "20%")
customer_satisfaction_target=$(prompt_with_default "Customer Satisfaction Target" "90%")

# Collect market information
echo -e "\n${GREEN}Market Intelligence${NC}"
primary_market_segment=$(prompt_with_default "Primary Market Segment")
market_size=$(prompt_with_default "Market Size" "Unknown")
market_growth_rate=$(prompt_with_default "Market Growth Rate" "Unknown")
primary_competitor=$(prompt_with_default "Primary Competitor")
competitive_advantage=$(prompt_with_default "Key Competitive Advantage")

# Collect customer information
echo -e "\n${GREEN}Customer Intelligence${NC}"
primary_persona_name=$(prompt_with_default "Primary Customer Persona Name" "Primary Customer")
persona_age_range=$(prompt_with_default "Customer Age Range" "25-45")
persona_income=$(prompt_with_default "Customer Income Level" "\$50,000-100,000")
persona_location=$(prompt_with_default "Customer Location" "Urban/Suburban")
customer_pain_point=$(prompt_with_default "Primary Customer Pain Point")
customer_goal=$(prompt_with_default "Primary Customer Goal")

echo -e "\n${BLUE}🔧 Updating Memory Files${NC}"

# Update vision.xml
echo "Updating business vision..."
vision_file="$MEMORIES_DIR/business/vision.xml"
update_dates "$vision_file"
replace_placeholder "$vision_file" "PLACEHOLDER_MISSION" "$business_mission"
replace_placeholder "$vision_file" "PLACEHOLDER_VISION" "$business_vision"
replace_placeholder "$vision_file" "PLACEHOLDER_VALUE_1" "$core_value_1"
replace_placeholder "$vision_file" "PLACEHOLDER_VALUE_2" "$core_value_2"
replace_placeholder "$vision_file" "PLACEHOLDER_VALUE_3" "$core_value_3"
replace_placeholder "$vision_file" "PLACEHOLDER_REVENUE_STREAM_1" "$revenue_stream_1"
replace_placeholder "$vision_file" "PLACEHOLDER_REVENUE_STREAM_2" "$revenue_stream_2"
replace_placeholder "$vision_file" "PLACEHOLDER_VALUE_PROPOSITION" "$value_proposition"
replace_placeholder "$vision_file" "PLACEHOLDER_MARKET_1" "$target_market_1"
replace_placeholder "$vision_file" "PLACEHOLDER_MARKET_2" "$target_market_2"
replace_placeholder "$vision_file" "PLACEHOLDER_OBJECTIVE_1" "$objective_1yr_1"
replace_placeholder "$vision_file" "PLACEHOLDER_OBJECTIVE_2" "$objective_1yr_2"
replace_placeholder "$vision_file" "PLACEHOLDER_OBJECTIVE_3" "$objective_1yr_3"
replace_placeholder "$vision_file" "PLACEHOLDER_TARGET" "$annual_revenue_target"

# Update markets.xml
echo "Updating market intelligence..."
markets_file="$MEMORIES_DIR/business/markets.xml"
update_dates "$markets_file"
replace_placeholder "$markets_file" "PLACEHOLDER_SEGMENT" "$primary_market_segment"
replace_placeholder "$markets_file" "PLACEHOLDER_SIZE" "$market_size"
replace_placeholder "$markets_file" "PLACEHOLDER_GROWTH" "$market_growth_rate"
replace_placeholder "$markets_file" "PLACEHOLDER_COMPETITOR_1" "$primary_competitor"
replace_placeholder "$markets_file" "PLACEHOLDER_UVP" "$value_proposition"
replace_placeholder "$markets_file" "PLACEHOLDER_DIFF_1" "$competitive_advantage"

# Update customers.xml
echo "Updating customer intelligence..."
customers_file="$MEMORIES_DIR/business/customers.xml"
update_dates "$customers_file"
replace_placeholder "$customers_file" "PLACEHOLDER_PERSONA_1" "$primary_persona_name"
replace_placeholder "$customers_file" "PLACEHOLDER_AGE" "$persona_age_range"
replace_placeholder "$customers_file" "PLACEHOLDER_INCOME" "$persona_income"
replace_placeholder "$customers_file" "PLACEHOLDER_LOCATION" "$persona_location"
replace_placeholder "$customers_file" "PLACEHOLDER_PAINS" "$customer_pain_point"
replace_placeholder "$customers_file" "PLACEHOLDER_GOALS" "$customer_goal"

# Update operations.xml
echo "Updating operational intelligence..."
operations_file="$MEMORIES_DIR/business/operations.xml"
update_dates "$operations_file"
replace_placeholder "$operations_file" "PLACEHOLDER_CHANNELS" "To be defined"
replace_placeholder "$operations_file" "PLACEHOLDER_RATES" "To be measured"
replace_placeholder "$operations_file" "PLACEHOLDER_COST" "To be calculated"

# Initialize empty strategy files
echo "Initializing strategy files..."
for strategy_file in "$MEMORIES_DIR/strategies"/*.xml; do
    if [ -f "$strategy_file" ]; then
        update_dates "$strategy_file"
        # Replace common placeholders with "To be developed"
        sed -i.bak 's/PLACEHOLDER_[^>]*/To be developed/g' "$strategy_file" && rm "$strategy_file.bak"
    fi
done

# Initialize lesson files
echo "Initializing lesson files..."
for lesson_file in "$MEMORIES_DIR/lessons"/*.xml; do
    if [ -f "$lesson_file" ]; then
        update_dates "$lesson_file"
        # Replace common placeholders with "To be discovered"
        sed -i.bak 's/PLACEHOLDER_[^>]*/To be discovered/g' "$lesson_file" && rm "$lesson_file.bak"
    fi
done

# Initialize technical files
echo "Initializing technical files..."
for tech_file in "$MEMORIES_DIR/technical"/*.xml; do
    if [ -f "$tech_file" ]; then
        update_dates "$tech_file"
        # Replace common placeholders with "To be configured"
        sed -i.bak 's/PLACEHOLDER_[^>]*/To be configured/g' "$tech_file" && rm "$tech_file.bak"
    fi
done

# Create initial progress tracking file
echo "Creating initial progress tracking file..."
progress_file="$WORKSPACE_DIR/progress.md"
mkdir -p "$WORKSPACE_DIR"

cat > "$progress_file" << EOF
# Business Progress Tracking

**Mission**: Business Setup and Memory Initialization  
**Started**: $(date '+%Y-%m-%d %H:%M')  
**Last Updated**: $(date '+%Y-%m-%d %H:%M')  
**Status**: Completed

---

## 🎯 Mission Overview

**Business Objective**: Initialize BOS-AI memory system for new business operations  
**Expected Business Impact**: Foundation for systematic business intelligence and learning  
**Success Criteria**: All memory files populated with initial business information  

---

## 📊 Business Issues & Resolution Log

### Issue #001: Initial Memory System Setup
**Category**: Strategic  
**Priority**: High  
**Business Impact**: Enables systematic business learning and mistake prevention  
**Impact Value**: Foundation for 40% reduction in repeat business mistakes  
**Reported**: $(date '+%Y-%m-%d %H:%M')  
**Reporter**: Memory Bootstrap System  

#### Business Context
**Symptoms**: New business without systematic intelligence capture  
**Business Process Affected**: All future business operations and decision-making  
**Customer Impact**: None (internal system setup)  
**Market Context**: Competitive advantage through systematic learning  

#### Solution Attempts

**Attempt #1** - $(date '+%Y-%m-%d %H:%M')  
**Business Hypothesis**: Initialize comprehensive memory system with business fundamentals  
**Implementation**: Automated bootstrap script with user input collection  
**Cost**: 1 hour setup time  
**Outcome**: ✅ Success  
**Business Learning**: Structured memory initialization enables faster agent intelligence  
**Why It Succeeded**: Comprehensive template system with business-specific categories  

#### Final Resolution
**Status**: ✅ Resolved  
**Final Solution**: Complete memory system initialized with business fundamentals  
**Total Investment**: 1 hour  
**Business ROI**: Foundation for systematic business intelligence  

#### Root Cause Analysis
**Primary Cause**: New business required systematic intelligence foundation  
**Contributing Factors**: Need for cross-session learning and mistake prevention  
**Process Gap**: Previous lack of structured business memory system  
**Market Factor**: Competitive advantage through institutional learning  

#### Prevention Strategy
**Process Changes**: Regular memory updates as business evolves  
**Early Warning Signs**: Outdated or incomplete memory information  
**Responsible Agent**: All BOS-AI agents (cross-functional responsibility)  
**Review Schedule**: Monthly memory system review and updates  

#### Business Intelligence Extracted
**Market Insights**: $primary_market_segment represents primary opportunity  
**Customer Behavior**: $customer_pain_point drives customer decision-making  
**Operational Patterns**: Memory system enables pattern recognition over time  
**Competitive Intelligence**: $competitive_advantage provides market differentiation  
**Strategic Implications**: Systematic learning provides exponential advantage  

---

*Memory system successfully initialized. All BOS-AI agents now have access to business intelligence for informed decision-making.*
EOF

echo -e "\n${GREEN}✅ Memory Bootstrap Complete!${NC}"
echo "=================================================="
echo -e "📁 Memory files initialized in: ${BLUE}$MEMORIES_DIR${NC}"
echo -e "📋 Progress tracking started in: ${BLUE}$progress_file${NC}"
echo -e "🧠 BOS-AI agents now have access to business intelligence"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Review and refine memory files as your business evolves"
echo "2. Use BOS-AI agents - they will now reference this business intelligence"
echo "3. Update memory files regularly as you learn more about your market and customers"
echo "4. Use the progress tracking system to capture business learnings"
echo
echo -e "${GREEN}🚀 Your BOS-AI system is now ready for intelligent business operations!${NC}"