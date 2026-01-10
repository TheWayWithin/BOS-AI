# PRD Creation SOP

**Standard Operating Procedure for Product Requirements Document Creation**

| Metadata | Value |
|----------|-------|
| **Version** | 2.1 |
| **Last Updated** | 2026-01-10 |
| **Template Version** | PRD v3.1 |
| **Replaces** | PRD Creation SOP v1.0 |
| **Owner** | BOS-AI Product Operations |
| **Status** | Active |

---

## Executive Summary

This SOP provides comprehensive guidance for creating Product Requirements Documents using the PRD v3.1 template. It supports both **Engaged Mode** (collaborative walkthrough) and **Auto Mode** (one-shot generation), with new capabilities for incremental updates and post-creation validation.

### What's New in v2.1

| Enhancement | Description |
|-------------|-------------|
| **Structure-First Approach** | System Skeleton before Features ensures technical coherence |
| **Auto Mode Improvements** | Complete PRD generation with explicit assumption tracking |
| **Incremental Updates** | `--update-skeleton` and `--update-features` commands |
| **Handoff Validation** | Mandatory checklist before AGENT-11 handoff |
| **Solopreneur Defaults** | Standard assumptions for unanswered questions |
| **Blocking vs Non-Blocking** | Clear classification of open questions |

---

## Table of Contents

1. [Overview and Prerequisites](#1-overview-and-prerequisites)
2. [Mode Selection Guide](#2-mode-selection-guide)
3. [Phase 0: Initiation](#3-phase-0-initiation)
4. [Phase 1: Product Foundation](#4-phase-1-product-foundation)
5. [Phase 2: System Skeleton](#5-phase-2-system-skeleton)
6. [Phase 3: Feature Specification](#6-phase-3-feature-specification)
7. [Phase 4: Testing and Validation](#7-phase-4-testing-and-validation)
8. [Phase 5: Launch Planning](#8-phase-5-launch-planning)
9. [Phase 6: Handoff Readiness](#9-phase-6-handoff-readiness)
10. [Incremental Update Commands](#10-incremental-update-commands)
11. [Solopreneur Defaults Reference](#11-solopreneur-defaults-reference)
12. [Troubleshooting and FAQ](#12-troubleshooting-and-faq)

---

## 1. Overview and Prerequisites

### 1.1 Purpose

This SOP guides the creation of comprehensive, developer-ready PRDs that:
- Define clear product vision and business objectives
- Specify complete system architecture before features
- Provide testable acceptance criteria for all features
- Enable seamless handoff to technical implementation teams

### 1.2 Scope

This SOP applies to:
- New product development
- Major feature additions
- Product pivots or significant redesigns
- MVP definitions for new ventures

### 1.3 Prerequisites

Before starting PRD creation, ensure you have:

| Prerequisite | Required | Recommended |
|--------------|----------|-------------|
| Product vision or concept | ✅ | - |
| Target audience understanding | ✅ | - |
| Business model hypothesis | ✅ | - |
| Competitive analysis | - | ✅ |
| User research/interviews | - | ✅ |
| Technical constraints identified | - | ✅ |
| Budget/timeline constraints | - | ✅ |

### 1.4 Time Estimates

| Mode | Total Time | Best For |
|------|------------|----------|
| **Engaged Mode** | 3-4 hours | First-time PRD creators, complex products, uncertain requirements |
| **Auto Mode** | 30-60 minutes | Experienced users, clear vision, time-constrained situations |
| **Incremental Update** | 15-30 minutes | Refinements, scope changes, adding features |

### 1.5 Output Files

| File | Purpose | Location |
|------|---------|----------|
| `[Product]-PRD-v1.0.md` | Main PRD document | `/workspace/prds/` |
| `[Product]-preference-profile.json` | Machine-readable defaults | `/workspace/prds/` |
| `[Product]-handoff-checklist.md` | Validation record | `/workspace/prds/` |

---

## 2. Mode Selection Guide

### 2.1 Mode Comparison

| Aspect | Engaged Mode | Auto Mode |
|--------|--------------|------------|
| **Interaction** | Collaborative Q&A | One-shot generation |
| **Control** | High - approve each section | Low - review after generation |
| **Speed** | 3-4 hours | 30-60 minutes |
| **Assumption Handling** | Asked explicitly | Applied from Solopreneur Defaults |
| **Best For** | Complex products, first-time users | Clear vision, experienced users |
| **Review Required** | Section-by-section | Full document review |

### 2.2 Engaged Mode Workflow

```
┌─────────────────────────────────────────────────────────────┐
│                     ENGAGED MODE FLOW                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐               │
│  │ Question │───▶│  Answer  │───▶│ Generate │               │
│  │  Asked   │    │ Provided │    │ Section  │               │
│  └──────────┘    └──────────┘    └────┬─────┘               │
│                                       │                      │
│                                       ▼                      │
│                               ┌──────────┐                   │
│                               │  Review  │                   │
│                               │ & Approve│                   │
│                               └────┬─────┘                   │
│                                    │                         │
│                          ┌─────────┴─────────┐               │
│                          ▼                   ▼               │
│                    ┌──────────┐        ┌──────────┐          │
│                    │ Approved │        │ Revise   │          │
│                    │ Continue │        │ Section  │          │
│                    └──────────┘        └──────────┘          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.3 Auto Mode Workflow

```
┌─────────────────────────────────────────────────────────────┐
│                      AUTO MODE FLOW                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐    ┌──────────────┐    ┌──────────────┐       │
│  │  Input   │───▶│   Generate   │───▶│   Complete   │       │
│  │ Context  │    │  Full PRD    │    │     PRD      │       │
│  └──────────┘    └──────────────┘    └──────┬───────┘       │
│                                              │               │
│                                              ▼               │
│                                      ┌──────────────┐        │
│                                      │    Output    │        │
│                                      │  Documents:  │        │
│                                      │  • PRD       │        │
│                                      │  • Assumptions│       │
│                                      │  • Open Qs   │        │
│                                      └──────┬───────┘        │
│                                              │               │
│                                              ▼               │
│                                      ┌──────────────┐        │
│                                      │    Manual    │        │
│                                      │    Review    │        │
│                                      └──────────────┘        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.4 Mode Selection Command

```bash
# Start PRD creation with mode selection
/coord prd-creation

# Response prompts:
> Select mode: [Engaged/Auto]
> Product name or description: [Your input]
> Existing context files (optional): [File paths]
```

---

## 3. Phase 0: Initiation

**Duration:** 10-15 minutes | **Output:** PRD At-a-Glance section

### 3.1 Purpose

Phase 0 creates the PRD At-a-Glance summary that serves as the executive overview and quick reference for all stakeholders.

### 3.2 Discovery Questions

| Question | Purpose | If Unanswered |
|----------|---------|---------------|
| What problem does this product solve? | Core value proposition | Apply Solopreneur Default: Focus on time/money saving |
| Who is the primary user? | Target audience | Apply Solopreneur Default: Solo operator or small team |
| What is the MVP scope? | Initial boundaries | Apply Solopreneur Default: 3-5 core features |
| What is the target launch timeline? | Planning constraints | Apply Solopreneur Default: 4-6 weeks |
| What is the business model? | Revenue strategy | Apply Solopreneur Default: SaaS or one-time purchase |

### 3.3 At-a-Glance Template

```markdown
## Section 0: PRD At-a-Glance

| Attribute | Value |
|-----------|-------|
| **Product Name** | [Name] |
| **Version** | 1.0 |
| **Status** | Draft / Review / Approved |
| **Owner** | [Name] |
| **Target Launch** | [Date or Sprint] |
| **Template Version** | PRD v3.1 |

### One-Line Summary
[Product] helps [target user] to [achieve outcome] by [key mechanism].

### Success Metrics (Top 3)
1. [Metric 1]: [Target]
2. [Metric 2]: [Target]
3. [Metric 3]: [Target]

### Scope Boundaries
- **In Scope:** [Core capabilities]
- **Out of Scope:** [Explicit exclusions]
- **Future Consideration:** [Post-MVP items]
```

### 3.4 Completion Criteria

- [ ] Product name and version defined
- [ ] One-line summary captures value proposition
- [ ] Top 3 success metrics identified with targets
- [ ] Scope boundaries clearly stated
- [ ] Target launch date established

---

## 4. Phase 1: Product Foundation

**Duration:** 45-60 minutes | **Output:** PRD Section 1

### 4.1 Purpose

Phase 1 establishes the strategic foundation including vision, market positioning, and business objectives that guide all subsequent decisions.

### 4.2 Section 1.1: Product Vision

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What is your long-term vision for this product? | Strategic direction | "Become the go-to solution for [problem] in [niche]" |
| What makes this product unique? | Differentiation | Focus on simplicity and time-to-value |
| What future does this product enable? | Aspirational goal | "Users save X hours/week" or "Users increase revenue by Y%" |

#### Vision Statement Template

```markdown
### 1.1 Product Vision

**Vision Statement:**
[Product] will become [market position] by [unique approach], enabling [target users] to [transform from current state] to [desired future state].

**Core Value Proposition:**
- **Primary Benefit:** [Main value delivered]
- **Key Differentiator:** [What sets it apart]
- **Emotional Outcome:** [How users feel after using it]
```

### 4.3 Section 1.2: Problem Statement

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What specific problem does this solve? | Problem clarity | Time-consuming manual process |
| How are users solving this problem today? | Current alternatives | Spreadsheets, manual tracking, or nothing |
| What is the cost of not solving this? | Urgency factor | Lost time, missed opportunities, errors |
| How widespread is this problem? | Market size indicator | Affects majority of target segment |

#### Problem Statement Template

```markdown
### 1.2 Problem Statement

**The Problem:**
[Target users] struggle with [specific problem] because [root cause]. Currently, they [workaround/current solution] which results in [negative outcomes].

**Impact Analysis:**
| Impact Area | Current State | Cost |
|-------------|---------------|------|
| Time | [Hours wasted] | [$/hour lost] |
| Money | [Revenue lost] | [$] |
| Quality | [Errors/issues] | [Impact] |
| Opportunity | [Missed chances] | [Value] |

**Evidence:**
- [User interview insight or data point 1]
- [User interview insight or data point 2]
- [Market research finding]
```

### 4.4 Section 1.3: Target Audience

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| Who is the primary user? | Core persona | Solo business owner or small team lead |
| Who else will use this product? | Secondary personas | Team members, clients (if applicable) |
| What is their technical sophistication? | UX complexity | Non-technical, prefers simple interfaces |
| What tools do they currently use? | Integration needs | Common SMB tools (Stripe, Google, etc.) |

#### Target Audience Template

```markdown
### 1.3 Target Audience

#### Primary Persona: [Name]

| Attribute | Description |
|-----------|-------------|
| **Role** | [Job title/function] |
| **Business Size** | [Solo/SMB/Enterprise] |
| **Technical Level** | [Non-technical/Technical/Power User] |
| **Key Goal** | [What they want to achieve] |
| **Primary Frustration** | [Main pain point] |
| **Success Definition** | [How they measure success] |

**Day in the Life:**
[Brief narrative of how they encounter the problem and how the product fits into their workflow]

#### Secondary Personas (if applicable)
- **[Persona 2]:** [Brief description and relationship to primary]
- **[Persona 3]:** [Brief description and relationship to primary]
```

### 4.5 Section 1.4: Business Objectives

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What is the revenue model? | Monetization | SaaS subscription with monthly/annual options |
| What are the target pricing tiers? | Pricing strategy | Free trial → Starter → Pro (3 tiers max) |
| What are the key business metrics? | Success measurement | MRR, CAC, LTV, Churn, NPS |
| What is the growth strategy? | Acquisition | Product-led growth with content marketing |

#### Business Objectives Template

```markdown
### 1.4 Business Objectives

#### Revenue Model
- **Type:** [SaaS/One-time/Usage-based/Freemium]
- **Pricing Strategy:** [Value-based/Competitive/Penetration]

#### Pricing Tiers
| Tier | Price | Target User | Key Features |
|------|-------|-------------|---------------|
| Free/Trial | $0 | Evaluators | [Limited features] |
| Starter | $X/mo | Individual users | [Core features] |
| Pro | $Y/mo | Power users/teams | [All features + extras] |

#### Business Metrics
| Metric | Target (6 months) | Target (12 months) |
|--------|-------------------|-------------------|
| MRR | $X | $Y |
| Active Users | X | Y |
| Churn Rate | <X% | <Y% |
| NPS | >X | >Y |

#### Growth Strategy
- **Acquisition:** [Primary channels]
- **Activation:** [Key activation milestone]
- **Retention:** [Retention strategy]
- **Referral:** [Viral/referral mechanisms]
```

### 4.6 Section 1.5: Success Metrics

```markdown
### 1.5 Success Metrics

#### North Star Metric
**[Metric Name]:** [Description] - Target: [Value] by [Date]

#### Key Results
| Objective | Key Result | Target | Measurement |
|-----------|------------|--------|-------------|
| [Obj 1] | [KR 1.1] | [Target] | [How measured] |
| [Obj 1] | [KR 1.2] | [Target] | [How measured] |
| [Obj 2] | [KR 2.1] | [Target] | [How measured] |

#### Leading Indicators
- [Indicator 1]: Predicts [outcome]
- [Indicator 2]: Predicts [outcome]

#### Lagging Indicators
- [Indicator 1]: Confirms [outcome]
- [Indicator 2]: Confirms [outcome]
```

### 4.7 Phase 1 Completion Criteria

- [ ] Vision statement articulates long-term direction
- [ ] Problem statement includes evidence/data
- [ ] Primary persona fully defined
- [ ] Business model and pricing specified
- [ ] Success metrics have specific targets
- [ ] All questions answered or flagged as Open Questions

---

## 5. Phase 2: System Skeleton

**Duration:** 60-90 minutes | **Output:** PRD Section 2

### 5.1 Purpose

Phase 2 defines the technical foundation BEFORE features are specified. This "skeleton-first" approach ensures:
- All features share consistent data models
- UI patterns are established upfront
- Business rules are centralized
- Integration points are identified early
- Compliance requirements shape the architecture

> **CRITICAL:** Never skip to features before completing the System Skeleton. This prevents orphan data, inconsistent UX, and technical debt.

### 5.2 Section 2.1: Data Model

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What are the core entities in your system? | Data architecture | User, [Primary Object], Settings |
| How do entities relate to each other? | Relationships | One-to-many for owned objects |
| What data must be stored for each entity? | Field definition | Essential fields only for MVP |
| Are there multi-tenancy requirements? | Isolation | Single-tenant or row-level security |

#### Data Model Template

```markdown
### 2.1 Data Model

#### Entity Definitions

##### E-001: User
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | Yes | Primary key |
| email | String | Yes | Unique, login identifier |
| name | String | Yes | Display name |
| created_at | Timestamp | Yes | Account creation |
| [field] | [type] | [req] | [desc] |

##### E-002: [Primary Entity]
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | Yes | Primary key |
| user_id | UUID (FK) | Yes | Owner reference |
| [field] | [type] | [req] | [desc] |

#### Entity Relationships

```
┌─────────┐       1:N       ┌─────────────┐
│  User   │────────────────▶│ [Entity 2]  │
└─────────┘                 └─────────────┘
     │                            │
     │ 1:N                        │ 1:N
     ▼                            ▼
┌─────────┐                 ┌─────────────┐
│[Entity 3]│                │ [Entity 4]  │
└─────────┘                 └─────────────┘
```

#### Relationship Matrix
| From | To | Type | Description |
|------|-----|------|-------------|
| User | [Entity] | 1:N | User owns multiple [entities] |
| [Entity] | [Entity] | N:N | [Description] |
```

### 5.3 Section 2.2: UI Sitemap

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What are the main sections of the app? | Navigation structure | Dashboard, [Core Feature], Settings |
| What is the primary user flow? | Critical path | Onboard → Create → Use → Measure |
| Are there role-based views? | Access control | Single role for MVP |
| Mobile-first or desktop-first? | Responsive priority | Mobile-first responsive |

#### UI Sitemap Template

```markdown
### 2.2 UI Sitemap

#### Page Hierarchy

```
[Product Name]
├── Public Pages
│   ├── Landing Page
│   ├── Pricing
│   └── Login/Register
│
├── Authenticated App
│   ├── Dashboard (default)
│   │   ├── Overview widgets
│   │   └── Quick actions
│   │
│   ├── [Core Feature Area]
│   │   ├── List view
│   │   ├── Detail view
│   │   ├── Create/Edit modal
│   │   └── [Sub-feature]
│   │
│   ├── Settings
│   │   ├── Profile
│   │   ├── Preferences
│   │   ├── Billing
│   │   └── Integrations
│   │
│   └── Help/Support
│
└── Admin (if applicable)
    ├── User management
    └── System settings
```

#### Navigation Patterns
| Pattern | Implementation | Notes |
|---------|----------------|-------|
| Primary Nav | [Sidebar/Top bar/Bottom tabs] | [Behavior] |
| Secondary Nav | [Tabs/Breadcrumbs] | [Context] |
| Actions | [FAB/Button bar/Contextual] | [Placement] |
```

### 5.4 Section 2.3: Business Rules

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What limits or constraints exist? | Rate limiting, quotas | Generous limits for MVP |
| What calculations are performed? | Business logic | Simple formulas, avoid complexity |
| What workflows have multiple steps? | State machines | Linear workflows preferred |
| What notifications are triggered? | Automation | Email for critical events only |

#### Business Rules Template

```markdown
### 2.3 Business Rules

#### BR-001: [Rule Name]
- **Trigger:** [When this rule applies]
- **Condition:** [IF statement]
- **Action:** [THEN statement]
- **Exception:** [UNLESS statement]
- **Affected Entities:** [E-XXX, E-YYY]

#### BR-002: [Rule Name]
- **Trigger:** [When this rule applies]
- **Condition:** [IF statement]
- **Action:** [THEN statement]
- **Exception:** [UNLESS statement]
- **Affected Entities:** [E-XXX]

#### Calculation Rules
| ID | Name | Formula | Entities |
|----|------|---------|----------|
| CALC-001 | [Name] | [Formula] | [E-XXX] |
| CALC-002 | [Name] | [Formula] | [E-YYY] |

#### State Machines
##### [Object] States
```
[Draft] ──create──▶ [Active] ──archive──▶ [Archived]
                        │
                        └──delete──▶ [Deleted]
```
```

### 5.5 Section 2.4: External Integrations

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What third-party services are needed? | Dependencies | Stripe, Auth provider, Email |
| What data flows in/out? | Data exchange | Minimal data, privacy-focused |
| Are there webhook requirements? | Event-driven | Stripe webhooks for payments |
| What APIs need to be exposed? | Platform strategy | None for MVP unless core to value |

#### External Integrations Template

```markdown
### 2.4 External Integrations

#### Third-Party Services
| Service | Purpose | Priority | Data Exchanged |
|---------|---------|----------|----------------|
| [Auth Provider] | Authentication | P0 | User identity |
| Stripe | Payments | P0 | Payment data |
| [Email Service] | Transactional email | P0 | Email content |
| [Analytics] | Usage tracking | P1 | Events |

#### API Contracts
##### Outbound (We Call)
| Service | Endpoint | Method | Purpose |
|---------|----------|--------|----------|
| Stripe | /customers | POST | Create customer |
| Stripe | /subscriptions | POST | Create subscription |

##### Inbound (Webhooks We Receive)
| Source | Event | Handler | Action |
|--------|-------|---------|--------|
| Stripe | payment_intent.succeeded | /webhooks/stripe | Update subscription status |
| Stripe | customer.subscription.deleted | /webhooks/stripe | Handle cancellation |

##### Exposed APIs (Others Call Us)
| Endpoint | Method | Purpose | Auth |
|----------|--------|---------|------|
| /api/v1/[resource] | GET | [Purpose] | API Key |
```

### 5.6 Section 2.5: Compliance & Security

#### Discovery Questions

| Question | Purpose | Solopreneur Default |
|----------|---------|---------------------|
| What regulations apply? | Compliance scope | GDPR if EU users, CCPA if CA users |
| What data is sensitive? | Protection requirements | PII, payment data |
| What authentication is needed? | Access control | Email/password + OAuth options |
| What audit requirements exist? | Logging needs | Basic activity logging |

#### Compliance Template

```markdown
### 2.5 Compliance & Security

#### Regulatory Requirements
| Regulation | Applicability | Key Requirements |
|------------|---------------|------------------|
| GDPR | [Yes/No/TBD] | Data export, deletion, consent |
| CCPA | [Yes/No/TBD] | Privacy policy, opt-out |
| SOC 2 | [Yes/No/TBD] | Security controls |
| [Industry-specific] | [Yes/No/TBD] | [Requirements] |

#### Data Classification
| Data Type | Classification | Handling Requirements |
|-----------|----------------|----------------------|
| User PII | Sensitive | Encrypted at rest, access logged |
| Payment data | Highly Sensitive | PCI DSS compliance, never stored raw |
| Usage data | Internal | Anonymized for analytics |

#### Security Controls
| Control | Implementation | Status |
|---------|----------------|--------|
| Authentication | [Method] | [Required/MVP/Post-MVP] |
| Authorization | [RBAC/ABAC/Simple] | [Required/MVP/Post-MVP] |
| Encryption at rest | [Method] | [Required/MVP/Post-MVP] |
| Encryption in transit | TLS 1.3 | Required |
| Audit logging | [Scope] | [Required/MVP/Post-MVP] |
```

### 5.7 Phase 2 Completion Criteria

- [ ] All core entities defined with fields
- [ ] Entity relationships documented with ERD
- [ ] UI sitemap shows all pages and navigation
- [ ] Business rules catalogued with IDs
- [ ] Third-party integrations listed with data flows
- [ ] Compliance requirements identified
- [ ] Security controls specified
- [ ] No orphan entities (all referenced by features or other entities)

---

## 6. Phase 3: Feature Specification

**Duration:** 60-90 minutes | **Output:** PRD Section 3

### 6.1 Purpose

Phase 3 specifies features that build upon the System Skeleton. Each feature must:
- Reference entities from the Data Model
- Fit within the UI Sitemap
- Respect Business Rules
- Consider Integration requirements
- Address Compliance needs

### 6.2 Feature Prioritization Framework

#### Priority Definitions

| Priority | Definition | MVP Inclusion | Acceptance Criteria |
|----------|------------|---------------|---------------------|
| **P0** | Must have for launch | Yes | Complete GWT required |
| **P1** | Should have, launch blocker if easy | If time permits | Complete GWT required |
| **P2** | Nice to have | No | Summary AC acceptable |
| **P3** | Future consideration | No | Description only |

#### Prioritization Questions

| Question | Purpose |
|----------|----------|
| Can users get core value without this? | P0 vs P1 |
| What percentage of users need this? | Breadth impact |
| How complex is implementation? | Effort estimation |
| Does this enable other features? | Dependency mapping |

### 6.3 Feature Specification Template

```markdown
### 3.X Features

#### F-XXX: [Feature Name]

| Attribute | Value |
|-----------|-------|
| **Priority** | P0/P1/P2/P3 |
| **Complexity** | S/M/L/XL |
| **Dependencies** | F-YYY, F-ZZZ (if any) |
| **Touched Entities** | E-001, E-002 |
| **UI Location** | [Page from sitemap] |
| **Business Rules** | BR-001, BR-002 |

**Description:**
[2-3 sentence description of what the feature does and why it matters]

**User Story:**
As a [persona], I want to [action] so that [benefit].

**Acceptance Criteria (GWT Format):**

```gherkin
Scenario: [Primary happy path]
  Given [initial context]
  When [action taken]
  Then [expected outcome]
  And [additional outcome]

Scenario: [Error case]
  Given [initial context]
  When [invalid action taken]
  Then [error handling]

Scenario: [Edge case]
  Given [unusual context]
  When [action taken]
  Then [expected behavior]
```

**UI/UX Notes:**
- [Interaction pattern]
- [Visual requirements]
- [Responsive behavior]

**Technical Notes:**
- [Implementation consideration]
- [Performance requirement]
- [Security consideration]
```

### 6.4 GWT (Given-When-Then) Best Practices

#### Structure Rules

| Element | Purpose | Example |
|---------|---------|----------|
| **Given** | Preconditions, initial state | Given a user is logged in and has 3 projects |
| **When** | Action or trigger | When the user clicks "Create Project" |
| **Then** | Expected outcome, assertions | Then a new project form appears |
| **And** | Additional conditions/outcomes | And the form has focus on the name field |

#### Coverage Requirements for P0 Features

| Scenario Type | Required | Example |
|---------------|----------|----------|
| Happy path | Yes | User successfully completes action |
| Validation error | Yes | User submits invalid data |
| Empty state | Yes | User has no data yet |
| Permission denied | If applicable | User lacks access |
| Edge cases | 2-3 minimum | Unusual but valid inputs |

#### Common Mistakes to Avoid

| Mistake | Problem | Better Approach |
|---------|---------|------------------|
| "User can do X" | Not testable | Use GWT format with specific outcomes |
| Too vague outcomes | Can't verify | Specify exact UI changes or data states |
| Missing error cases | Incomplete spec | Include validation and error scenarios |
| No entity references | Disconnected | Reference E-XXX entities touched |

### 6.5 Feature Grouping Structure

```markdown
## Section 3: Features

### 3.1 Core Features (P0)
[Features required for MVP launch]

#### F-001: [Feature Name]
...

#### F-002: [Feature Name]
...

### 3.2 Enhanced Features (P1)
[Features that significantly improve value if included]

#### F-010: [Feature Name]
...

### 3.3 Future Features (P2/P3)
[Features for post-MVP roadmap]

#### F-020: [Feature Name]
...
```

### 6.6 Phase 3 Completion Criteria

- [ ] All P0 features have complete GWT acceptance criteria
- [ ] All features reference touched entities (E-XXX)
- [ ] All features map to UI sitemap locations
- [ ] All features reference applicable business rules (BR-XXX)
- [ ] Dependencies between features documented
- [ ] Feature IDs (F-XXX) assigned consistently
- [ ] Complexity estimates provided for all features

---

## 7. Phase 4: Testing and Validation

**Duration:** 30-45 minutes | **Output:** PRD Section 4

### 7.1 Purpose

Phase 4 defines the testing strategy that maps directly to features. Every test case references the feature it validates.

### 7.2 Test Strategy Framework

```markdown
## Section 4: Testing Strategy

### 4.1 Test Coverage Matrix

| Feature ID | Feature Name | Unit Tests | Integration Tests | E2E Tests |
|------------|--------------|------------|-------------------|------------|
| F-001 | [Name] | T-001, T-002 | T-010 | T-050 |
| F-002 | [Name] | T-003 | T-011 | T-051 |

### 4.2 Test Case Specifications

#### T-001: [Test Name]
- **Type:** Unit/Integration/E2E
- **Feature:** F-XXX
- **Scenario:** [From GWT acceptance criteria]
- **Preconditions:** [Setup required]
- **Steps:**
  1. [Step 1]
  2. [Step 2]
- **Expected Result:** [Outcome]
- **Priority:** Critical/High/Medium/Low
```

### 7.3 Test Type Guidelines

| Test Type | Scope | Who Writes | When Run |
|-----------|-------|------------|----------|
| Unit | Individual functions | Developer | Every commit |
| Integration | API endpoints | Developer | Every PR |
| E2E | User flows | QA/Developer | Pre-release |
| Performance | Load/speed | Developer | Weekly/Pre-release |
| Security | Vulnerabilities | Security | Pre-release |

### 7.4 Minimum Test Requirements

| Priority | Unit Coverage | Integration | E2E |
|----------|---------------|-------------|-----|
| P0 Features | 80%+ | All endpoints | Critical paths |
| P1 Features | 70%+ | All endpoints | Happy paths |
| P2 Features | 50%+ | Main endpoints | None required |

### 7.5 Phase 4 Completion Criteria

- [ ] Test coverage matrix complete
- [ ] All P0 features have mapped test cases
- [ ] Test IDs (T-XXX) link to Feature IDs (F-XXX)
- [ ] Critical path E2E tests defined
- [ ] Performance benchmarks specified
- [ ] Security test requirements documented

---

## 8. Phase 5: Launch Planning

**Duration:** 20-30 minutes | **Output:** PRD Sections 5 & 6

### 8.1 Purpose

Phase 5 defines the launch strategy, rollout plan, and risk mitigation.

### 8.2 Section 5: Technical Considerations

```markdown
## Section 5: Technical Considerations

### 5.1 Architecture Overview
[High-level architecture description - detailed design handled by AGENT-11]

### 5.2 Technology Preferences
| Layer | Preference | Rationale |
|-------|------------|------------|
| Frontend | [React/Vue/etc] | [Why] |
| Backend | [Node/Python/etc] | [Why] |
| Database | [Postgres/etc] | [Why] |
| Hosting | [Vercel/Railway/etc] | [Why] |

### 5.3 Performance Requirements
| Metric | Target | Critical Threshold |
|--------|--------|-------------------|
| Page Load | <2s | <4s |
| API Response | <200ms | <500ms |
| Uptime | 99.5% | 99% |

### 5.4 Scalability Considerations
- **Initial Load:** [Expected users/month]
- **Growth Target:** [Users in 12 months]
- **Scaling Strategy:** [Horizontal/Vertical/Serverless]
```

### 8.3 Section 6: Launch Strategy

```markdown
## Section 6: Launch Strategy

### 6.1 Release Phases

| Phase | Timeline | Scope | Success Criteria |
|-------|----------|-------|------------------|
| Alpha | [Date] | Internal testing | All P0 features working |
| Beta | [Date] | Limited users | <X critical bugs |
| GA | [Date] | Public launch | Metrics targets met |

### 6.2 Rollout Plan

#### Phase 1: Alpha ([Date Range])
- **Participants:** [Who]
- **Focus:** [What to validate]
- **Exit Criteria:** [How to know when ready]

#### Phase 2: Beta ([Date Range])
- **Participants:** [Who, how many]
- **Feedback Mechanism:** [How collected]
- **Exit Criteria:** [What qualifies for GA]

#### Phase 3: General Availability ([Date])
- **Announcement:** [Channels]
- **Support Readiness:** [Resources]
- **Monitoring:** [What to watch]

### 6.3 Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | H/M/L | H/M/L | [Strategy] |
| [Risk 2] | H/M/L | H/M/L | [Strategy] |

### 6.4 Rollback Plan
- **Trigger:** [When to rollback]
- **Process:** [How to rollback]
- **Communication:** [Who to notify]
```

### 8.4 Phase 5 Completion Criteria

- [ ] Technology preferences documented
- [ ] Performance requirements specified
- [ ] Release phases defined with dates
- [ ] Rollout plan details for each phase
- [ ] Risk assessment complete with mitigations
- [ ] Rollback plan documented

---

## 9. Phase 6: Handoff Readiness

**Duration:** 15-20 minutes | **Output:** PRD Section 7 + Checklist

### 9.1 Purpose

Phase 6 validates the PRD is complete and ready for handoff to AGENT-11 for technical implementation. This is a MANDATORY step before any development begins.

### 9.2 Handoff Readiness Checklist

```markdown
## Section 7: Handoff Readiness Checklist

### 7.1 Document Completeness

#### Section 0: At-a-Glance
- [ ] Product name and version defined
- [ ] One-line summary captures value proposition
- [ ] Top 3 success metrics with targets
- [ ] Scope boundaries clearly stated

#### Section 1: Product Foundation
- [ ] Vision statement articulates direction
- [ ] Problem statement has evidence
- [ ] Primary persona fully defined
- [ ] Business model specified
- [ ] Success metrics have targets

#### Section 2: System Skeleton
- [ ] All entities defined with fields
- [ ] Entity relationships documented (ERD)
- [ ] UI sitemap complete
- [ ] Business rules catalogued
- [ ] Integrations listed with data flows
- [ ] Compliance requirements identified

#### Section 3: Features
- [ ] All P0 features have GWT acceptance criteria
- [ ] Features reference touched entities (E-XXX)
- [ ] Features map to UI sitemap locations
- [ ] Dependencies documented
- [ ] Complexity estimates provided

#### Section 4: Testing
- [ ] Test coverage matrix complete
- [ ] Tests linked to features (T-XXX → F-XXX)
- [ ] Critical path E2E tests defined

#### Section 5: Technical
- [ ] Technology preferences documented
- [ ] Performance requirements specified
- [ ] Scalability considerations noted

#### Section 6: Launch
- [ ] Release phases defined
- [ ] Rollout plan documented
- [ ] Risks assessed with mitigations

### 7.2 Open Questions Status

#### Blocking Questions (Must resolve before development)
- [ ] [OQ-001]: [Question] → [Status: Resolved/Pending]
- [ ] [OQ-002]: [Question] → [Status: Resolved/Pending]

**BLOCKING COUNT: X** (Must be 0 for handoff)

#### Non-Blocking Questions (Can resolve during development)
- [OQ-010]: [Question] → [Owner: Name] [Due: Date]
- [OQ-011]: [Question] → [Owner: Name] [Due: Date]

### 7.3 Assumptions Log

| ID | Assumption | Applied Default | Risk if Wrong |
|----|------------|-----------------|---------------|
| A-001 | [Assumption] | [From Solopreneur Defaults] | [Impact] |
| A-002 | [Assumption] | [From Solopreneur Defaults] | [Impact] |

### 7.4 Handoff Approval

| Check | Status | Notes |
|-------|--------|-------|
| Zero blocking questions | ☐ Pass / ☐ Fail | |
| All P0 GWT complete | ☐ Pass / ☐ Fail | |
| Entity relationships valid | ☐ Pass / ☐ Fail | |
| Preference Profile generated | ☐ Pass / ☐ Fail | |

**HANDOFF STATUS:** ☐ Ready / ☐ Not Ready

**Sign-off:** _________________ Date: _________
```

### 9.3 Preference Profile Generation

The PRD creation process generates a machine-readable preference profile:

```json
{
  "product": {
    "name": "[Product Name]",
    "version": "1.0",
    "prd_version": "3.1"
  },
  "tech_preferences": {
    "frontend": "[Framework]",
    "backend": "[Framework]",
    "database": "[Database]",
    "hosting": "[Platform]"
  },
  "business_model": {
    "type": "[SaaS/One-time/etc]",
    "pricing_tiers": ["Free", "Starter", "Pro"]
  },
  "defaults_applied": [
    "[Solopreneur Default 1]",
    "[Solopreneur Default 2]"
  ],
  "open_questions": {
    "blocking": [],
    "non_blocking": ["[Question 1]", "[Question 2]"]
  }
}
```

### 9.4 Handoff Failure Resolution

If handoff check fails:

| Failure Type | Resolution |
|--------------|------------|
| Blocking questions remain | Return to relevant phase, gather answers |
| Missing GWT for P0 | Return to Phase 3, complete acceptance criteria |
| Entity relationships unclear | Return to Phase 2, update data model |
| Preference profile incomplete | Run profile generation command |

### 9.5 Phase 6 Completion Criteria

- [ ] Handoff checklist completed with all items checked
- [ ] Zero blocking open questions
- [ ] All P0 features have testable GWT criteria
- [ ] Preference profile JSON generated
- [ ] Sign-off recorded

---

## 10. Incremental Update Commands

### 10.1 Overview

After initial PRD creation, use incremental update commands to modify specific sections without regenerating the entire document.

### 10.2 Available Commands

| Command | Purpose | Scope |
|---------|---------|-------|
| `/coord prd-creation` | Full PRD creation | New PRD from scratch |
| `/coord prd-creation --update-skeleton` | Update Section 2 | Regenerate System Skeleton |
| `/coord prd-creation --update-features` | Update Section 3 | Regenerate Features |
| `/coord prd-creation --update-testing` | Update Section 4 | Regenerate Testing |
| `/coord prd-creation --add-feature` | Add single feature | Append to Section 3 |

### 10.3 Update Behavior Rules

#### Golden Rule: Never Overwrite User Edits

When running update commands:
1. Agent reads current PRD
2. Agent identifies user-modified sections (marked with `<!-- USER-EDITED -->`)
3. Agent proposes changes as **diffs** or **new subsections**
4. User approves before changes applied

#### Example Update Flow

```
User: /coord prd-creation --update-skeleton

Agent: I've analyzed the current PRD. Here are proposed changes:

**Data Model Updates:**
- ADD Entity E-005: Notification
  [Entity definition]

- MODIFY E-002: Project
  - ADD field: notification_preferences (JSON)

**Business Rules Updates:**
- ADD BR-010: Notification Throttling
  [Rule definition]

Apply these changes? [Yes/No/Modify]
```

### 10.4 --update-skeleton Details

**When to Use:**
- Adding new entities discovered during development
- Updating integrations based on technical decisions
- Revising compliance requirements
- Modifying UI structure

**What Gets Updated:**
- Section 2.1: Data Model
- Section 2.2: UI Sitemap
- Section 2.3: Business Rules
- Section 2.4: External Integrations
- Section 2.5: Compliance & Security

**What Gets Preserved:**
- User-added comments
- Manual field descriptions
- Custom business rules

### 10.5 --update-features Details

**When to Use:**
- Adding features from user feedback
- Reprioritizing based on market signals
- Breaking down large features into smaller ones
- Adding acceptance criteria detail

**What Gets Updated:**
- Section 3: Features (all subsections)
- Test coverage matrix (Section 4.1)

**What Gets Preserved:**
- User-edited GWT scenarios
- Manual priority overrides
- Custom technical notes

### 10.6 --add-feature Details

**When to Use:**
- Single feature addition without full regeneration
- Quick scope expansion
- Post-launch feature planning

**Command Usage:**
```bash
/coord prd-creation --add-feature "[Feature description]"
```

**Agent Behavior:**
1. Analyze feature description
2. Identify touched entities from existing Data Model
3. Map to UI sitemap location
4. Generate F-XXX ID (next available)
5. Create complete feature specification with GWT
6. Add test cases (T-XXX)
7. Propose insertion location in Section 3

---

## 11. Solopreneur Defaults Reference

### 11.1 Overview

Solopreneur Defaults are sensible assumptions applied when discovery questions go unanswered. They optimize for solo founders or small teams building MVPs.

### 11.2 Complete Defaults Table

#### Business Model Defaults

| Question | Default Answer | Rationale |
|----------|----------------|------------|
| Revenue model | SaaS subscription | Recurring revenue preferred |
| Pricing structure | 3 tiers (Free/Starter/Pro) | Simple, covers market segments |
| Free tier | Yes, limited features | Reduces friction, enables growth |
| Payment processor | Stripe | Most common, best developer experience |
| Billing cycle | Monthly + Annual (20% discount) | Standard SaaS pattern |

#### Technical Defaults

| Question | Default Answer | Rationale |
|----------|----------------|------------|
| Frontend framework | React + Next.js | Widely supported, great DX |
| Backend framework | Node.js/TypeScript | Shared language with frontend |
| Database | PostgreSQL (via Supabase) | Reliable, scalable, integrated auth |
| Hosting | Vercel (frontend) + Railway (backend) | Fast deployment, good free tiers |
| Authentication | Supabase Auth | Integrated with database, OAuth included |

#### User Experience Defaults

| Question | Default Answer | Rationale |
|----------|----------------|------------|
| Target user tech level | Non-technical | Broader market appeal |
| Mobile support | Mobile-responsive, not mobile-first | Most B2B users on desktop |
| Onboarding | Guided walkthrough | Reduces time-to-value |
| Help/Support | In-app help + email | Scalable for solo founder |
| Notifications | Email for critical only | Avoid notification fatigue |

#### Feature Defaults

| Question | Default Answer | Rationale |
|----------|----------------|------------|
| MVP feature count | 3-5 core features | Focus over breadth |
| Admin panel | No (MVP) | User self-service preferred |
| Team/collaboration | No (MVP) | Single-user first |
| API access | No (MVP) | Unless core to value prop |
| Export/import | CSV export only | Minimum viable data portability |

#### Timeline Defaults

| Question | Default Answer | Rationale |
|----------|----------------|------------|
| MVP timeline | 4-6 weeks | Aggressive but realistic |
| Beta duration | 2-4 weeks | Enough for feedback, not too long |
| Time to first revenue | 8-12 weeks | Account for marketing ramp |

#### Compliance Defaults

| Question | Default Answer | Rationale |
|----------|----------------|------------|
| GDPR compliance | Yes if EU users | Required by law |
| CCPA compliance | Yes if CA users | Required by law |
| Data retention | 90 days after account deletion | Reasonable balance |
| Cookie consent | Basic cookie banner | Minimum compliance |

### 11.3 Override Protocol

To override a Solopreneur Default:

1. Explicitly answer the discovery question during PRD creation
2. Or add to Preference Profile after generation
3. Document override in Assumptions Log with rationale

```markdown
### Assumption Override
| Default | Override | Rationale |
|---------|----------|------------|
| React + Next.js | Vue + Nuxt | Team expertise in Vue |
| No team features | Basic team support | B2B requirement |
```

---

## 12. Troubleshooting and FAQ

### 12.1 Common Issues

#### Issue: PRD generation stalls or times out

**Symptoms:**
- Agent stops responding mid-generation
- Incomplete sections in output

**Solutions:**
1. Use Engaged Mode for complex products
2. Break into multiple sessions using incremental updates
3. Reduce scope by starting with P0 features only

#### Issue: Missing entity references in features

**Symptoms:**
- Features don't reference E-XXX entities
- "Touched Entities" field is empty or generic

**Solutions:**
1. Run `--update-skeleton` to regenerate data model
2. Run `--update-features` to regenerate with entity linkage
3. Manually review Section 2.1 and add entity references

#### Issue: GWT acceptance criteria are too vague

**Symptoms:**
- "Then the action succeeds" without specifics
- Missing error cases or edge cases

**Solutions:**
1. Use Engaged Mode for P0 features
2. Request specific scenario expansion: "Expand GWT for F-001 with error cases"
3. Reference example GWT in Section 6.4 of this SOP

#### Issue: Handoff checklist has multiple failures

**Symptoms:**
- Multiple checklist items fail
- Blocking questions remain unresolved

**Solutions:**
1. Prioritize blocking questions first
2. Use `/meeting @solution-design "resolve PRD gaps"` for focused discussion
3. Consider reducing scope by moving P1 features to P2

### 12.2 FAQ

**Q: When should I use Engaged vs. Auto mode?**

A: Use **Engaged Mode** when:
- Creating your first PRD
- Product has complex requirements
- You're uncertain about scope or features
- Stakeholder alignment is needed

Use **Auto Mode** when:
- You have clear product vision documented
- Time is limited
- Creating PRD for straightforward product
- Iterating on existing PRD

---

**Q: How do I handle disagreement with Solopreneur Defaults?**

A: Override any default by:
1. Answering the discovery question explicitly
2. Documenting the override in Assumptions Log
3. Providing rationale for the change

Defaults are starting points, not requirements.

---

**Q: Can I skip the System Skeleton (Phase 2)?**

A: **No.** The skeleton-first approach is mandatory in PRD v3.1. Skipping it causes:
- Features with undefined entities
- Inconsistent data models
- Orphan data in implementation
- Technical debt from missing relationships

---

**Q: How detailed should GWT acceptance criteria be?**

A: For P0 features:
- Include happy path, error cases, and 2-3 edge cases
- Specify exact UI elements and states
- Include data validation rules
- Reference entity fields by name

For P1 features:
- Happy path and one error case
- General UI behavior

For P2/P3:
- Summary description is sufficient

---

**Q: What if I need to add features after handoff?**

A: Use the `--add-feature` command:
```bash
/coord prd-creation --add-feature "[Feature description]"
```

This generates a complete feature spec that integrates with existing PRD structure.

---

**Q: How do I handle a major pivot?**

A: For major pivots:
1. Create new PRD using full `/coord prd-creation`
2. Reference original PRD as "Previous Version"
3. Document what's changing and why in Section 1
4. Carry forward valid entities and business rules

---

**Q: Can multiple people work on the same PRD?**

A: Yes, using the update commands:
1. Store PRD in version control (Git)
2. Each contributor uses `--update-*` commands
3. Merge changes through normal Git workflow
4. Run handoff checklist after merges

---

**Q: How long is a PRD valid before needing updates?**

A: Review PRD when:
- Market conditions change significantly
- User feedback contradicts assumptions
- Technology choices change
- Scope increases by >20%
- 3+ months since creation without implementation

---

## Appendix A: Quick Reference Card

### Commands

| Command | Purpose |
|---------|----------|
| `/coord prd-creation` | Start new PRD (mode selection) |
| `/coord prd-creation --update-skeleton` | Update Section 2 |
| `/coord prd-creation --update-features` | Update Section 3 |
| `/coord prd-creation --add-feature "[desc]"` | Add single feature |

### Phase Summary

| Phase | Duration | Output |
|-------|----------|--------|
| 0: Initiation | 10-15 min | At-a-Glance |
| 1: Foundation | 45-60 min | Section 1 |
| 2: Skeleton | 60-90 min | Section 2 |
| 3: Features | 60-90 min | Section 3 |
| 4: Testing | 30-45 min | Section 4 |
| 5: Launch | 20-30 min | Sections 5-6 |
| 6: Handoff | 15-20 min | Section 7 |

### Handoff Criteria

- [ ] Zero blocking open questions
- [ ] All P0 features have complete GWT
- [ ] All entities have defined relationships
- [ ] Preference profile generated

---

## Appendix B: Template Cross-Reference

| This SOP Section | PRD Template v3.1 Section |
|------------------|---------------------------|
| Phase 0: Initiation | Section 0: PRD At-a-Glance |
| Phase 1: Foundation | Section 1: Product Foundation |
| Phase 2: Skeleton | Section 2: System Skeleton |
| Phase 3: Features | Section 3: Features |
| Phase 4: Testing | Section 4: Testing Strategy |
| Phase 5: Launch | Sections 5 & 6: Technical + Launch |
| Phase 6: Handoff | Section 7: Handoff Readiness |

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|----------|
| 1.0 | 2024-XX-XX | BOS-AI | Initial release |
| 2.0 | 2025-XX-XX | BOS-AI | Aligned with PRD v3.0, added skeleton-first |
| 2.1 | 2026-01-10 | BOS-AI | Auto mode improvements, incremental updates, handoff validation, Solopreneur Defaults |

---

**Related Documents:**
- [PRD Template](/docs/Document Library/Foundation/Product Requirements Document (PRD).md)
- [Solopreneur Defaults Profile](/docs/Document Library/Foundation/Solopreneur-Defaults.json)
- [BOS-AI CLAUDE.md](/CLAUDE.md)

---

*This SOP is maintained by BOS-AI Product Operations. For updates or feedback, use `/meeting @solution-design "PRD SOP feedback"`.*
