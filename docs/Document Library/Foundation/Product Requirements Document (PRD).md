# Product Requirements Document (PRD)

**Template Version:** 3.1
**Last Updated:** 2026-01-10
**BOS-AI Compatible:** Yes
**AGENT-11 Ready:** Yes

---

## Template Overview

This PRD template bridges the gap between strategic product vision (BOS-AI) and technical implementation (AGENT-11). The **System Skeleton** approach provides the architectural foundation that enables AI agents to implement features without ambiguity.

### What's New in v3.1

| Enhancement | Purpose | Agent Benefit |
|-------------|---------|---------------|
| Section 0: PRD At-a-Glance | Executive summary for quick orientation | Immediate context loading |
| Section 2: System Skeleton | Conceptual architecture pre-handoff | Eliminates implementation guesswork |
| Feature IDs (F-001) | Traceable feature references | Test-to-feature mapping |
| GWT Test Format | Given-When-Then acceptance criteria | Automated test generation |
| Handoff Readiness Checklist | Validation gate pre-handoff | Prevents incomplete handoffs |
| Blocking/Non-Blocking Tags | Prioritized open questions | Clear decision dependencies |

### How to Use This Template

1. **Start with Section 0** - Complete the At-a-Glance table first
2. **Define the System Skeleton** - This is the critical bridge section
3. **Enumerate Features** - Use F-001 format with entity references
4. **Write GWT Tests** - Link to feature IDs for traceability
5. **Complete Handoff Checklist** - Validate before AGENT-11 handoff

---

# [PRODUCT NAME] - Product Requirements Document

**Document Owner:** [Name]
**Status:** Draft | In Review | Approved | Handed Off
**Created:** [Date]
**Last Modified:** [Date]
**Version:** [1.0]

---

## Section 0: PRD At-a-Glance

> **Purpose:** Executive summary enabling quick orientation. Complete this table FIRST before expanding other sections.

| Dimension | Content |
|-----------|--------|
| **Product Sentence** | [One sentence describing what this product does and for whom] |
| **Primary User** | [Target user persona or role] |
| **Core Problem** | [The #1 problem being solved] |
| **MVP Scope** | [3-5 bullet points of what's IN scope] |
| **Explicit Non-Goals** | [3-5 bullet points of what's OUT of scope for this version] |
| **Key Constraints** | [Technical, timeline, budget, regulatory constraints] |
| **Success Metric** | [Single most important metric to track] |
| **Target Launch** | [Date or milestone] |
| **Handoff Date** | [When this PRD transfers to AGENT-11] |

### Open Questions Summary

> Tag each question as `[BLOCKING]` (must resolve before handoff) or `[NON-BLOCKING]` (can resolve during development).

| ID | Question | Owner | Tag | Due Date | Resolution |
|----|----------|-------|-----|----------|------------|
| Q-001 | [Question text] | [Name] | [BLOCKING] | [Date] | [Pending/Resolved: answer] |
| Q-002 | [Question text] | [Name] | [NON-BLOCKING] | [Date] | [Pending/Resolved: answer] |

---

## Section 1: Product Overview

### 1.1 Vision Statement

[2-3 sentences describing the long-term vision for this product and its place in the market]

### 1.2 Problem Statement

#### Current State
[Describe the current situation, pain points, and inefficiencies]

#### Desired Future State
[Describe what success looks like after this product is implemented]

#### Gap Analysis
| Current Pain Point | Impact | Proposed Solution |
|-------------------|--------|------------------|
| [Pain point 1] | [Business/user impact] | [How product addresses it] |
| [Pain point 2] | [Business/user impact] | [How product addresses it] |

### 1.3 Target Users

#### Primary Persona
| Attribute | Description |
|-----------|-------------|
| **Name** | [Persona name, e.g., "Growth-Stage Founder"] |
| **Role** | [Job title/responsibility] |
| **Goals** | [What they're trying to achieve] |
| **Frustrations** | [Current pain points] |
| **Tech Savvy** | [Low / Medium / High] |
| **Usage Context** | [When/where they'll use this] |

#### Secondary Personas
[Brief descriptions of other user types, if applicable]

### 1.4 Business Context

#### Business Chassis Impact
> How does this product multiply business performance?

| Multiplier | Current | Target | Impact |
|------------|---------|--------|--------|
| Prospects | [X] | [Y] | [% improvement] |
| Lead Conversion | [X%] | [Y%] | [% improvement] |
| Client Conversion | [X%] | [Y%] | [% improvement] |
| Average Spend | [$X] | [$Y] | [% improvement] |
| Transaction Frequency | [X/period] | [Y/period] | [% improvement] |
| Margin | [X%] | [Y%] | [% improvement] |

#### Revenue Model
[How this product generates or enables revenue]

---

## Section 2: System Skeleton

> **Purpose:** This section provides the conceptual architecture that bridges business requirements and technical implementation. AGENT-11 agents use this to understand the system before writing code.

### 2.1 Glossary

> **CRITICAL:** Define all domain-specific terms before they appear in the document. Consistent terminology prevents implementation ambiguity.

| Term | Definition | Example | Related Terms |
|------|------------|---------|---------------|
| [Term 1] | [Clear, unambiguous definition] | [Concrete example] | [Related terms] |
| [Term 2] | [Clear, unambiguous definition] | [Concrete example] | [Related terms] |
| [Term 3] | [Clear, unambiguous definition] | [Concrete example] | [Related terms] |

### 2.2 Conceptual Data Model

> **Purpose:** Define entities, their attributes, relationships, and lifecycles. This is NOT a database schema - it's a business-level data model that guides technical design.

#### Entity Overview

```
[Entity Relationship Diagram - Text Format]

┌─────────────┐       1:N       ┌─────────────┐
│    User     │────────────────>│   Project   │
└─────────────┘                 └─────────────┘
       │                              │
       │ 1:1                          │ 1:N
       ▼                              ▼
┌─────────────┐                 ┌─────────────┐
│   Profile   │                 │    Task     │
└─────────────┘                 └─────────────┘
```

#### Entity Definitions

| Entity | Description | Key Attributes | Relationships | Lifecycle States |
|--------|-------------|----------------|---------------|------------------|
| [Entity 1] | [What this entity represents] | [Core attributes] | [Related entities + cardinality] | [States: created→active→archived] |
| [Entity 2] | [What this entity represents] | [Core attributes] | [Related entities + cardinality] | [States: draft→published→deleted] |

#### Entity Detail: [Entity Name]

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID | Yes | Unique, immutable | Primary identifier |
| [attribute] | [type] | [Yes/No] | [validation rules] | [purpose] |
| created_at | Timestamp | Yes | Auto-generated | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-updated | Last modification |

*(Repeat for each major entity)*

### 2.3 UI Structure (Sitemap)

> **Purpose:** Define the navigation structure, access levels, and primary actions for each view.

#### Route Map

| Route | View Name | Access Level | Key Data Displayed | Primary Actions | Parent Route |
|-------|-----------|--------------|-------------------|-----------------|--------------|
| `/` | Home/Dashboard | Authenticated | [Summary data] | [Main CTAs] | - |
| `/login` | Login | Public | - | Sign in, Register | - |
| `/projects` | Project List | Authenticated | [Project summaries] | Create, Filter, Search | `/` |
| `/projects/:id` | Project Detail | Owner, Member | [Project data] | Edit, Delete, Add Task | `/projects` |
| `/settings` | Settings | Authenticated | [User preferences] | Update, Save | `/` |

#### Navigation Structure

```
├── Public Routes
│   ├── /login
│   ├── /register
│   └── /forgot-password
│
├── Authenticated Routes
│   ├── / (Dashboard)
│   ├── /projects
│   │   ├── /projects/new
│   │   └── /projects/:id
│   │       ├── /projects/:id/edit
│   │       └── /projects/:id/tasks
│   └── /settings
│       ├── /settings/profile
│       └── /settings/billing
│
└── Admin Routes
    ├── /admin
    └── /admin/users
```

### 2.4 Business Rules & State Machines

> **Purpose:** Define explicit business logic rules and state transitions. These become validation logic and workflow code.

#### Business Rules

| Rule ID | Entity | Rule Description | Trigger | Action | Error Handling |
|---------|--------|-----------------|---------|--------|----------------|
| BR-001 | User | Email must be unique across system | Registration, Email update | Validate uniqueness | "Email already in use" |
| BR-002 | Project | Only owner can delete project | Delete action | Check ownership | "Unauthorized" (403) |
| BR-003 | Task | Due date cannot be in past | Task creation/update | Validate date | "Due date must be future" |

#### State Machines

##### [Entity] State Machine

```
                    ┌─────────────────────────────────────┐
                    │                                     │
                    ▼                                     │
┌────────┐    ┌────────────┐    ┌────────────┐    ┌──────┴─────┐
│ DRAFT  │───>│   ACTIVE   │───>│  COMPLETE  │───>│  ARCHIVED  │
└────────┘    └────────────┘    └────────────┘    └────────────┘
    │              │                  │
    │              │                  │
    ▼              ▼                  ▼
┌────────┐    ┌────────────┐    ┌────────────┐
│ DELETED│    │  ON_HOLD   │    │  DELETED   │
└────────┘    └────────────┘    └────────────┘
```

| From State | To State | Trigger | Conditions | Side Effects |
|------------|----------|---------|------------|--------------|
| DRAFT | ACTIVE | User clicks "Publish" | All required fields filled | Send notification |
| ACTIVE | COMPLETE | All tasks done | Task count > 0 | Update metrics |
| ACTIVE | ON_HOLD | User clicks "Pause" | - | Pause notifications |
| * | DELETED | User clicks "Delete" | Owner permission | Soft delete, retain 30 days |

### 2.5 External API Dependencies

> **Purpose:** Document all external services, their constraints, and data flows. Critical for architecture planning and error handling.

| Service | Purpose | Endpoint Base | Auth Method | Rate Limits | Data In | Data Out | Fallback |
|---------|---------|---------------|-------------|-------------|---------|----------|----------|
| [Service 1] | [What it provides] | [URL] | [API Key/OAuth/etc] | [X req/min] | [What we send] | [What we receive] | [Graceful degradation] |
| [Service 2] | [What it provides] | [URL] | [API Key/OAuth/etc] | [X req/min] | [What we send] | [What we receive] | [Graceful degradation] |

#### API Dependency Details

##### [Service Name]

| Attribute | Value |
|-----------|-------|
| **Provider** | [Company name] |
| **Documentation** | [URL] |
| **SLA** | [Uptime guarantee] |
| **Pricing Tier** | [Plan name, cost] |
| **Data Freshness** | [Real-time / Cached / Daily update] |
| **Retry Strategy** | [Exponential backoff, max retries] |
| **Circuit Breaker** | [When to fail-open] |

### 2.6 Data Privacy & Compliance

> **Purpose:** Define data handling requirements for regulatory compliance. Essential for GDPR, HIPAA, SOC2, etc.

#### Data Classification

| Data Category | Entities/Fields | Classification | Encryption | Retention | Access Control |
|---------------|-----------------|----------------|------------|-----------|----------------|
| PII | User: email, name, phone | Confidential | At-rest + Transit | Account lifetime + 30 days | Owner, Admin |
| Financial | Billing: card_token, invoices | Restricted | At-rest + Transit | 7 years (tax) | Owner, Billing Admin |
| Usage | Analytics: page_views, clicks | Internal | Transit | 2 years | Analytics team |
| Public | Project: title, description | Public | Transit | Indefinite | Anyone |

#### Compliance Checklist

| Requirement | Regulation | Status | Implementation Notes |
|-------------|------------|--------|---------------------|
| Right to Access | GDPR Art. 15 | [ ] Required | User data export feature |
| Right to Erasure | GDPR Art. 17 | [ ] Required | Account deletion workflow |
| Data Portability | GDPR Art. 20 | [ ] Required | JSON/CSV export |
| Consent Management | GDPR Art. 7 | [ ] Required | Cookie consent, ToS acceptance |
| Breach Notification | GDPR Art. 33 | [ ] Required | 72-hour notification process |
| Encryption at Rest | SOC2 CC6.1 | [ ] Required | AES-256 for sensitive data |
| Audit Logging | SOC2 CC7.2 | [ ] Required | All data access logged |
| Access Reviews | SOC2 CC6.2 | [ ] Required | Quarterly permission audits |

---

## Section 3: Features & Requirements

> **Purpose:** Detailed feature specifications with traceability to entities, test cases, and acceptance criteria.

### 3.1 Feature Summary

| Feature ID | Feature Name | Type | Priority | Touched Entities | Est. Effort | Dependencies |
|------------|--------------|------|----------|------------------|-------------|--------------|
| F-001 | [Feature name] | [Type] | [P0/P1/P2/P3] | [Entity list] | [S/M/L/XL] | [F-XXX list] |
| F-002 | [Feature name] | [Type] | [P0/P1/P2/P3] | [Entity list] | [S/M/L/XL] | [F-XXX list] |

**Feature Types:**
- `CRUD` - Create/Read/Update/Delete operations
- `AUTH` - Authentication/Authorization
- `INTEGRATION` - External service integration
- `ANALYTICS` - Reporting/Dashboards/Metrics
- `WORKFLOW` - Multi-step processes
- `NOTIFICATION` - Alerts/Emails/Push
- `SEARCH` - Search/Filter/Sort
- `IMPORT/EXPORT` - Data migration

**Priority Definitions:**
- `P0` - Critical for launch (MVP blocker)
- `P1` - Important for launch (strong preference)
- `P2` - Nice to have at launch (if time permits)
- `P3` - Post-launch enhancement

### 3.2 Feature Details

---

#### F-001: [Feature Name]

| Attribute | Value |
|-----------|-------|
| **Type** | [CRUD / AUTH / INTEGRATION / etc.] |
| **Priority** | [P0 / P1 / P2 / P3] |
| **Touched Entities** | [Entity1, Entity2] |
| **Dependencies** | [F-XXX, External Service] |
| **Estimated Effort** | [S: <1 day / M: 1-3 days / L: 3-5 days / XL: 5+ days] |

**Description:**
[Detailed description of what this feature does and why it's needed]

**User Story:**
> As a [user type], I want to [action] so that [benefit].

**Acceptance Criteria (GWT Format):**

| AC ID | Given | When | Then |
|-------|-------|------|------|
| AC-001-01 | [Precondition/context] | [Action taken] | [Expected outcome] |
| AC-001-02 | [Precondition/context] | [Action taken] | [Expected outcome] |
| AC-001-03 | [Precondition/context] | [Action taken] | [Expected outcome] |

**UI/UX Requirements:**
- [Specific UI behavior or design requirement]
- [Responsive behavior]
- [Accessibility requirement]

**Technical Notes:**
- [Implementation hints or constraints]
- [Performance requirements]
- [Security considerations]

**Out of Scope:**
- [What this feature explicitly does NOT include]

---

#### F-002: [Feature Name]

*(Repeat structure for each feature)*

---

### 3.3 MVP Feature Set

> **Definition:** The minimum set of features required for initial launch.

| Feature ID | Feature Name | Rationale for MVP Inclusion |
|------------|--------------|----------------------------|
| F-001 | [Name] | [Why this is essential] |
| F-002 | [Name] | [Why this is essential] |
| F-003 | [Name] | [Why this is essential] |

### 3.4 Post-MVP Roadmap

| Phase | Feature ID | Feature Name | Target Timeline |
|-------|------------|--------------|-----------------|
| V1.1 | F-004 | [Name] | [+2 weeks post-launch] |
| V1.2 | F-005 | [Name] | [+4 weeks post-launch] |
| V2.0 | F-006 | [Name] | [+8 weeks post-launch] |

---

## Section 4: Testing Requirements

> **Purpose:** Define test cases linked to features and acceptance criteria. The GWT format enables automated test generation.

### 4.1 Test Summary

| Test ID | Feature ID | Test Type | Description | Priority |
|---------|------------|-----------|-------------|----------|
| T-001 | F-001 | Unit | [Brief description] | [P0/P1/P2] |
| T-002 | F-001 | Integration | [Brief description] | [P0/P1/P2] |
| T-003 | F-002 | E2E | [Brief description] | [P0/P1/P2] |

**Test Types:**
- `Unit` - Individual function/component testing
- `Integration` - Multi-component interaction testing
- `E2E` - Full user journey testing
- `Performance` - Load/stress testing
- `Security` - Vulnerability/penetration testing
- `Accessibility` - WCAG compliance testing

### 4.2 Test Cases (GWT Format)

---

#### T-001: [Test Name]

| Attribute | Value |
|-----------|-------|
| **Feature** | F-001: [Feature Name] |
| **Type** | [Unit / Integration / E2E] |
| **Priority** | [P0 / P1 / P2] |
| **Automation** | [Automated / Manual / Hybrid] |

**Given:**
```
[Preconditions - system state, user state, data state]
- User is authenticated
- User has at least one project
- Project has no tasks
```

**When:**
```
[Actions taken - specific user or system actions]
- User navigates to project detail page
- User clicks "Add Task" button
- User fills in task title "New Task"
- User clicks "Save"
```

**Then:**
```
[Expected outcomes - observable results]
- Task appears in project task list
- Task has status "DRAFT"
- Success toast notification displays
- Task count increments by 1
```

**Edge Cases:**
- [Empty title - validation error]
- [Duplicate title - allowed]
- [Network failure - retry with saved draft]

---

#### T-002: [Test Name]

*(Repeat structure for each test case)*

---

### 4.3 Test Coverage Matrix

| Feature ID | Unit | Integration | E2E | Performance | Security | Accessibility |
|------------|------|-------------|-----|-------------|----------|---------------|
| F-001 | T-001 | T-002 | T-003 | - | T-004 | T-005 |
| F-002 | T-006 | T-007 | - | T-008 | - | T-009 |

---

## Section 5: User Flows

> **Purpose:** Document key user journeys through the application.

### 5.1 Critical User Flows

#### Flow 1: [Flow Name, e.g., "New User Onboarding"]

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Landing   │───>│   Sign Up   │───>│   Verify    │───>│  Dashboard  │
│    Page     │    │    Form     │    │   Email     │    │   (Empty)   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                                │
                                                                ▼
                                            ┌─────────────────────────────┐
                                            │   First Project Creation    │
                                            │        (Guided Tour)        │
                                            └─────────────────────────────┘
```

| Step | Screen | User Action | System Response | Success Criteria |
|------|--------|-------------|-----------------|------------------|
| 1 | Landing | Clicks "Get Started" | Navigates to signup | - |
| 2 | Sign Up | Enters email, password | Validates, creates account | Account in DB |
| 3 | Verify | Clicks email link | Verifies account | verified=true |
| 4 | Dashboard | Views empty state | Shows onboarding prompt | - |
| 5 | Create | Completes first project | Saves project, ends tour | Project created |

#### Flow 2: [Flow Name]

*(Repeat structure for each critical flow)*

---

## Section 6: Technical Considerations

> **Purpose:** Provide technical context and constraints for the development team.

### 6.1 Technology Preferences

> **Note:** These are preferences, not mandates. AGENT-11 @architect makes final technology decisions based on project needs.

| Category | Preference | Rationale | Flexibility |
|----------|------------|-----------|-------------|
| Frontend | [React / Vue / Next.js] | [Why] | [Flexible / Preferred / Required] |
| Backend | [Node.js / Python / Go] | [Why] | [Flexible / Preferred / Required] |
| Database | [PostgreSQL / MongoDB] | [Why] | [Flexible / Preferred / Required] |
| Hosting | [Vercel / AWS / Railway] | [Why] | [Flexible / Preferred / Required] |
| Auth | [Supabase / Auth0 / Clerk] | [Why] | [Flexible / Preferred / Required] |

### 6.2 Performance Requirements

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| Page Load (LCP) | < 2.5s | Lighthouse |
| Time to Interactive | < 3.5s | Lighthouse |
| API Response (p50) | < 200ms | APM |
| API Response (p99) | < 1000ms | APM |
| Concurrent Users | [X] users | Load testing |

### 6.3 Security Requirements

| Requirement | Implementation | Priority |
|-------------|----------------|----------|
| Authentication | [Method: JWT, Session, OAuth] | P0 |
| Authorization | [RBAC / ABAC / Simple] | P0 |
| Data Encryption | [At-rest, In-transit] | P0 |
| Input Validation | [Server-side, Client-side] | P0 |
| Rate Limiting | [X requests/minute] | P1 |
| Audit Logging | [All sensitive operations] | P1 |

### 6.4 Integration Requirements

| System | Direction | Method | Priority | Notes |
|--------|-----------|--------|----------|-------|
| [System 1] | Inbound | REST API | P0 | [Notes] |
| [System 2] | Outbound | Webhook | P1 | [Notes] |
| [System 3] | Bidirectional | GraphQL | P2 | [Notes] |

### 6.5 Scalability Considerations

[Notes on expected growth, scaling strategies, and architectural considerations]

---

## Section 7: Handoff Readiness Checklist

> **Purpose:** Validation gate before PRD transfers to AGENT-11. ALL items must be checked before handoff.

### 7.1 Content Completeness

| Category | Checklist Item | Status |
|----------|---------------|--------|
| **At-a-Glance** | Product sentence is clear and specific | [ ] |
| **At-a-Glance** | MVP scope has 3-5 concrete bullet points | [ ] |
| **At-a-Glance** | Non-goals explicitly stated | [ ] |
| **Glossary** | All domain terms defined before first use | [ ] |
| **Data Model** | All entities have attributes and relationships | [ ] |
| **Data Model** | Entity lifecycles (states) are documented | [ ] |
| **Sitemap** | All routes defined with access levels | [ ] |
| **Business Rules** | All validation rules documented | [ ] |
| **State Machines** | All state transitions mapped | [ ] |
| **APIs** | External dependencies listed with rate limits | [ ] |
| **Compliance** | Data classification complete | [ ] |
| **Features** | All features have F-XXX IDs | [ ] |
| **Features** | All features have type classification | [ ] |
| **Features** | All features have touched entities | [ ] |
| **Features** | All features have GWT acceptance criteria | [ ] |
| **Testing** | Test cases linked to feature IDs | [ ] |
| **Testing** | GWT format used for automation readiness | [ ] |

### 7.2 Quality Gates

| Gate | Criteria | Status |
|------|----------|--------|
| **No Ambiguity** | No TBD, TODO, or placeholder text | [ ] |
| **No Conflicts** | No contradictory requirements | [ ] |
| **Testable** | All acceptance criteria are verifiable | [ ] |
| **Scoped** | Clear boundaries between MVP and post-MVP | [ ] |
| **Prioritized** | All features have P0-P3 priority | [ ] |

### 7.3 Open Questions Resolution

| Check | Status |
|-------|--------|
| All [BLOCKING] questions resolved | [ ] |
| [NON-BLOCKING] questions documented for dev team | [ ] |
| Decision owners assigned to remaining questions | [ ] |

### 7.4 Stakeholder Sign-off

| Stakeholder | Role | Date | Signature |
|-------------|------|------|-----------|
| [Name] | Product Owner | [Date] | [ ] Approved |
| [Name] | Technical Lead | [Date] | [ ] Approved |
| [Name] | Business Sponsor | [Date] | [ ] Approved |

---

## Section 8: Success Metrics

> **Purpose:** Define how success will be measured post-launch.

### 8.1 Key Performance Indicators (KPIs)

| Metric | Definition | Baseline | Target | Measurement | Frequency |
|--------|------------|----------|--------|-------------|-----------|
| [Metric 1] | [How it's calculated] | [Current] | [Goal] | [Tool/Method] | [Daily/Weekly] |
| [Metric 2] | [How it's calculated] | [Current] | [Goal] | [Tool/Method] | [Daily/Weekly] |

### 8.2 Business Chassis Impact

| Multiplier | Pre-Launch | Target (30 days) | Target (90 days) |
|------------|------------|------------------|------------------|
| Prospects | [X] | [Y] | [Z] |
| Lead Conversion | [X%] | [Y%] | [Z%] |
| Client Conversion | [X%] | [Y%] | [Z%] |
| Average Spend | [$X] | [$Y] | [$Z] |
| Transaction Frequency | [X] | [Y] | [Z] |
| Margin | [X%] | [Y%] | [Z%] |

### 8.3 User Experience Metrics

| Metric | Target | Tool |
|--------|--------|------|
| Task Completion Rate | >90% | Analytics |
| Error Rate | <2% | Error tracking |
| User Satisfaction (NPS) | >50 | Surveys |
| Time on Task | [Target] | Analytics |

---

## Section 9: Timeline & Resources

### 9.1 Project Timeline

| Phase | Duration | Start | End | Deliverables |
|-------|----------|-------|-----|--------------|
| Architecture | [X days] | [Date] | [Date] | Tech spec, DB schema |
| Development Sprint 1 | [X days] | [Date] | [Date] | [Features] |
| Development Sprint 2 | [X days] | [Date] | [Date] | [Features] |
| Testing | [X days] | [Date] | [Date] | Test report |
| Launch Prep | [X days] | [Date] | [Date] | Deployment, monitoring |
| Launch | [Date] | - | - | Production release |

### 9.2 Resource Requirements

| Role | Allocation | Duration | Notes |
|------|------------|----------|-------|
| Product Owner | [X%] | Full project | Decision-making |
| Developer(s) | [X FTE] | Development phases | Implementation |
| Designer | [X%] | Design + Dev phases | UI/UX support |
| QA | [X%] | Testing phase | Verification |

### 9.3 Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk 1] | [High/Med/Low] | [High/Med/Low] | [Mitigation strategy] |
| [Risk 2] | [High/Med/Low] | [High/Med/Low] | [Mitigation strategy] |

---

## Appendix A: Preference Profile

> **Purpose:** JSON-structured defaults for AGENT-11 configuration. This enables automated setup and consistent decisions.

```json
{
  "product": {
    "name": "[Product Name]",
    "version": "1.0.0",
    "type": "web-app | mobile-app | api | cli"
  },
  "technology": {
    "frontend": {
      "framework": "react | vue | next | svelte",
      "styling": "tailwind | css-modules | styled-components",
      "state": "zustand | redux | context"
    },
    "backend": {
      "runtime": "node | python | go | rust",
      "framework": "express | fastapi | gin | actix",
      "api_style": "rest | graphql | trpc"
    },
    "database": {
      "primary": "postgresql | mysql | mongodb",
      "orm": "prisma | drizzle | sqlalchemy | mongoose",
      "cache": "redis | memcached | none"
    },
    "auth": {
      "provider": "supabase | auth0 | clerk | custom",
      "methods": ["email", "google", "github"]
    },
    "hosting": {
      "frontend": "vercel | netlify | cloudflare",
      "backend": "railway | render | aws | fly",
      "database": "supabase | planetscale | neon | railway"
    }
  },
  "quality": {
    "testing": {
      "unit": "vitest | jest",
      "e2e": "playwright | cypress",
      "coverage_target": 80
    },
    "linting": {
      "eslint": true,
      "prettier": true,
      "typescript": "strict"
    }
  },
  "deployment": {
    "ci_cd": "github-actions | gitlab-ci",
    "environments": ["development", "staging", "production"],
    "preview_deployments": true
  },
  "monitoring": {
    "error_tracking": "sentry | bugsnag | none",
    "analytics": "posthog | plausible | google-analytics",
    "logging": "axiom | logtail | console"
  }
}
```

---

## Appendix B: Reference Documents

| Document | Location | Purpose |
|----------|----------|---------|
| Market Research | [Link] | Competitive analysis, market sizing |
| User Research | [Link] | Interview notes, survey results |
| Brand Guidelines | [Link] | Visual identity, tone of voice |
| Technical Spec | [Link] | Architecture decisions (post-handoff) |
| API Documentation | [Link] | External API references |

---

## Appendix C: Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | [Date] | [Name] | Initial draft |
| 0.2 | [Date] | [Name] | Added System Skeleton |
| 1.0 | [Date] | [Name] | Approved for handoff |

---

## AGENT-11 Handoff Notes

> **For AGENT-11 @coordinator:** This section provides context for the technical team.

### Handoff Summary

| Item | Value |
|------|-------|
| **Handoff Date** | [Date] |
| **PRD Version** | [Version] |
| **Product Owner Contact** | [Email/Slack] |
| **Response Time SLA** | [X hours for questions] |

### Priority Guidance

1. Start with `F-001` through `F-00X` (P0 features)
2. System Skeleton section 2.2-2.4 should inform @architect's database schema
3. GWT acceptance criteria in Section 4 are ready for @tester automation
4. Preference Profile (Appendix A) should guide technology selection

### Known Complexities

[List any areas that may require extra attention or clarification]

### Communication Protocol

For questions during development:
1. Check Open Questions table first (Section 0)
2. Non-blocking questions: Add to project Slack/Discord
3. Blocking questions: Email product owner directly

---

**END OF PRD TEMPLATE v3.1**

---

*This template is part of BOS-AI Operations Library. For updates and best practices, see `/docs/Document Library/Foundation/`*
