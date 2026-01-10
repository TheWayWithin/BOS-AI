# Developer Guide: Building Products with BOS-AI

> **Complete workflow guide for product developers and technical founders**

This guide walks you through the complete product development lifecycle using BOS-AI for business strategy and AGENT-11 for technical implementation. By following this systematic approach, you'll build products with 60-80% higher long-term success rates and avoid the $55K-200K losses that come from building without proper business validation.

---

## Table of Contents

1. [Introduction: The Two-Project Architecture](#introduction-the-two-project-architecture)
2. [Why Foundation Documents Matter](#why-foundation-documents-matter)
3. [Foundation Document Sequence](#foundation-document-sequence)
4. [Individual Document Deep Dives](#individual-document-deep-dives)
5. [Creating Your PRD](#creating-your-prd)
6. [Setting Up AGENT-11](#setting-up-agent-11)
7. [The Development Cycle](#the-development-cycle)
8. [Operations and Feedback Loop](#operations-and-feedback-loop)
9. [Quick Reference](#quick-reference)
10. [Troubleshooting](#troubleshooting)

---

## Introduction: The Two-Project Architecture

### The Core Principle

**BOS-AI runs your BUSINESS. AGENT-11 builds your SOFTWARE.**

This separation is not arbitrary—it reflects a fundamental truth about successful product development. Business strategy requires different thinking, different skills, and different tools than technical implementation. When you mix them, you get neither done well.

### The Complete Product Lifecycle

```
┌─────────────────────────────────────────────────────────────────┐
│                    STAGE 1: FOUNDATION (BOS-AI)                 │
│                         2-4 weeks                               │
│                                                                 │
│   Vision → Market Research → Positioning → Pricing → Roadmap   │
│                                                                 │
│   Output: Validated business strategy, clear market position    │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STAGE 2: PRD CREATION (BOS-AI)               │
│                         1-2 weeks                               │
│                                                                 │
│   Foundation Documents → Technical Requirements → User Stories  │
│                                                                 │
│   Output: Complete PRD ready for development handoff            │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                 STAGE 3: DEVELOPMENT (AGENT-11)                 │
│                        4-12 weeks                               │
│                                                                 │
│   PRD → Architecture → Implementation → Testing → Deployment   │
│                                                                 │
│   Output: Working software product                              │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                   STAGE 4: OPERATIONS (BOS-AI)                  │
│                        Ongoing                                  │
│                                                                 │
│   Marketing → Sales → Customer Success → Feedback → Iteration  │
│                                                                 │
│   Output: Business growth, customer insights, new PRDs          │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            └──────────────► Return to Stage 2
```

### What Each System Does

| System | Purpose | Creates | Does NOT Create |
|--------|---------|---------|------------------|
| **BOS-AI** | Business strategy & operations | PRDs, market research, positioning, pricing, operational frameworks | Code, architecture, databases, APIs |
| **AGENT-11** | Technical implementation | Software, architecture, tests, deployments | Business strategy, market research, pricing |

### Time Investment Overview

| Stage | Time | Investment | ROI |
|-------|------|------------|-----|
| Foundation | 2-4 weeks | Strategic thinking | 60-80% higher success rate |
| PRD Creation | 1-2 weeks | Requirements clarity | $55K-200K risk mitigation |
| Development | 4-12 weeks | Implementation | Working product |
| Operations | Ongoing | Growth execution | 3x faster scaling |

### Who This Guide Is For

- **Technical founders** building their first product
- **Product developers** transitioning to entrepreneurship
- **Solo builders** who want systematic product development
- **Technical teams** who need better business alignment

---

## Why Foundation Documents Matter

### The $200K Lesson

Most technical founders skip business validation because "I already know what to build." This costs them:

- **$55K-200K** in wasted development on features users don't want
- **6-18 months** building the wrong product
- **Market opportunity** lost to better-validated competitors
- **Burnout** from pivoting without direction

### What Foundation Documents Prevent

| Without Foundation | With Foundation |
|-------------------|------------------|
| Build first, validate later | Validate first, build with confidence |
| Guess at pricing | Data-driven pricing strategy |
| Hope for product-market fit | Systematically achieve fit |
| Reactive pivots | Proactive strategic adjustments |
| Feature creep | Prioritized roadmap |
| Unclear differentiation | Sharp market positioning |

### The Multiplication Effect

Foundation documents don't just prevent mistakes—they multiply your success:

```
Success = (Vision Clarity × Market Understanding × Positioning × Pricing × Roadmap)

10% improvement in each foundation area = 61% better outcomes
20% improvement in each foundation area = 149% better outcomes
```

### Foundation Documents Are REQUIRED Before AGENT-11

**Critical Rule**: Never start AGENT-11 development without completing your foundation documents.

AGENT-11's technical agents (@architect, @developer) expect to receive a PRD that is built on validated business strategy. Without this foundation:

- Architecture decisions lack business context
- Features get prioritized incorrectly
- Technical debt accumulates from scope creep
- Deployment lacks go-to-market alignment

---

## Foundation Document Sequence

### Complete Foundation Sequence Table

BOS-AI provides 18 foundation templates in the Foundation Library. The following sequence ensures each document builds on the previous:

| Order | Document | Command | Time | Depends On | Enables |
|-------|----------|---------|------|------------|----------|
| 1 | **Vision and Mission** | `/coord vision-mission-creation` | 1-2 hrs | None | Everything |
| 2 | **Market Research** | `/coord market-research-creation` | 1-2 hrs | Vision | Positioning, Pricing |
| 3 | **Client Success Blueprint** | `/coord client-blueprint-creation` | 1-2 hrs | Market Research | ICP, Journey |
| 4 | **Positioning Statement** | `/coord positioning-creation` | 1 hr | Market, Client Success | Messaging, Pricing |
| 5 | **Strategic Roadmap** | `/coord roadmap-creation` | 1-2 hrs | Positioning | PRD scope |
| 6 | **Brand Style Guide** | `/coord brand-guide-creation` | 1-2 hrs | Positioning | All marketing |
| 7 | **Pricing Strategy** | `/coord pricing-strategy-creation` | 1-2 hrs | Positioning, Market | Revenue model |
| 8 | **Product Requirements (PRD)** | `/coord prd-creation` | 1-2 hrs | All above | AGENT-11 Handoff |

### Minimum Viable Foundation (Quick Start)

If you need to move quickly, use the foundation quick start:

```bash
/coord foundation-quick-start  # 3-4 hours
```

This creates the essential documents needed for PRD creation.

### Full Foundation (Recommended)

For products with significant investment or competition:

```bash
/coord foundation-system-setup  # 6-8 hours
```

This creates all 8 core documents with comprehensive coverage.

---

## Individual Document Deep Dives

### 1. Vision and Mission Statement

**What It Is**: Your north star document that defines why your product exists, who it serves, and what future you're creating.

**Why It Matters for Development**: Every technical decision should trace back to your vision. When @architect designs your system, they need to understand not just WHAT to build but WHY it matters. Vision provides the context for making trade-offs between features, choosing technology stacks, and deciding what's in scope vs. out of scope.

Without a clear vision, development teams build features that technically work but don't serve the larger purpose. You end up with a collection of functionality instead of a cohesive product.

**Key Elements**:
- Core purpose (why you exist)
- Target customer (who you serve)
- Transformation promise (what changes for customers)
- Long-term vision (3-5 year future state)
- Guiding principles (how you make decisions)

**Command**: `/coord vision-mission-creation`

---

### 2. Market Research Template

**What It Is**: A systematic analysis of your market size, customer segments, competitive landscape, and market trends.

**Why It Matters for Development**: Market research directly impacts your technical architecture. If your research shows you're entering a market with 10,000 potential users, you architect differently than if you're targeting 10 million. Understanding your competitive landscape tells @developer which features are table stakes (must have from day one) vs. differentiators (what makes you special).

Market research also reveals technical requirements you might not have considered. If your target market is in healthcare, compliance requirements shape your entire architecture. If you're targeting enterprise customers, SSO and audit logging become foundational.

**Key Elements**:
- Total Addressable Market (TAM) quantification
- Customer segment profiles with size estimates
- Competitive matrix (features, pricing, positioning)
- Market trends and timing considerations
- Entry barriers and success factors

**Command**: `/coord market-research-creation`

---

### 3. Client Success Blueprint

**What It Is**: A detailed map of how customers discover, evaluate, purchase, onboard, use, and advocate for your product.

**Why It Matters for Development**: The Client Success Blueprint directly shapes your user experience architecture. It tells @designer where users struggle and need hand-holding vs. where they're self-sufficient. It reveals the critical moments that determine whether a user churns or becomes a champion.

For developers, this blueprint defines your analytics requirements, onboarding flows, notification triggers, and success milestones. Without it, you're guessing at what user behavior to track and what interventions to automate.

**Key Elements**:
- Ideal Customer Profile (ICP) with decision criteria
- Customer journey stages with emotions and needs
- Success milestones and leading indicators
- Churn risk factors and prevention strategies
- Expansion triggers and upsell opportunities

**Command**: `/coord client-blueprint-creation`

---

### 4. Positioning Statement Template

**What It Is**: A concise articulation of how your product is different from and better than alternatives for your specific target customer.

**Why It Matters for Development**: Positioning determines feature priority. If you're positioned as "the fastest" solution, performance becomes a technical requirement, not a nice-to-have. If you're positioned as "the simplest," your UI/UX complexity budget is zero—every feature must justify its cognitive load.

Positioning also impacts your technical debt tolerance. A premium-positioned product can't ship with rough edges. A budget-positioned product might accept more technical shortcuts in exchange for speed to market.

**Key Elements**:
- Target customer definition (specific, not broad)
- Problem statement (their language, not yours)
- Product category (what mental bucket do you fit in)
- Key differentiator (one thing that matters most)
- Proof points (why they should believe you)

**Command**: `/coord positioning-creation`

---

### 5. Strategic Roadmap

**What It Is**: A time-bound plan that sequences features and capabilities to achieve business objectives.

**Why It Matters for Development**: The roadmap tells @architect how to plan for technical evolution. Features that are "someday" require extensible architecture. Features that are "next quarter" require specific interface planning.

Without a roadmap, developers make architecture decisions that paint you into corners. They optimize for current requirements without understanding future needs, creating technical debt that slows future development.

**Key Elements**:
- Phase definitions (MVP, Growth, Scale)
- Feature prioritization with business rationale
- Technical milestone sequences
- Resource and dependency mapping
- Success metrics per phase

**Command**: `/coord roadmap-creation`

---

### 6. Brand Style Guide

**What It Is**: Visual and verbal identity standards that ensure consistent brand expression across all touchpoints.

**Why It Matters for Development**: @designer and @developer need this guide to build a consistent product experience. Without brand guidelines, you get a UI that looks like it was built by different teams (because it was—different AI agents, different sessions).

The style guide also impacts your component architecture. Consistent design tokens, color systems, and typography scales should be implemented as reusable components, not ad-hoc styling decisions.

**Key Elements**:
- Logo usage and clear space rules
- Color palette (primary, secondary, semantic)
- Typography system (fonts, sizes, hierarchy)
- Voice and tone guidelines
- Component styling principles

**Command**: `/coord brand-guide-creation`

---

### 7. Pricing Strategy Template

**What It Is**: A comprehensive pricing framework that maximizes value capture while remaining competitive.

**Why It Matters for Development**: Pricing directly impacts your technical architecture:

- **Usage-based pricing** requires metering infrastructure
- **Tiered features** require feature flagging systems
- **Seat-based pricing** requires user management and billing
- **Freemium models** require conversion tracking and upsell triggers

Your pricing strategy also determines your payment processing requirements, subscription management complexity, and revenue analytics needs. Get this wrong, and you're rebuilding billing infrastructure mid-growth.

**Key Elements**:
- Pricing model selection (subscription, usage, hybrid)
- Tier structure with clear differentiation
- Value metrics (what customers pay for)
- Competitive price positioning
- Discount and promotion policies

**Command**: `/coord pricing-strategy-creation`

---

### 8. Product Requirements Document (PRD)

**What It Is**: The comprehensive specification that bridges business strategy and technical implementation.

**Why It Matters for Development**: The PRD is your handoff artifact to AGENT-11. It contains everything the technical team needs to build your product:

- User stories with acceptance criteria
- Technical requirements and constraints
- Integration specifications
- Security and compliance requirements
- Success metrics and monitoring requirements

A well-written PRD enables @architect to make confident design decisions, @developer to implement features correctly the first time, and @tester to validate against clear criteria.

**Key Elements**:
- Product overview and objectives
- User personas and use cases
- Functional requirements (user stories)
- Non-functional requirements (performance, security)
- Integration and API specifications
- Success metrics and analytics requirements

**Command**: `/coord prd-creation`

---

## Creating Your PRD

### Prerequisites Checklist

Before creating your PRD, verify you have:

- [ ] Vision and Mission documented
- [ ] Market Research completed (or at minimum, customer interviews)
- [ ] Client Blueprint defined
- [ ] Positioning Statement defined
- [ ] Strategic Roadmap with MVP scope defined
- [ ] Pricing Strategy outlined (at least initial model)

### The PRD Creation Process

#### Step 1: Initiate PRD Creation

```bash
/coord prd-creation
```

This command initiates the comprehensive PRD creation workflow. BOS-AI will ask whether you want **Auto Mode** (faster, less interaction) or **Engaged Mode** (more questions for better customization).

#### Step 2: Foundation Integration

BOS-AI will reference your existing foundation documents:

```
I found the following foundation documents:
- Vision and Mission: ✅ Complete
- Market Research: ✅ Complete
- Positioning: ✅ Complete
- Pricing Strategy: ⚠️ Draft
- Roadmap: ✅ Complete

I'll incorporate these into your PRD. Let me ask a few clarifying questions...
```

#### Step 3: Answer Clarifying Questions

Expect questions about:
- MVP scope boundaries
- Technical constraints or preferences
- Integration requirements
- Compliance or security needs
- Timeline and resource constraints

#### Step 4: Review and Refine

BOS-AI generates a comprehensive PRD. Review for:
- Completeness of user stories
- Clarity of acceptance criteria
- Technical feasibility
- Alignment with business objectives

### What Makes a Good PRD

| Good PRD | Bad PRD |
|----------|----------|
| Specific acceptance criteria | Vague requirements |
| User stories with rationale | Feature lists without context |
| Clear scope boundaries | "Everything important" |
| Prioritized must-have vs nice-to-have | All features equal priority |
| Success metrics defined | No measurement criteria |
| Technical constraints stated | Assumes unlimited flexibility |

### PRD Output Location

Your PRD will be saved to:
```
documents/foundation/prds/[product-name]-prd.md
```

---

## Setting Up AGENT-11

### Prerequisites

Before setting up AGENT-11:

1. **Complete BOS-AI Foundation** (required)
   - All core foundation documents created
   - PRD finalized and reviewed

2. **Technical Environment**
   - Git installed and configured
   - GitHub account with CLI access
   - Node.js/Python/etc. for your stack
   - Claude Code access

### Step 1: Create Separate Project Directory

**Critical**: AGENT-11 must be a separate project from BOS-AI.

```bash
# Create new directory for your product
mkdir ~/Projects/MyProduct
cd ~/Projects/MyProduct

# Initialize git repository
git init
```

### Step 2: Install AGENT-11

```bash
# Install AGENT-11 framework
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/agent-11/main/install.sh | bash
```

This installs:
- 11 specialized technical agents
- Mission orchestration system
- Development workflows
- CI/CD templates

### Step 3: Copy PRD from BOS-AI

```bash
# Copy your PRD to the AGENT-11 project
cp ~/Projects/MyBusiness-BOS/documents/foundation/prds/my-product-prd.md \
   ~/Projects/MyProduct/ideation.md
```

### Step 4: Initialize Development

In your AGENT-11 project, start development:

```bash
claude code .

# Initialize from your PRD
/coord dev-setup ideation.md

# Or for existing codebases
/coord dev-alignment
```

### AGENT-11 Agent Reference

| Agent | Role | Use For |
|-------|------|----------|
| @coordinator | Orchestration | Complex multi-agent workflows |
| @architect | System design | Architecture decisions, technical planning |
| @developer | Implementation | Feature development, bug fixes |
| @tester | Quality assurance | Test creation, validation |
| @designer | UX/UI | Interface design, user experience |
| @documenter | Documentation | Technical docs, API reference |
| @operator | DevOps | Deployment, CI/CD, infrastructure |
| @strategist | Requirements | Feature planning, prioritization |
| @analyst | Data | Analytics, metrics, insights |
| @marketer | Technical marketing | Developer docs, launch content |
| @support | Customer success | Support systems, help docs |

### AGENT-11 Development Commands

```bash
# Start full development mission
/coord dev-setup ideation.md

# Autonomous execution until blocked
/coord continue

# Fix bugs
/coord fix bug-description

# Deploy
@operator deploy [environment]
```

---

## The Development Cycle

### Typical Development Flow

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│   Architecture   │────▶│  Implementation  │────▶│     Testing      │
│   @architect     │     │   @developer     │     │    @tester       │
└──────────────────┘     └──────────────────┘     └──────────────────┘
         │                        │                        │
         ▼                        ▼                        ▼
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│  Architecture.md │     │   Feature Code   │     │   Test Results   │
│  Tech Decisions  │     │   API Endpoints  │     │   Bug Reports    │
└──────────────────┘     └──────────────────┘     └──────────────────┘
```

### Phase 1: Architecture (Days 1-3)

```bash
# Architect reviews PRD
@architect analyze ideation.md

# Creates architecture document
# Output: architecture.md with:
#   - System design
#   - Technology stack
#   - Database schema
#   - API structure
#   - Security approach
```

### Phase 2: Implementation (Weeks 1-8)

```bash
# Developer implements features in priority order
@developer implement user-authentication
@developer implement core-feature-1
@developer implement core-feature-2

# Each implementation includes:
#   - Feature code
#   - Unit tests
#   - Documentation updates
#   - Integration tests
```

### Phase 3: Testing (Continuous)

```bash
# Tester validates against PRD acceptance criteria
@tester validate user-authentication
@tester run-integration-tests

# Testing outputs:
#   - Test coverage reports
#   - Bug reports with reproduction steps
#   - Performance benchmarks
```

### Phase 4: Deployment (Week 8+)

```bash
# Operator sets up infrastructure
@operator setup-infrastructure
@operator configure-ci-cd
@operator deploy staging
@operator deploy production
```

---

## Operations and Feedback Loop

### Returning to BOS-AI

Once AGENT-11 delivers working software, return to BOS-AI for operations:

```bash
# In your BOS-AI project
cd ~/Projects/MyBusiness-BOS

# Launch go-to-market
/coord product-launch "MyProduct"

# Set up marketing
/coord marketing-system-setup

# Enable sales
/coord sales-system-setup
```

### The Feedback Loop

```
┌─────────────────────────────────────────────────────────────────┐
│                     OPERATIONS (BOS-AI)                         │
│                                                                 │
│   Marketing ──▶ Leads ──▶ Sales ──▶ Customers ──▶ Support      │
│       │                                              │          │
│       └──────────────────────────────────────────────┘          │
│                           │                                     │
│                           ▼                                     │
│                    Customer Feedback                            │
│                    Usage Analytics                              │
│                    Market Changes                               │
│                           │                                     │
│                           ▼                                     │
│              ┌─────────────────────────┐                       │
│              │   New PRD Creation      │                       │
│              │   /coord prd-creation   │                       │
│              └─────────────────────────┘                       │
│                           │                                     │
└───────────────────────────┼─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                   DEVELOPMENT (AGENT-11)                        │
│                                                                 │
│              New features, improvements, fixes                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Creating Enhancement PRDs

When feedback indicates needed improvements:

```bash
# Create focused enhancement PRD
/coord prd-creation

# Example: PRD for dashboard improvements based on customer feedback
```

### Iteration Cadence

| Feedback Type | Response Time | PRD Creation |
|--------------|---------------|---------------|
| Critical bug | Hours | Bug fix PRD immediately |
| User friction | Days | Improvement PRD in sprint |
| Feature request | Weeks | Enhancement PRD in backlog |
| Market shift | Months | Strategic PRD in roadmap |

---

## Quick Reference

### Essential Commands Summary

#### BOS-AI (Business Strategy)

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/coord foundation-quick-start` | Quick foundation | Start of project |
| `/coord foundation-system-setup` | Complete foundation | Thorough planning |
| `/coord prd-creation` | Create PRD | After foundation complete |
| `/coord marketing-system-setup` | Marketing framework | After product launch |
| `/coord sales-system-setup` | Sales framework | After product launch |
| `/meeting @agent "topic"` | Expert consultation | Any time for deep dives |

#### AGENT-11 (Technical Development)

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/coord dev-setup ideation.md` | Initialize project | Start of development |
| `/coord continue` | Autonomous execution | Ongoing development |
| `@architect analyze [prd]` | Architecture design | Start of development |
| `@developer implement [feature]` | Build features | During development |
| `@tester validate [component]` | Quality assurance | After implementation |
| `@operator deploy [env]` | Deployment | Release time |

### Decision Tree: Which System to Use

```
Start
  │
  ├─── Need to understand market/customers?
  │         │
  │         └─── YES ──▶ BOS-AI: /coord market-research-creation
  │
  ├─── Need to define business strategy?
  │         │
  │         └─── YES ──▶ BOS-AI: /coord [foundation-mission]
  │
  ├─── Need to create/update PRD?
  │         │
  │         └─── YES ──▶ BOS-AI: /coord prd-creation
  │
  ├─── Need to write code or build features?
  │         │
  │         └─── YES ──▶ AGENT-11: @developer implement
  │
  ├─── Need to deploy or operate infrastructure?
  │         │
  │         └─── YES ──▶ AGENT-11: @operator
  │
  ├─── Need to market or sell the product?
  │         │
  │         └─── YES ──▶ BOS-AI: /coord marketing-system-setup
  │
  └─── Unclear?
            │
            └─── Is it about WHAT to build? ──▶ BOS-AI
            └─── Is it about HOW to build? ──▶ AGENT-11
```

### Workflow Checklist

**Before Development**:
- [ ] Vision and Mission documented
- [ ] Market research completed
- [ ] Client Blueprint defined
- [ ] Positioning defined
- [ ] Pricing strategy outlined
- [ ] Roadmap created
- [ ] PRD finalized
- [ ] AGENT-11 project initialized
- [ ] PRD copied to AGENT-11 project

**During Development**:
- [ ] Architecture documented
- [ ] Features implemented per PRD priority
- [ ] Tests validate acceptance criteria
- [ ] Documentation updated
- [ ] Performance benchmarks met

**After Development**:
- [ ] Product deployed
- [ ] Marketing systems activated
- [ ] Sales systems activated
- [ ] Customer feedback collection enabled
- [ ] Analytics tracking operational
- [ ] Feedback loop established

---

## Troubleshooting

### Common Issues and Solutions

#### Issue: PRD feels incomplete or vague

**Cause**: Foundation documents not thorough enough.

**Solution**:
1. Return to BOS-AI
2. Complete missing foundation documents
3. Use `/meeting @solution-design "clarify [specific area]"` for deep dives
4. Regenerate PRD with better foundation

#### Issue: AGENT-11 architect asks questions PRD should answer

**Cause**: PRD missing technical requirements.

**Solution**:
1. Note the questions
2. Return to BOS-AI
3. Update PRD with technical requirements
4. Re-copy updated PRD to AGENT-11 project

#### Issue: Development scope keeps growing

**Cause**: PRD scope boundaries not clear or not enforced.

**Solution**:
1. Review PRD "Out of Scope" section
2. If new features are truly needed, create enhancement PRD in BOS-AI
3. Maintain strict phase boundaries
4. Use roadmap to schedule future features

#### Issue: Product launches but customers don't convert

**Cause**: Market research or positioning may be off.

**Solution**:
1. Return to BOS-AI
2. Run `/coord optimize` to analyze Business Chassis
3. Interview actual customers/prospects
4. Update positioning and marketing
5. Consider product iteration with new PRD

#### Issue: Unsure whether to use BOS-AI or AGENT-11

**Rule of Thumb**:
- **WHAT** to build = BOS-AI
- **HOW** to build = AGENT-11
- **WHY** to build = BOS-AI
- Building/coding = AGENT-11
- Strategy/requirements = BOS-AI

---

## Summary

The BOS-AI to AGENT-11 workflow represents a fundamental shift in how products are built:

1. **Foundation First**: Validate business strategy before writing code
2. **Clear Handoffs**: PRD bridges business and technical teams
3. **Separate Concerns**: Business strategy in BOS-AI, implementation in AGENT-11
4. **Continuous Cycle**: Operations feedback drives product evolution

By following this systematic approach:

- **60-80% higher success rates** through validated business strategy
- **$55K-200K risk mitigation** by catching mistakes before code
- **3x faster growth** through aligned execution
- **Sustainable iteration** with clear feedback loops

**Ready to start? Begin with your foundation documents:**

```bash
/coord foundation-quick-start
```

---

## See Also

### Getting Started
- [First Mission Guide](first-mission.md) - Hands-on walkthrough of your first BOS-AI session
- [Business Guide](business-guide.md) - For pure business operations (no development)
- [Quick Reference](../reference/quick-reference.md) - Command cheat sheet

### Concepts
- [Business Chassis](../concepts/business-chassis.md) - Understanding the profit multiplication formula
- [Lifecycle](../concepts/lifecycle.md) - Deep dive into BOS-AI + AGENT-11 workflow

### Reference
- [Directory Structure](../reference/directory-structure.md) - Project file organization
- [FAQ](../troubleshooting/faq.md) - Common questions answered
- [Installation Troubleshooting](../troubleshooting/installation.md) - Solving setup issues

---

[Back to README](../../README.md) | [Business Guide](business-guide.md) | [First Mission](first-mission.md)
