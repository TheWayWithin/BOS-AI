# 🚀 BOS-AI - Your Business Operating System

**BOS-AI runs your BUSINESS. AGENT-11 builds your SOFTWARE.**

Welcome to BOS-AI - Your AI-powered system for business strategy, operations, and exponential growth through Business Chassis optimization.

## ⚠️ CRITICAL: Understanding What BOS-AI Does (and Does NOT Do)

**BOS-AI is for BUSINESS operations, NOT software development.**

This system creates:
- ✅ Business strategy and requirements
- ✅ Product Requirements Documents (PRDs)
- ✅ Operational frameworks (Marketing/Sales/Service Bibles)
- ✅ Market intelligence and customer insights
- ✅ Business process optimization

This system does NOT create:
- ❌ Code or software implementations
- ❌ Technical architecture or database schemas
- ❌ API designs or integrations
- ❌ DevOps or deployment infrastructure

**For technical implementation, you'll use a separate AGENT-11 project.**

**📚 See `.claude/BOUNDARIES.md` for complete details on what BOS-AI does and does NOT do.**

---

## 🏗️ The Two-Project Architecture

BOS-AI follows a clean separation between business and technical work:

```
┌─────────────────────────────────────────────────────────┐
│                     BOS-AI PROJECT                       │
│                  (Business Operations)                   │
│                                                          │
│  • 30 Business Intelligence Agents                      │
│  • Business Strategy & Requirements                     │
│  • Customer Success & Operations                        │
│  • Revenue & Growth Optimization                        │
│  • Market Intelligence & Analysis                       │
│                                                          │
│  OUTPUT: PRD Documents & Business Frameworks            │
└────────────────────┬────────────────────────────────────┘
                     │
                     │ PRD Handoff
                     ↓
┌─────────────────────────────────────────────────────────┐
│                 AGENT-11 PROJECT                         │
│              (Technical Development)                     │
│                                                          │
│  • 11 Technical Development Agents                      │
│  • Software Development & Testing                       │
│  • Technical Architecture & Design                      │
│  • Deployment & DevOps                                  │
│  • Code Implementation                                  │
│                                                          │
│  OUTPUT: Working Software & Products                    │
└────────────────────┬────────────────────────────────────┘
                     │
                     │ Product Delivery
                     ↓
┌─────────────────────────────────────────────────────────┐
│                  BOS-AI OPERATIONS                       │
│               (Business Management)                      │
│                                                          │
│  • Operate and market delivered products                │
│  • Gather customer feedback and insights                │
│  • Identify enhancements and features                   │
│  • Create new PRDs for next iteration                   │
└──────────────────────────────────────────────────────────┘
```

**This workflow keeps business strategy clean from technical implementation.**

---

## 🎯 Quick Start

### The Business Chassis Formula

Transform your business through the multiplication effect:

```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```

**The Multiplication Effect:**
- 10% improvement in each = **77% profit increase**
- 20% improvement in each = **299% profit increase**
- 50% improvement in each = **1,139% profit increase**

**Remember**: Business success is multiplication, not addition. Small improvements across all multipliers create exponential results.

### Essential Commands

- **`/coord`** - Business orchestration (analyze, optimize, coordinate multi-agent missions)
- **`/meeting @agent-name "topic"`** - Direct agent consultation for focused expertise
- **`/report`** - Generate progress reports on business operations
- **`/dailyreport`** - Generate daily progress with AI blog and social media posts (Twitter/X, LinkedIn)
- **`/pmd`** - Post-mortem diagnostic for root cause analysis
- **`/recon`** - UI/UX reconnaissance and assessment (design validation)
- **`/design-review`** - Comprehensive design review of pending changes

**Boundary Reminder**: All commands create business documents, NOT code. For implementation, hand off PRDs to AGENT-11 project.

### Common Scenarios

**Optimize Your Business:**
```
/coord optimize
```
I'll analyze your Business Chassis, identify the weakest multiplier, and coordinate agents to fix it.
*Creates business strategy and PRDs, not code.*

**Set Up Complete Marketing System (4-5 hours):**
```
/coord marketing-system-setup
```
Creates Marketing Bible (strategy), Marketing Plan (tactics), and Content Calendar (execution).
*Produces operational documents ready for your team to execute.*

**Launch a Product:**
```
/coord launch "AI automation tool"
```
I'll orchestrate market research, solution design, go-to-market strategy, and launch execution.
*Creates PRD for technical team to build, plus marketing strategy to sell it.*

---

## 🎯 Command System

### `/coord` - Business Orchestration Mode

Activates **Chassis Intelligence Coordinator** - your central orchestrator for all business operations.

**Key Capabilities:**
- Planning-first approach with TodoWrite integration
- Progress tracking and state preservation
- Multi-agent orchestration with seamless handoffs
- Business Chassis analysis and optimization
- Mission recovery from interruptions

**Usage Examples:**
- `/coord` - Interactive mission menu
- `/coord optimize` - Business Chassis optimization analysis
- `/coord daily` - Daily business review
- `/coord weekly` - Weekly performance analysis
- `/coord launch [product]` - Product/service launch coordination
- `/coord scale` - Scaling strategy development

**Boundary Reminder**: `/coord` creates business strategy and requirements. For technical implementation, create PRD and hand off to AGENT-11 project.

---

### `/meeting` - Agent Consultation Mode

Direct strategic discussions with specialized agents for focused expertise.

**Format:** `/meeting @agent-name "discussion topic"`

**Examples:**
- `/meeting @revenue-optimization "pricing strategy for SaaS product"`
- `/meeting @customer-success "reduce churn by 20%"`
- `/meeting @brand-strategy "Q1 marketing campaign"`
- `/meeting @pipeline-management "improve conversion rates"`

**Boundary Reminder**: Agents provide business insights and strategy, NOT technical implementation. For development work, use AGENT-11 project.

---

### `/report` - Progress Tracking

Generate comprehensive progress reports for business operations and strategic initiatives.

**Usage:**
- `/report` - All activities since last report
- `/report [date]` - Progress since specific date (e.g., `/report 2025-08-20`)
- `/report weekly` - Weekly business review

**Report Contents:**
- Completed business initiatives with impact
- Active strategic projects and status
- Business Chassis performance metrics
- Strategic insights and recommendations

**Boundary Reminder**: Reports track business outcomes (WHAT was delivered), not technical implementation details (HOW it was built).

---

### `/dailyreport` - Daily Progress & Social Media Generation

Automated daily progress capture with AI-enhanced blog and social media post generation for build-in-public documentation.

**Usage:**
- `/dailyreport` - Create/update today's progress with blog and social posts

**Key Features:**
- **Automatic Progress Capture**: Creates structured daily report capturing milestones, issues, and lessons
- **Blog Post Generation**: AI-enhanced blog-ready versions optimized for technical audience
- **Social Media Posts**: Platform-optimized Twitter/X (280 char) and LinkedIn (800-1000 char) posts
- **Build-in-Public Ready**: Copy-paste social posts with character count validation
- **Cost Efficient**: ~$0.002 per complete report (blog + social)

**Output Files:**
```
progress/
├── YYYY-MM-DD.md           # Raw daily report (source of truth)
├── YYYY-MM-DD-blog.md      # Blog post (AI-enhanced narrative)
├── YYYY-MM-DD-twitter.md   # Twitter/X post (280 char)
└── YYYY-MM-DD-linkedin.md  # LinkedIn post (800-1000 char)
```

**Configuration** (add to `.env.mcp`):
```bash
OPENAI_API_KEY=your_key_here
DAILYREPORT_ENABLE_SOCIAL=true
DAILYREPORT_BASE_URL=yourdomain.com
```

**Boundary Reminder**: Creates content marketing materials for your business. For technical product announcements, coordinate with AGENT-11 project.

---

### `/pmd` - Post Mortem Diagnostic

Conduct root cause analysis for operational issues and process improvements.

**Usage:**
- `/pmd` - General system and process analysis
- `/pmd "issue description"` - Specific problem investigation
- `/pmd [component]` - Analyze specific area (e.g., "sales", "marketing")

**Analysis Coverage:**
- Business process bottlenecks
- Business Chassis performance issues
- Strategic alignment problems
- Resource utilization optimization
- PRD clarity and handoff effectiveness

**Boundary Reminder**: Analyzes business process and alignment, NOT technical architecture or code issues.

---

### `/recon` - UI/UX Reconnaissance

Execute comprehensive UI/UX assessment using RECON Protocol.

**Usage:**
- `/recon` - Analyze current UI/UX state
- `/recon [component]` - Focused component assessment

**Use Cases:**
- Pre-launch design validation
- User experience optimization
- Interface consistency audits
- Customer journey assessment

**Boundary Reminder**: Analyzes user experience from business perspective. For technical implementation of improvements, create PRD for AGENT-11.

---

### `/design-review` - Design Review Protocol

Complete design review of pending changes on current branch.

**Usage:**
- `/design-review` - Full design review of branch changes

**Use Cases:**
- Pre-merge design validation
- Quality assurance for design changes
- Systematic design review process
- Brand consistency verification

**Boundary Reminder**: Reviews design from business and brand perspective, NOT technical implementation quality.

---

## 🔴 Available Agents (30 Total)

**These agents create PRDs and business strategy, NOT code.**

### Central Intelligence
- `@chassis-intelligence` - Central orchestration & coordination
- `@client-success-intelligence` - Customer-centric operations
- `@multiplication-engine` - Business Chassis optimization

### Discovery Engine
- `@market-intelligence` - Market research & analysis
- `@opportunity-validation` - Opportunity assessment
- `@strategic-opportunity` - Strategic positioning

### Creation Engine
- `@solution-design` - 10x value solution architecture (PRDs, not code)
- `@rapid-development` - Fast implementation strategy (plans, not coding)
- `@value-optimization` - Value maximization

### Delivery Engine
- `@customer-success` - Customer satisfaction & retention
- `@quality-assurance` - Quality standards and requirements
- `@delivery-optimization` - Efficient delivery processes

### Growth Engine
- `@scaling-strategy` - Business scaling strategy
- `@market-expansion` - New market entry planning
- `@revenue-optimization` - Revenue maximization

### Marketing Function
- `@brand-strategy` - Brand positioning and messaging
- `@campaign-execution` - Marketing campaign strategy
- `@content-creation` - Content strategy and planning

### Sales Function
- `@pipeline-management` - Sales pipeline optimization
- `@conversion-optimization` - Conversion improvement strategy
- `@revenue-operations` - Sales operations and processes

### Customer Service
- `@support-management` - Support operations strategy
- `@satisfaction-optimization` - Customer satisfaction programs
- `@retention-strategy` - Customer retention planning

### Financial Management
- `@budget-planning` - Financial planning and forecasting
- `@performance-analysis` - Financial analytics and insights
- `@investment-strategy` - Investment decision planning

### Legal Compliance
- `@compliance-management` - Regulatory compliance planning
- `@risk-assessment` - Risk management strategy
- `@contract-management` - Contract optimization

**All agents focus on business requirements and strategy. For technical implementation, hand off PRDs to AGENT-11 project.**

---

## 🎯 Mission Library

### What Are Missions?

Missions are **systematic workflows** stored in `/missions/` directory that coordinate multiple specialized agents to accomplish complex business objectives.

**Mission Anatomy:**
- **Input Requirements**: What context or documents you need to provide
- **Agent Coordination**: Which business specialists will be activated
- **Expected Outputs**: What deliverables will be created (documents, frameworks, PRDs)
- **Time Estimate**: How long the mission typically takes
- **Business Impact**: Which Business Chassis components are multiplied

**What Missions Create**: Business documents, strategies, and PRDs - NOT software code.

**Executing a Mission:**
```bash
# Interactive selection (recommended for first-time users)
/coord

# Direct execution with mission name
/coord marketing-system-setup

# Mission with inputs (if required)
/coord campaign-launch lead-generation
```

**Exploring Available Missions:**
- View all missions: Check `/missions/` directory structure
- Category READMEs: `/missions/marketing/README.md`, `/missions/sales/README.md`, etc.
- Mission details: Each mission file contains full briefing

---

### Foundation Missions

**Marketing Operations (8 missions available - 4-5 hours):**

Core missions:
- `marketing-system-setup` - Complete 3-document framework (Bible, Plan, Calendar)
- `marketing-bible-creation` - Strategic marketing foundation (90 min)
- `marketing-plan-development` - Tactical campaign planning (90 min)
- `content-calendar-implementation` - Content execution system (60 min)

Advanced missions:
- `customer-journey-optimization` - 5-stage customer journey marketing (2-3 hours)
- `campaign-launch` - End-to-end campaign execution planning (1-2 weeks)
- `content-batch-creation` - Efficient content production planning (3-4 hours)

**View all marketing missions**: `/missions/marketing/README.md`

---

**Sales Operations (8 missions available - 3-4 hours):**

Core missions:
- `sales-system-setup` - Complete 2-document framework (Bible, Plan)
- `sales-bible-creation` - Strategic sales foundation (2 hours)
- `sales-plan-development` - Tactical sales execution (90 min)

Advanced missions:
- `pipeline-optimization` - Sales pipeline enhancement (2-3 hours)
- `conversion-mastery` - Client conversion optimization (3-4 hours)
- `pricing-strategy` - Value-based pricing implementation (2-3 hours)
- `sales-marketing-alignment` - Cross-function optimization (2-3 hours)

**View all sales missions**: `/missions/sales/README.md`

---

**Customer Service Operations (8 missions available - 3-4 hours):**

Core missions:
- `customer-service-system-setup` - Complete 2-document framework (Bible, Plan)
- `customer-service-bible-creation` - Strategic service foundation (2 hours)
- `customer-service-plan-development` - Tactical service execution (90 min)

Advanced missions:
- `retention-optimization` - Customer retention enhancement (2-3 hours)
- `service-quality-enhancement` - Service quality improvement (2-3 hours)
- `customer-success-enablement` - Success milestone programs (90 min)
- `service-excellence-transformation` - Complete service transformation (4-6 hours)

**View all customer service missions**: `/missions/customer-service/README.md`

---

**Finance Operations (8 missions available - 3-4 hours):**

Core missions:
- `finance-system-setup` - Complete 2-document framework (Bible, Plan)
- `finance-bible-creation` - Strategic profit foundation (2 hours)
- `finance-plan-development` - Tactical cash flow planning (90 min)

Advanced missions:
- `profit-optimization` - Margin and profitability enhancement (2-3 hours)
- `cash-flow-mastery` - Cash flow optimization (2 hours)
- `investment-strategy-development` - Strategic investment planning (90 min)
- `financial-transformation` - Complete financial transformation (4-6 hours)

**View all finance missions**: `/missions/finance/README.md`

---

### Strategic Initiatives

- `product-launch` - New product/service rollout (creates launch PRD and go-to-market strategy)
- `market-entry` - New market expansion (creates market entry strategy and requirements)
- `acquisition-campaign` - Customer acquisition drive (creates campaign strategy)
- `retention-boost` - Customer retention improvement (creates retention program)
- `revenue-sprint` - Revenue optimization push (identifies revenue opportunities)

**Note**: These missions create strategic plans and PRDs. For technical product builds, hand off PRDs to AGENT-11 project.

---

### Daily/Weekly Operations

**Daily:**
- `chassis-review` - Daily Business Chassis metrics review
- `customer-check` - Customer satisfaction pulse check
- `pipeline-update` - Sales pipeline status

**Weekly:**
- `performance-analysis` - Comprehensive performance review
- `optimization-sprint` - Identify and fix bottlenecks
- `competitive-scan` - Market positioning update

**All operations focus on business metrics and strategy, not technical implementation.**

---

### Emergency Response

- `crisis-management` - Handle business crisis (creates response strategy)
- `recovery-plan` - Business recovery strategy (creates recovery roadmap)
- `pivot-strategy` - Business model pivot (creates pivot requirements and PRD)

**Emergency missions create strategic responses, not technical fixes. For technical emergencies, use AGENT-11 project.**

---

## 🧠 Memory & Progress Tracking

### Memory System

BOS-AI maintains institutional memory across sessions to prevent repeated mistakes and compound competitive advantages.

**Memory File Structure:**
```
/memories/
├── business/
│   ├── vision.xml        # Strategic objectives and business model
│   ├── markets.xml       # Market intelligence and competitive insights
│   ├── customers.xml     # Customer personas and behavior patterns
│   └── operations.xml    # Operational performance and process intelligence
├── strategies/
│   ├── marketing.xml     # Marketing campaigns and performance data
│   ├── sales.xml         # Sales strategies and conversion insights
│   └── growth.xml        # Scaling and expansion strategies
└── lessons/
    ├── failures.xml      # Business failures and prevention strategies
    ├── insights.xml      # Key business insights and patterns
    ├── decisions.xml     # Strategic decision history and outcomes
    └── patterns.xml      # Successful business operation patterns
```

**How Memory Works:**
- Agents read memory files before execution
- All strategic decisions, outcomes, and learnings are preserved
- Historical pattern recognition informs future decisions
- Cross-session learning prevents repeated mistakes

**Memory Focus**: BOS-AI memory helps learn business lessons and customer insights, NOT technical implementation solutions.

---

### Progress Tracking System

**Two-Tier Context Strategy:**

1. **FORWARD Context** (`business-plan.md`)
   - Future-focused strategic planning
   - Goals, strategies, planned approaches
   - What we plan to do and why

2. **BACKWARD Context** (`progress.md`)
   - Historical learning and solution tracking
   - All attempted solutions, outcomes, lessons learned
   - What we tried, what worked/failed, and why

**Progress Documentation Requirements:**

All business initiatives must document:
- **Every Attempt** - Not just final solutions, but all approaches tried
- **Business Rationale** - Why each strategy was chosen
- **Investment Costs** - Time, money, opportunity cost
- **Business Learnings** - Market insights, customer behavior patterns
- **Root Cause Analysis** - For all resolved issues
- **Prevention Strategies** - How to avoid this issue in future

**Business Issue Categories:**
- **Financial**: Budget, cash flow, profitability, investment decisions
- **Marketing**: Campaigns, branding, content, lead generation
- **Sales**: Pipeline, conversions, pricing, customer relationships
- **Legal**: Compliance, contracts, intellectual property
- **Operational**: Processes, efficiency, systems, workflows
- **Strategic**: Market positioning, competitive advantage, business model

**Impact Quantification:**

Each issue and solution must include:
- **Revenue Impact**: Direct effect on income/sales
- **Cost Impact**: Additional expenses or savings
- **Time Impact**: Hours/days invested or saved
- **Strategic Impact**: Long-term competitive advantage/disadvantage
- **Opportunity Cost**: What other initiatives were delayed/canceled

**Cross-Session Learning Protocol:**
1. Session Start: Agents read `progress.md` to understand previous learnings
2. Issue Encounter: Log immediately with symptoms and business context
3. Solution Attempts: Document each try with hypothesis and outcome
4. Resolution: Include full root cause analysis and prevention strategy
5. Pattern Recognition: Quarterly review to identify recurring issues
6. Memory Integration: Update memory files with extracted learnings

**Success Metrics:**
- 40% reduction in repeat business mistakes
- Average 3+ solution attempts documented per resolved issue
- 90%+ of resolved issues include root cause analysis
- 100% of resolved issues include prevention strategies

---

## 📚 Operations Library

BOS-AI includes a comprehensive Operations Library providing systematic execution frameworks.

**Structure:**
- **Foundation Library**: Defines WHAT and WHY (strategic layer)
- **Operations Library**: Defines HOW (execution layer)
- **4-Tier Framework**: Strategic Bibles → Tactical Playbooks → SOPs → Templates

**Available Operations:**
- **Marketing Operations**: 3-document framework (Bible, Plan, Calendar)
- **Sales Operations**: 2-document framework (Bible, Plan)
- **Customer Service Operations**: 2-document framework (Bible, Plan)
- **Finance Operations**: 2-document framework (Bible, Plan)

**Document Library Location:**
```
/docs/Document Library/
├── Foundation/                      # Strategic foundation templates
│   ├── Vision and Mission.md
│   ├── Market Research Template.md
│   ├── Client Success Blueprint.md
│   ├── Positioning Statement Template.md
│   ├── Strategic Roadmap.md
│   ├── Brand Style Guide.md
│   ├── Product Requirements Document (PRD).md
│   ├── Pricing Strategy Template.md      # NEW: Value ladder with Marketing Physics
│   └── ... (18 foundation templates & SOPs)
└── Operations/
    ├── Marketing/                  # Complete marketing framework
    ├── Sales/                      # Complete sales framework
    ├── Customer Service/           # Complete service framework
    └── Finance/                    # Complete finance framework
```

**For detailed Operations Library documentation, see:** `/docs/OPERATIONS-LIBRARY.md`

**All operations create business frameworks and documents. For technical implementation of systems, hand off requirements to AGENT-11 project.**

---

## 🚀 Complete Business System Setup

**Four-Pillar Integration (13-17 hours total):**

```
/coord marketing-system-setup      # 4-5 hours
/coord sales-system-setup          # 3-4 hours
/coord customer-service-system-setup  # 3-4 hours
/coord finance-system-setup        # 3-4 hours
/coord complete-business-system    # Integration
```

**Result:** Complete customer journey coverage from awareness through advocacy with 200-400% Business Chassis improvement potential.

**Business Chassis Impact:**
- **Marketing**: Multiplies Prospects + Lead Conversion + Transaction Frequency
- **Sales**: Multiplies Lead Conversion + Client Conversion + Average Spend
- **Customer Service**: Multiplies Transaction Frequency + Margin + Referral Generation
- **Finance**: Multiplies Margin + Average Spend + strategic profit optimization

**All systems produce operational documents your team can execute. For technical product builds, create PRDs and hand off to AGENT-11.**

---

## 💡 Pro Tips & Best Practices

### Getting Started
1. **Start with `/coord optimize`** - Identify your biggest opportunity
2. **Set up marketing framework early** - Foundation for customer acquisition
3. **Add sales framework next** - Convert leads into customers
4. **Add customer service framework** - Retain and grow customer value
5. **Add finance framework** - Optimize profitability and cash flow

### Operational Excellence
6. **Complete business operations in 13-17 hours** - All four frameworks integrated
7. **Use `/meeting` for deep dives** - Specialized expertise for specific challenges
8. **Chain commands** - `/coord` for strategy, `/meeting` for execution
9. **Track metrics continuously** - Measure Business Chassis improvements
10. **Focus on multiplication** - Small improvements in multiple areas = exponential growth

### Strategic Principles
11. **Follow systematic patterns** - Use Bible → Plan → Calendar frameworks
12. **Focus on customer success enablement** - Value creation over value extraction
13. **Use Operations Library** - Reference `/docs/Operations Library/` for frameworks
14. **Monitor progress** - Use `/report` to track implementation status
15. **Analyze bottlenecks** - Use `/pmd` when facing delays or alignment issues
16. **Leverage memory system** - Learn from past decisions and outcomes
17. **Document everything** - Build institutional knowledge for continuous improvement
18. **Remember boundaries** - BOS-AI creates requirements, AGENT-11 builds products

---

## 📈 Success Metrics

Track these KPIs for exponential growth:

- **Prospects**: Total addressable market reach
- **Lead Conversion**: Interest to lead percentage
- **Client Conversion**: Lead to customer percentage
- **Average Spend**: Revenue per transaction
- **Transaction Frequency**: Purchases per period
- **Margin**: Profit percentage

**Remember:** Business success is a multiplication game, not addition. Optimize all six multipliers for exponential results!

**BOS-AI optimizes business metrics. AGENT-11 optimizes technical metrics (code quality, performance, etc.).**

---

## 🚫 What BOS-AI Does NOT Do

**BOS-AI is for business operations, NOT software development.**

### BOS-AI Does NOT Create:
- ❌ Code or software implementations
- ❌ Technical architecture or database schemas
- ❌ API designs or backend integrations
- ❌ DevOps pipelines or deployment infrastructure
- ❌ Unit tests or technical QA
- ❌ Technology stack decisions

### BOS-AI DOES Create:
- ✅ Business strategy and requirements
- ✅ Product Requirements Documents (PRDs)
- ✅ Operational frameworks (Bibles, Plans, Calendars)
- ✅ Market intelligence and customer insights
- ✅ Business process optimization
- ✅ Revenue and growth strategies
- ✅ Customer success programs

**For technical implementation, create a PRD in BOS-AI, then hand off to AGENT-11 project.**

**📚 See `.claude/BOUNDARIES.md` for complete boundary details.**

---

## 🔄 PRD Handoff Process: From BOS-AI to AGENT-11

When you need technical implementation of a product or feature:

### 1. In BOS-AI: Define Business Requirements

```
/coord solution-design "customer dashboard"
```

BOS-AI will:
- Research market needs and customer requirements
- Define business value and success metrics
- Create comprehensive PRD with user stories
- Specify business constraints and acceptance criteria

**Output**: Product Requirements Document (PRD)

---

### 2. Create AGENT-11 Project (Separate Directory)

```bash
# Create new technical project
mkdir ~/MyProduct-Development
cd ~/MyProduct-Development

# Install AGENT-11 framework
curl -fsSL https://raw.githubusercontent.com/USERNAME/AGENT-11/main/install.sh | bash
```

**This is a SEPARATE project for technical development.**

---

### 3. Hand Off PRD to AGENT-11

```bash
# Copy PRD from BOS-AI to AGENT-11 project
cp ~/MyBusiness-BOS-AI/workspace/prds/customer-dashboard-prd.md \
   ~/MyProduct-Development/requirements/
```

In AGENT-11 project:
```
@architect review requirements/customer-dashboard-prd.md
@developer implement customer-dashboard
```

AGENT-11 will:
- Design technical architecture
- Choose technology stack
- Implement code and features
- Test and deploy software

**Output**: Working Software

---

### 4. Return to BOS-AI: Operate the Product

Once AGENT-11 delivers working software:

```
# In BOS-AI project
/coord product-launch "customer dashboard"
```

BOS-AI will:
- Create go-to-market strategy
- Plan marketing campaigns
- Set up customer success programs
- Track business metrics and feedback
- Identify future enhancements (new PRDs)

**The cycle continues**: BOS-AI → PRD → AGENT-11 → Product → BOS-AI Operations

---

## 🏗️ Two-Project Workflow Example

### Scenario: Launching a SaaS Product

**Week 1-2 (BOS-AI):**
```
/coord market-intelligence "project management SaaS"
/coord solution-design "AI-powered project manager"
```
**Output**: Market research + PRD with features and requirements

---

**Week 3-8 (AGENT-11 Project):**
```
@architect design system architecture
@developer implement features
@tester run QA and testing
@operator deploy to production
```
**Output**: Working SaaS application

---

**Week 9+ (BOS-AI):**
```
/coord marketing-system-setup
/coord sales-system-setup
/coord customer-success-enablement
```
**Output**: Complete go-to-market system

---

**Ongoing (Both Projects):**
- **BOS-AI**: Gather customer feedback → Create enhancement PRDs
- **AGENT-11**: Receive PRDs → Implement features → Deploy updates
- **BOS-AI**: Operate product → Optimize business metrics → Repeat

**This separation keeps business strategy clean from technical implementation.**

---

## ⚡ Quick Reference Card

### Most Common Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `/coord optimize` | Find biggest opportunity | Analyze Business Chassis → Recommend mission |
| `/coord [mission-name]` | Execute systematic workflow | `/coord marketing-system-setup` |
| `/meeting @agent "topic"` | Specialist consultation | `/meeting @brand-strategy "positioning"` |
| `/report` | Progress tracking | Shows all completed initiatives |
| `/dailyreport` | Build-in-public content | Blog + Twitter/X + LinkedIn posts |
| `/pmd "issue"` | Root cause analysis | Troubleshooting and diagnostics |

### Quick Start Missions (< 2 hours)
- `marketing-bible-creation` (90 min) - Marketing foundation
- `sales-bible-creation` (2 hours) - Sales foundation
- `finance-bible-creation` (2 hours) - Finance foundation

### Complete System Missions (3-5 hours)
- `marketing-system-setup` (4-5 hours) - Full marketing framework
- `sales-system-setup` (3-4 hours) - Full sales framework
- `customer-service-system-setup` (3-4 hours) - Full service framework
- `finance-system-setup` (3-4 hours) - Full finance framework

### Business Chassis Formula
```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```
10% improvement in each = **77% profit increase**

### Key Concepts
- **Missions**: Systematic workflows coordinating multiple business agents
- **Agents**: 30 specialized experts for different business functions
- **Operations Library**: Business frameworks in `/docs/Document Library/`
- **Memory System**: Cross-session business learning in `/memories/`
- **PRD**: Product Requirements Document for handing off to technical teams
- **Boundaries**: BOS-AI = Business | AGENT-11 = Technical

### Documentation
- **Getting Started**: [Business Guide](docs/getting-started/business-guide.md) | [Developer Guide](docs/getting-started/developer-guide.md)
- **First Mission**: [Guided Walkthrough](docs/getting-started/first-mission.md)
- **Quick Reference**: [Command Cheat Sheet](docs/reference/quick-reference.md)
- **All Documentation**: [Documentation Index](docs/README.md)

---

## 🛠️ Troubleshooting Guide

### Common Issues and Solutions

**Issue**: Mission fails to start or returns error
**Solution**:
1. Check `/workspace/missions/active/` for active missions (can't run multiple)
2. Verify mission name is correct (case-sensitive)
3. Check if inputs are required: `/missions/[category]/[mission-name].md`
4. Try interactive mode: `/coord` → Select mission from menu

**Issue**: Agent doesn't respond or provides generic answers
**Solution**:
1. Be specific in `/meeting` requests: Include context and constraints
2. Try different agent specialization (e.g., @brand-strategy vs. @campaign-execution)
3. Use `/pmd` for root cause analysis if issue persists

**Issue**: Mission takes longer than estimated
**Solution**:
1. Time estimates are typical - your context may require more customization
2. Check progress: `[mission-name]-progress.md` in `/workspace/missions/active/`
3. Missions can be paused and resumed across sessions

**Issue**: Don't know which agent to use with `/meeting`
**Solution**:
1. Reference Available Agents section for specializations
2. Start with engine-level agents (e.g., @scaling-strategy for growth questions)
3. Use `/coord` instead - it auto-selects correct agents for missions

**Issue**: Confused about BOS-AI vs. AGENT-11
**Solution**:
1. Read `.claude/BOUNDARIES.md` for complete separation details
2. Rule of thumb: BOS-AI creates requirements, AGENT-11 creates code
3. If you need software built, create PRD in BOS-AI and hand off to AGENT-11

**Need More Help?**
Use `/pmd "describe the issue"` for root cause analysis and recommendations.

---

## ❓ Frequently Asked Questions

**Q: How long does it take to see results?**
A: Quick wins in 1-2 weeks (Bible creation missions). Exponential impact in 90 days with full system implementation.

**Q: Do I need technical skills?**
A: No. BOS-AI guides you through business strategy and operations. No coding or technical setup required.

**Q: Can I pause a mission and resume later?**
A: Yes. Missions track progress in `/workspace/missions/active/` and can be resumed across sessions.

**Q: What if I don't have time for 4-5 hour missions?**
A: Start with 90-minute Bible creation missions. Build incrementally rather than all at once.

**Q: How do I choose between similar agents?**
A: Use `/coord` for systematic missions (auto-selects agents). Use `/meeting @agent` for specific consultations.

**Q: What happens to my data and business intelligence?**
A: All stored locally in `/memories/` directory. You own and control all business data and insights.

**Q: Can I customize missions for my specific industry?**
A: Yes. Missions use your context and customize outputs. Provide industry-specific inputs for best results.

**Q: How do I integrate BOS-AI with existing tools (CRM, etc.)?**
A: BOS-AI creates strategic frameworks and documents. Implementation with your tools is guided but not automated.

**Q: When do I use BOS-AI vs. AGENT-11?**
A: Use BOS-AI for all business strategy, marketing, sales, operations. Use AGENT-11 (separate project) for building software products.

**Q: Can BOS-AI write code for me?**
A: No. BOS-AI creates PRDs that define WHAT to build. AGENT-11 (separate project) writes the actual code.

**Q: How do I hand off PRDs to developers?**
A: Create PRD in BOS-AI, then either: (1) Give to your dev team, or (2) Use AGENT-11 project for AI-powered development.

---

## 🎯 Mission Selection Guide

### How to Choose the Right Mission

**Start with Business Chassis Analysis:**
```bash
/coord optimize
```
This identifies your weakest multiplication factor and recommends the highest-impact mission.

**Common Starting Points:**
- **New Business**: Start with `marketing-system-setup` (build customer acquisition)
- **Established Business**: Start with `sales-system-setup` (optimize conversions)
- **Scaling Business**: Start with `customer-service-system-setup` (retain and expand)
- **Mature Business**: Start with `finance-system-setup` (maximize profitability)

**Decision Matrix:**

| Business Stage | Primary Focus | Recommended First Mission |
|----------------|--------------|---------------------------|
| Startup (0-1 year) | Customer acquisition | `marketing-system-setup` |
| Growth (1-3 years) | Conversion optimization | `sales-system-setup` |
| Scale (3-5 years) | Customer retention | `customer-service-system-setup` |
| Mature (5+ years) | Profit optimization | `finance-system-setup` |

**If Unsure**: Run `/coord optimize` → Let Business Chassis analysis guide you.

---

## 📊 Success Milestones

### First 30 Days
✅ Complete at least 1 core system setup (Marketing OR Sales OR Customer Service OR Finance)
✅ Run first `/report` and understand baseline Business Chassis metrics
✅ Execute 1-2 quick-win missions (Bible creation missions)
✅ Establish daily `/coord optimize` habit for identifying opportunities

**Expected Impact**: 10-20% improvement in 1-2 Business Chassis components

### 60 Days
✅ Complete 2-3 core system setups (expanding cross-functional coverage)
✅ First complete customer journey from awareness to advocacy
✅ Active use of Operations Library templates for consistency
✅ Memory system accumulating business intelligence

**Expected Impact**: 30-50% improvement across 3-4 Business Chassis components

### 90 Days
✅ All 4 core systems established (Marketing, Sales, Customer Service, Finance)
✅ Cross-functional integration active (sales-marketing alignment, etc.)
✅ Systematic optimization cycles running (weekly /report review)
✅ Documented processes enabling delegation and scaling

**Expected Impact**: 77%+ profit increase through consistent 10% improvements in all 6 Business Chassis components

---

## 🎖️ Remember the Boundaries

**BOS-AI runs your BUSINESS:**
- Creates strategy, requirements, and PRDs
- Defines WHAT needs to be built and WHY
- Optimizes business operations and metrics
- Manages customer relationships and growth

**AGENT-11 builds your SOFTWARE:**
- Receives PRDs and implements code
- Defines HOW to build it technically
- Handles architecture, testing, deployment
- Optimizes technical performance

**NEVER MIX THESE RESPONSIBILITIES**

This separation keeps your business strategy clean from technical implementation concerns.

---

**Ready to transform your business? Type `/coord` to begin!**

**Need technical product development? Create your PRD here, then set up AGENT-11 project.**

**Questions about boundaries? Read `.claude/BOUNDARIES.md` for complete details.**
