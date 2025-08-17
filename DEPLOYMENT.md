# BOS-AI Deployment Guide 🚀

**Complete Instructions for Deploying BOS-AI to Your Claude Code Projects**

## Quick Start (30 Seconds)

### For New Projects
```bash
# 1. Navigate to your project folder
cd "path/to/your/project"

# 2. Run the installation
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

That's it! You now have 30 AI agents ready to use in Claude Code.

## What Gets Installed

### 📁 Directory Structure Created
```
your-project/
├── .claude/
│   └── agents/           # 30 AI agents for Claude Code
├── .bos-ai/              # BOS-AI configuration
│   ├── agents/           # Agent definitions
│   ├── missions/         # Business workflows
│   ├── templates/        # Document templates
│   └── config.json       # Configuration
├── assets/               # Business documents
│   ├── business-bibles/  # Marketing, Sales, Operations guides
│   ├── client-success-blueprint/
│   └── strategic-plans/
├── intelligence/         # Business intelligence
│   ├── business-chassis/ # Chassis tracking
│   ├── client-intelligence/
│   └── market-intelligence/
├── CLAUDE.md            # Claude Code integration guide
└── bos-ai-init.sh       # Initialization script
```

### 🤖 30 Specialized AI Agents

**Central Intelligence (3)**
- `chassis-intelligence` - Business Chassis optimization
- `client-success-intelligence` - Customer success focus
- `multiplication-engine` - Compound benefit optimization

**Discovery Engine (3)**
- `market-intelligence` - Market research
- `opportunity-validation` - Opportunity validation
- `strategic-opportunity` - Strategic development

**Creation Engine (3)**
- `solution-design` - 10x solution design
- `rapid-development` - Agile development
- `value-optimization` - Value maximization

**Delivery Engine (3)**
- `customer-success` - Customer management
- `quality-assurance` - Quality standards
- `delivery-optimization` - Delivery excellence

**Growth Engine (3)**
- `scaling-strategy` - Scaling planning
- `market-expansion` - Market expansion
- `revenue-optimization` - Revenue growth

**Business Functions (15)**
- Marketing (3): `brand-strategy`, `campaign-execution`, `content-creation`
- Sales (3): `pipeline-management`, `conversion-optimization`, `revenue-operations`
- Customer Service (3): `support-management`, `satisfaction-optimization`, `retention-strategy`
- Financial (3): `budget-planning`, `performance-analysis`, `investment-strategy`
- Legal (3): `compliance-management`, `risk-assessment`, `contract-management`

## Installation Options

### Full Installation (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```
Installs all 30 agents, complete framework, missions, and templates.

### Business Installation
```bash
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s business
```
Installs core engines + marketing, sales, and customer service agents.

### Core Installation
```bash
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s core
```
Installs only the four engines and central intelligence (15 agents).

## Using Agents in Claude Code

### How to Reference Agents
In your Claude Code session, reference any agent using the @ symbol:

```
@chassis-intelligence - Optimize my Business Chassis
@market-intelligence - Analyze market opportunities
@solution-design - Design a 10x value solution
@customer-success - Improve customer satisfaction
```

### Example Agent Commands

**Business Analysis:**
```
@chassis-intelligence analyze my current metrics and identify the highest leverage improvement area
```

**Market Research:**
```
@market-intelligence research competitors in the [your industry] space and identify gaps
```

**Solution Development:**
```
@solution-design create a solution that delivers 10x value for [specific problem]
```

**Customer Success:**
```
@customer-success develop a retention strategy for my SaaS customers
```

## Post-Installation Setup

### Step 1: Initialize Business Chassis
```bash
./bos-ai-init.sh
```
This displays your Business Chassis components and explains the multiplication formula.

### Step 2: Create Your Baseline
Navigate to `intelligence/business-chassis/` and create your baseline metrics:
- Current prospects count
- Lead conversion rate
- Client conversion rate
- Average transaction value
- Purchase frequency
- Profit margin

### Step 3: Set Your Client Success Blueprint
In `assets/client-success-blueprint/`, define:
- Ideal client profile
- Success metrics
- Value delivery model
- Retention strategies

## Verification

### Check Installation
```bash
# Count installed agents
ls .claude/agents/ | wc -l
# Should show: 30

# View agent list
ls .claude/agents/
```

### Test an Agent
In Claude Code, type:
```
@chassis-intelligence hello
```
The agent should respond with its role and capabilities.

## Troubleshooting

### Issue: Agents Not Appearing
**Solution:** Ensure you're in the correct project directory when running installation.

### Issue: Permission Denied
**Solution:** Make the script executable:
```bash
chmod +x bos-ai-init.sh
```

### Issue: Incomplete Installation
**Solution:** Remove partial installation and retry:
```bash
rm -rf .bos-ai .claude/agents
# Then run installation again
```

## Updating BOS-AI

To get the latest agents and features:
```bash
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

## Custom Configuration

### Modify Agent Behavior
Edit agents in `.claude/agents/` to customize for your specific business needs.

### Add Custom Missions
Create new mission workflows in `.bos-ai/missions/` following the template structure.

### Business-Specific Templates
Add your own templates to `.bos-ai/templates/` for repeated business processes.

## Example Projects

### For SaaS Business
```bash
cd ~/Projects/my-saas-startup
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

### For Consulting Business
```bash
cd ~/Projects/consulting-firm
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s business
```

### For E-commerce
```bash
cd ~/Projects/online-store
curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

## Business Chassis Optimization

After installation, focus on optimizing your Business Chassis components:

1. **Start with Margin** (bottom of bucket)
   - Use `@performance-analysis` to identify cost reduction opportunities
   - Use `@investment-strategy` to optimize resource allocation

2. **Improve Transaction Frequency**
   - Use `@retention-strategy` to increase repeat purchases
   - Use `@customer-success` to enhance satisfaction

3. **Increase Average Spend**
   - Use `@revenue-optimization` to develop upsell strategies
   - Use `@solution-design` to create higher-value offerings

4. **Optimize Client Conversion**
   - Use `@conversion-optimization` to improve sales process
   - Use `@pipeline-management` to reduce friction

5. **Improve Lead Conversion**
   - Use `@campaign-execution` to nurture leads better
   - Use `@content-creation` to educate prospects

6. **Grow Prospects**
   - Use `@market-expansion` to reach new markets
   - Use `@brand-strategy` to increase awareness

## Support and Resources

### Documentation
- [BOS Framework Guide](https://github.com/TheWayWithin/BOS-AI)
- [Agent Documentation](https://github.com/TheWayWithin/BOS-AI/tree/main/agents)
- [Mission Templates](https://github.com/TheWayWithin/BOS-AI/tree/main/missions)

### Community
- Report issues: [GitHub Issues](https://github.com/TheWayWithin/BOS-AI/issues)
- Discussions: [GitHub Discussions](https://github.com/TheWayWithin/BOS-AI/discussions)

## License

BOS-AI is open source under the MIT License. Use it freely to transform your business!

---

**Ready to multiply your business success? Install BOS-AI and start optimizing your Business Chassis today!**