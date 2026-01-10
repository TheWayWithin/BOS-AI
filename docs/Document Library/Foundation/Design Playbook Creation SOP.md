# Design Playbook Creation SOP

**Standard Operating Procedure for Creating Design Playbooks**

---

**Document Information:**
- **Version:** 1.0
- **Author:** BOS-AI Documentation Team
- **Date:** January 10, 2026
- **Status:** Active
- **Related Documents:** PRD Creation SOP v2.1, Design Playbook Template, PRD v3.1 Template

---

## Purpose

This SOP provides a systematic process for creating Design Playbooks that accompany Product Requirements Documents (PRDs). The Design Playbook captures non-binding technical preferences and architectural hints to guide implementation while maintaining the separation between **WHAT/WHY** (PRD - binding requirements) and **HOW** (Design Playbook - non-binding preferences).

**Key Principle:** Design Playbooks are OPTIONAL. Not every PRD needs a Design Playbook. Only create one when you have meaningful technical preferences that would benefit the development team.

---

## Overview

### What is a Design Playbook?

A Design Playbook is a **non-binding technical companion** to a PRD that documents:

- **Technical Preferences** - Preferred technologies, frameworks, and tools
- **Architecture Patterns** - Suggested architectural approaches
- **Integration Hints** - Preferred third-party services and APIs
- **Performance Baselines** - Target metrics and optimization preferences
- **Developer Context** - Business context and strategic considerations

### What a Design Playbook is NOT:

- ❌ **Not a technical specification** - All content is advisory, not mandatory
- ❌ **Not binding requirements** - Developers can override any preference with justification
- ❌ **Not an architecture document** - Actual architecture is created during development
- ❌ **Not a replacement for the PRD** - PRD remains the single source of truth for requirements

### The PRD-Playbook Relationship

```
┌─────────────────────────────────────────────┐
│                PRD v3.1                      │
│         (Binding Requirements)               │
│                                              │
│  • WHAT needs to be built                   │
│  • WHY it needs to be built                 │
│  • Success criteria (measurable)            │
│  • User stories and acceptance criteria     │
│  • Business constraints and compliance      │
│                                              │
│  Developer MUST satisfy these               │
└──────────────────┬──────────────────────────┘
                   │
                   │ Accompanied by (optional)
                   ↓
┌─────────────────────────────────────────────┐
│           Design Playbook                    │
│        (Non-Binding Preferences)             │
│                                              │
│  • HOW we prefer to build it                │
│  • Technical preferences and hints          │
│  • Architecture patterns to consider        │
│  • Performance targets to aim for           │
│  • Integration preferences                  │
│                                              │
│  Developer MAY follow, adapt, or override   │
└─────────────────────────────────────────────┘
```

**Conflict Resolution:** PRD always wins. If there's any conflict between PRD requirements and Playbook preferences, the PRD takes precedence.

---

## Prerequisites

**Before creating a Design Playbook, you MUST have:**

1. ✅ **Completed PRD v3.1** - The PRD must be finalized and validated
2. ✅ **Clear technical preferences** - You should have specific preferences worth documenting
3. ✅ **Business context** - Understanding of strategic priorities and constraints
4. ✅ **Solopreneur Defaults file** (if applicable) - Your technology preferences configuration

**PRD Status Check:**
- PRD should be in "Approved" or "Ready for Development" status
- All acceptance criteria should be clearly defined
- Success metrics should be measurable and specific
- Business constraints should be documented

**Decision Point: Do You Need a Design Playbook?**

Ask yourself:
- Do you have strong preferences about HOW this should be built?
- Would technical hints significantly benefit the development team?
- Are there specific technologies, patterns, or integrations you prefer?
- Do you have performance targets or architectural preferences to communicate?

If you answered **NO** to all of these, you probably don't need a Design Playbook. The PRD alone is sufficient.

---

## When to Create a Design Playbook

### High-Value Scenarios (Create Playbook)

✅ **Complex technical products** - SaaS platforms, APIs, multi-tenant systems
✅ **Strong technology preferences** - You have specific frameworks or tools you prefer
✅ **Performance-critical applications** - Real-time systems, high-traffic platforms
✅ **Multiple integration points** - Connecting to various third-party services
✅ **Solopreneur with established stack** - You have Solopreneur Defaults configured
✅ **Technical debt considerations** - Existing codebase constraints to communicate
✅ **Security/compliance context** - Industry-specific technical requirements

### Low-Value Scenarios (Skip Playbook)

❌ **Simple CRUD applications** - Basic database operations with minimal complexity
❌ **No technical preferences** - You're completely flexible on implementation
❌ **Prototypes or MVPs** - Speed matters more than specific technical choices
❌ **Standard implementations** - Common patterns with no special considerations
❌ **First-time products** - You lack context for meaningful technical preferences
❌ **Time-sensitive projects** - Creating playbook would delay start unnecessarily

### The "Maybe" Zone (Use Judgment)

⚠️ **Moderate complexity** - Some technical considerations but not extensive
⚠️ **Partial preferences** - Preferences in some areas but not others
⚠️ **Learning projects** - You want to experiment but have some guardrails
⚠️ **Team handoffs** - Communicating context to external developers

**Rule of Thumb:** If you're unsure, start without a playbook. You can always create one later if technical questions arise during development.

---

## Mode Selection: Auto vs Engaged

### Auto Mode (Recommended for Most Users)

**Best for:**
- First-time Design Playbook creation
- Clear technical preferences already defined
- Solopreneur Defaults file exists
- Time-efficient playbook creation

**What happens:**
- Agent asks focused questions about technical preferences
- Solopreneur Defaults automatically incorporated
- Standard sections populated with common patterns
- Minimal back-and-forth required
- Playbook created in 30-60 minutes

**Activate Auto Mode:**
```
/coord design-playbook-creation auto "PRD-Product-Name.md"
```

### Engaged Mode (For Complex Products)

**Best for:**
- Complex technical products with many considerations
- Novel architecture patterns or unique requirements
- Multiple technology options to evaluate
- Learning about technical trade-offs
- Need to document extensive integration preferences

**What happens:**
- Deep-dive discussions on each technical area
- Exploration of alternatives and trade-offs
- Detailed justification for preferences
- More comprehensive playbook documentation
- Playbook created in 2-4 hours

**Activate Engaged Mode:**
```
/coord design-playbook-creation engaged "PRD-Product-Name.md"
```

### Mode Comparison

| Aspect | Auto Mode | Engaged Mode |
|--------|-----------|-------------|
| **Time** | 30-60 minutes | 2-4 hours |
| **Questions** | Focused, essential | Comprehensive, exploratory |
| **Depth** | Standard preferences | Deep technical analysis |
| **Defaults** | Heavily used | Evaluated and discussed |
| **Trade-offs** | Assumed acceptable | Explicitly documented |
| **Best for** | Clear preferences | Complex decisions |

---

## Creation Process

### Phase 0: Pre-Creation Review (5-10 minutes)

**Objective:** Verify prerequisites and gather necessary context before starting playbook creation.

#### Step 0.1: PRD Verification

Confirm that the PRD exists and is ready:

```
Checklist:
□ PRD v3.1 file exists and is accessible
□ PRD status is "Approved" or "Ready for Development"
□ All acceptance criteria are defined
□ Success metrics are measurable
□ Business constraints are documented
□ No placeholder text remains (e.g., "[To be determined]")
```

If any item is unchecked, **STOP** and complete the PRD first.

#### Step 0.2: Context Gathering

**Review these documents:**
- **PRD v3.1** - Understand requirements and constraints
- **Solopreneur Defaults** (if exists) - Your technology preferences
- **Existing Architecture Docs** (if applicable) - Current system context
- **Ideation Notes** - Strategic context and vision

**Key Questions to Answer:**
1. What is the core functionality being built?
2. Are there existing systems this must integrate with?
3. What are the critical performance requirements?
4. Are there compliance or security constraints?
5. What is the expected scale (users, data, traffic)?

#### Step 0.3: Playbook Necessity Check

Before proceeding, confirm you actually need a Design Playbook:

**Ask yourself:**
- [ ] Do I have specific technology preferences to document?
- [ ] Would architectural hints benefit the development team?
- [ ] Are there performance targets beyond PRD requirements?
- [ ] Do I have integration preferences to communicate?
- [ ] Is there valuable technical context not in the PRD?

**Decision:**
- **3+ Yes answers:** Proceed with playbook creation
- **1-2 Yes answers:** Consider a lightweight playbook (skip optional sections)
- **0 Yes answers:** Skip playbook - PRD is sufficient

#### Step 0.4: Initialize Playbook Document

Create the playbook file:

**File Naming Convention:**
```
Design-Playbook-[Product-Name]-[Version].md

Examples:
Design-Playbook-TaskMaster-v1.0.md
Design-Playbook-CustomerPortal-v1.0.md
Design-Playbook-AnalyticsDashboard-v1.0.md
```

**Location:**
- Same directory as the PRD
- Reference playbook in PRD header metadata

**Phase 0 Completion Criteria:**
- ✅ PRD verified and accessible
- ✅ Context documents reviewed
- ✅ Playbook necessity confirmed
- ✅ Playbook file initialized with header

---

### Phase 1: Technical Preferences (15-30 minutes)

**Objective:** Document preferred technologies, frameworks, and tools for the project.

#### Section 1.1: Database Preferences

**Questions to Address:**
1. What type of database do you prefer (SQL, NoSQL, hybrid)?
2. Do you have a specific database product preference (PostgreSQL, MongoDB, etc.)?
3. Are there data modeling patterns you prefer (normalized, denormalized)?
4. What are your preferences for database hosting (managed service, self-hosted)?

**Solopreneur Defaults Integration:**
If Solopreneur Defaults file exists, automatically populate this section with configured preferences. User can review and adjust.

#### Section 1.2: Authentication & Authorization

**Questions to Address:**
1. Do you prefer a specific auth provider (Auth0, Supabase Auth, custom)?
2. What authentication methods should be supported (email/password, OAuth, SSO)?
3. How should authorization be handled (RBAC, ABAC, simple roles)?
4. Are there session management preferences?

#### Section 1.3: Hosting & Infrastructure

**Questions to Address:**
1. What hosting platform do you prefer (Vercel, Railway, AWS, etc.)?
2. Do you prefer serverless, containerized, or traditional server architecture?
3. What are your preferences for CDN and static asset hosting?
4. Are there specific infrastructure-as-code tools you prefer?

#### Section 1.4: Frontend Framework & Tooling

**Questions to Address:**
1. What frontend framework do you prefer (React, Vue, Svelte, etc.)?
2. Are there specific meta-frameworks you prefer (Next.js, Nuxt, SvelteKit)?
3. What are your preferences for state management?
4. What styling approach do you prefer (Tailwind, CSS Modules, styled-components)?

#### Section 1.5: Backend Framework & API Design

**Questions to Address:**
1. What backend framework or runtime do you prefer?
2. What API architecture do you prefer (REST, GraphQL, tRPC)?
3. Are there specific libraries or tools you prefer for API development?
4. What are your preferences for API documentation?

**Phase 1 Completion Criteria:**
- ✅ Database preferences documented
- ✅ Auth approach specified
- ✅ Hosting platform identified
- ✅ Frontend stack defined
- ✅ Backend framework selected
- ✅ Solopreneur Defaults integrated (if applicable)

---

### Phase 2: Architecture Patterns (20-40 minutes)

**Objective:** Document preferred architectural approaches and design patterns.

#### Section 2.1: Application Architecture

**Questions to Address:**
1. What overall architecture pattern do you prefer (monolith, microservices, modular monolith)?
2. How should the application be structured (layered, hexagonal, clean architecture)?
3. What are your preferences for code organization?

#### Section 2.2: Multi-Tenancy (If Applicable)

**Questions to Address:**
1. Is this a multi-tenant application?
2. What isolation level do you prefer (database, schema, row-level)?
3. How should tenant data be segregated?
4. What are your preferences for tenant management?

**Note:** Skip this section if the product is single-tenant.

#### Section 2.3: Caching Strategy

**Questions to Address:**
1. What layers should implement caching (CDN, application, database)?
2. What caching technology do you prefer (Redis, in-memory, browser)?
3. What are your cache invalidation preferences?
4. What should be cached (API responses, static assets, computed results)?

#### Section 2.4: Error Handling & Logging

**Questions to Address:**
1. What error handling pattern do you prefer?
2. What logging solution do you prefer (cloud service, self-hosted)?
3. What should be logged (errors only, all requests, user actions)?
4. How should errors be presented to users?

#### Section 2.5: Testing Strategy

**Questions to Address:**
1. What testing frameworks do you prefer?
2. What test coverage targets do you have?
3. What types of tests should be prioritized?
4. What are your preferences for test organization?

**Phase 2 Completion Criteria:**
- ✅ Application architecture pattern defined
- ✅ Multi-tenancy approach specified (if applicable)
- ✅ Caching strategy documented
- ✅ Error handling and logging preferences set
- ✅ Testing strategy outlined

---

### Phase 3: Integration Preferences (15-25 minutes)

**Objective:** Document preferences for third-party services and integrations.

#### Section 3.1: Payment Processing (If Applicable)

**Questions to Address:**
1. What payment processor do you prefer (Stripe, PayPal, etc.)?
2. What payment methods should be supported?
3. How should subscriptions be handled?
4. What are webhook handling preferences?

**Note:** Skip this section if the product doesn't involve payments.

#### Section 3.2: Email & Notifications

**Questions to Address:**
1. What email service do you prefer (SendGrid, Postmark, etc.)?
2. What notification channels should be supported?
3. How should email templates be managed?
4. What are your preferences for transactional vs. marketing emails?

#### Section 3.3: File Storage & CDN

**Questions to Address:**
1. What file storage service do you prefer (S3, Cloudflare R2, etc.)?
2. How should file uploads be handled (direct, presigned URLs)?
3. What CDN should be used for file delivery?
4. What are your preferences for image optimization?

#### Section 3.4: Analytics & Monitoring

**Questions to Address:**
1. What analytics platform do you prefer?
2. What should be tracked (page views, events, user behavior)?
3. What monitoring tools should be used?
4. What are your preferences for real-time vs. batch analytics?

#### Section 3.5: Search & Indexing (If Applicable)

**Questions to Address:**
1. What search solution do you prefer (Algolia, Elasticsearch, database full-text)?
2. What should be searchable?
3. How should search results be ranked?
4. What are your preferences for search performance?

**Note:** Skip this section if search is not a core feature.

**Phase 3 Completion Criteria:**
- ✅ Payment processing preferences documented (if applicable)
- ✅ Email and notification strategy defined
- ✅ File storage and CDN preferences set
- ✅ Analytics and monitoring approach specified
- ✅ Search solution identified (if applicable)

---

### Phase 4: Security & Performance (15-25 minutes)

**Objective:** Document security baselines and performance targets.

#### Section 4.1: Security Requirements & Best Practices

**Questions to Address:**
1. What security standards should be followed (OWASP, industry-specific)?
2. What are your preferences for data encryption?
3. How should secrets be managed?
4. What security testing should be performed?

#### Section 4.2: Performance Targets & Optimization

**Questions to Address:**
1. What are your target response times?
2. What are acceptable load times for different page types?
3. What are your preferences for performance monitoring?
4. What optimization techniques should be prioritized?

#### Section 4.3: Data Privacy & Compliance

**Questions to Address:**
1. What data privacy regulations apply?
2. How should user data be handled?
3. What are your preferences for data retention?
4. How should data deletion requests be handled?

#### Section 4.4: Backup & Disaster Recovery

**Questions to Address:**
1. What backup frequency do you prefer?
2. How long should backups be retained?
3. What is your preferred disaster recovery approach?
4. What are acceptable recovery time objectives (RTO) and recovery point objectives (RPO)?

**Phase 4 Completion Criteria:**
- ✅ Security requirements and standards documented
- ✅ Performance targets defined
- ✅ Data privacy and compliance preferences set
- ✅ Backup and disaster recovery strategy outlined

---

### Phase 5: Developer Notes & Finalization (10-15 minutes)

**Objective:** Add contextual information and finalize the Design Playbook.

#### Section 5.1: Business Context for Developers

**Questions to Address:**
1. What business context would help developers make better technical decisions?
2. What are the strategic priorities for this product?
3. What are the long-term plans that might influence architecture?
4. What are known constraints or technical debt to be aware of?

#### Section 5.2: Flexibility & Override Guidelines

**Clearly communicate that all preferences are non-binding:**

```markdown
### Flexibility & Override Guidelines

**Core Principle:**
All preferences in this Design Playbook are **advisory, not mandatory**. Developers should feel empowered to:

✅ **Override any preference** with technical justification
✅ **Suggest alternatives** that better meet requirements
✅ **Adapt patterns** to specific use cases
✅ **Question assumptions** if context has changed

**When to Override:**
- Technical constraints make preference impractical
- Better alternatives discovered during implementation
- Cost/performance trade-offs favor different approach
- Team expertise aligns with different technology

**Remember:**
- PRD requirements are binding - Design Playbook is not
- If conflict between PRD and Playbook, PRD wins
- Developer judgment on HOW trumps playbook preferences
- Focus on meeting requirements, not following preferences
```

#### Section 5.3: Questions & Clarifications

**Document areas where you need developer input:**

- Questions for Developer
- Areas Needing Clarification
- Feedback Welcome On

#### Section 5.4: Document Finalization

**Final review and status update:**

1. **Version Control:**
   - Update "Last Updated" date in header
   - Change status from "Draft" to "Ready for Review"
   - Increment version if this is an update

2. **Cross-Reference with PRD:**
   - Add Design Playbook reference to PRD header metadata
   - Verify no conflicts between PRD requirements and playbook preferences
   - Ensure business constraints in PRD are reflected in playbook context

3. **Completeness Check:**
   ```
   □ All relevant sections completed (or marked N/A)
   □ Solopreneur Defaults integrated (if applicable)
   □ Technical preferences clearly stated
   □ Flexibility guidelines included
   □ Business context provided
   □ Questions and clarifications documented
   □ Override protocol explained
   ```

**Phase 5 Completion Criteria:**
- ✅ Business context documented
- ✅ Flexibility and override guidelines clear
- ✅ Questions and clarifications listed
- ✅ Document finalized and version controlled
- ✅ Cross-referenced with PRD

---

## Solopreneur Defaults Integration

### What are Solopreneur Defaults?

Solopreneur Defaults is a configuration file (`Solopreneur-Defaults.json`) that stores your standard technology preferences, eliminating repetitive decisions across multiple projects.

**Location:** `/docs/Document Library/Foundation/Solopreneur-Defaults.json`

### When Defaults Apply to Design Playbooks

If a Solopreneur Defaults file exists:
- **Auto Mode:** Defaults automatically populate playbook sections
- **Engaged Mode:** Defaults serve as starting point for discussion
- **Override:** You can override defaults for any specific project

### Using Defaults in Design Playbook Creation

**Auto Mode with Defaults:**
```
/coord design-playbook-creation auto "PRD-Product-Name.md"
```
- Agent reads Solopreneur Defaults
- Auto-populates playbook sections
- Asks only for project-specific preferences
- Creates playbook in 30-45 minutes

**Engaged Mode with Defaults:**
```
/coord design-playbook-creation engaged "PRD-Product-Name.md"
```
- Agent presents defaults as starting point
- Discusses alternatives and trade-offs
- Validates defaults against project requirements
- Creates comprehensive playbook in 2-3 hours

**Project-Specific Overrides:**
You can always override defaults for a specific project:
- "Use PostgreSQL instead of my default MongoDB for this project"
- "This project needs Next.js instead of my usual React"
- Overrides are documented in the playbook, defaults file unchanged

---

## Validation Checklist

**Before considering the Design Playbook complete, verify:**

### Content Completeness
- [ ] All relevant sections completed or marked N/A
- [ ] Technical preferences clearly stated with rationale
- [ ] Integration preferences documented
- [ ] Security and performance targets defined
- [ ] Business context provided for developers
- [ ] Solopreneur Defaults integrated (if applicable)

### Clarity & Usability
- [ ] Preferences are specific, not vague
- [ ] Rationale provided for major technology choices
- [ ] Flexibility and override guidelines included
- [ ] Questions and clarifications documented
- [ ] No jargon without explanation

### PRD Alignment
- [ ] PRD v3.1 exists and is finalized
- [ ] No conflicts between PRD requirements and playbook preferences
- [ ] Business constraints from PRD reflected in playbook
- [ ] PRD referenced in playbook header
- [ ] Playbook referenced in PRD metadata

### Non-Binding Nature
- [ ] Clear statement that all preferences are advisory
- [ ] Override protocol explained
- [ ] Developer empowerment emphasized
- [ ] PRD supremacy acknowledged

### Version Control
- [ ] Version number assigned (v1.0 for new, incremented for updates)
- [ ] Creation date documented
- [ ] Last updated date current
- [ ] Status updated (Draft → Ready for Review → Final)
- [ ] Author identified

### Handoff Readiness
- [ ] Document saved in correct location (same directory as PRD)
- [ ] File naming convention followed
- [ ] Cross-references with PRD established
- [ ] Ready for developer review

**If all items checked:** Design Playbook is complete and ready for handoff.

**If any items unchecked:** Address gaps before finalizing.

---

## PRD-Playbook Relationship

### Clear Separation of Concerns

**PRD v3.1 (BINDING):**
- **WHAT** needs to be built
- **WHY** it needs to be built
- **Success criteria** (measurable outcomes)
- **User stories** and acceptance criteria
- **Business constraints** and compliance requirements
- **Functional requirements** (features and capabilities)

**Design Playbook (NON-BINDING):**
- **HOW** we prefer to build it (technical preferences)
- **Architecture patterns** to consider
- **Technology choices** that align with business strategy
- **Integration preferences** for third-party services
- **Performance targets** beyond PRD requirements
- **Developer context** for better decision-making

### Conflict Resolution Protocol

**If PRD and Design Playbook conflict:**

1. **PRD Always Wins**
   - PRD requirements are binding
   - Playbook preferences are advisory
   - Developer must satisfy PRD, may ignore playbook

2. **Escalation Path**
   - Developer identifies conflict
   - Reviews PRD requirement and playbook preference
   - If playbook preference prevents PRD satisfaction → override playbook
   - If unclear → escalate to product owner for clarification

3. **Documentation**
   - Document which playbook preferences were overridden
   - Explain technical rationale
   - Update playbook if override reveals better approach

### Handoff Workflow

**From Business to Development:**

```
1. Product Owner creates PRD v3.1
   ↓
2. Product Owner creates Design Playbook (optional)
   ↓
3. Both documents handed off to development team
   ↓
4. Developer reads PRD (binding requirements)
   ↓
5. Developer reads Design Playbook (advisory context)
   ↓
6. Developer makes technical decisions:
   - Must satisfy PRD requirements
   - May follow playbook preferences
   - May override playbook with justification
   ↓
7. Developer implements solution
   ↓
8. Solution validated against PRD (not playbook)
```

### Update Protocol

**When PRD Changes:**
- Review Design Playbook for alignment
- Update playbook if technical preferences affected
- Increment playbook version (v1.0 → v1.1)
- Document what changed and why

**When Technical Landscape Changes:**
- Update playbook with new preferences
- Don't modify PRD unless business requirements change
- Clearly mark updated sections with dates

**When Implementation Deviates:**
- PRD remains unchanged (it defined requirements, not implementation)
- Optionally update playbook to reflect actual implementation
- Document why deviation occurred (learning for future)

---

## Common Mistakes to Avoid

### Mistake 1: Making Playbook Preferences Binding

❌ **WRONG:**
```markdown
### Database Requirements
- **MUST use PostgreSQL** with Supabase hosting
- **REQUIRED:** Prisma ORM for all database access
```

✅ **CORRECT:**
```markdown
### Database Preferences
- **Preferred:** PostgreSQL with Supabase hosting
- **Rationale:** Team familiarity, managed service simplicity
- **Alternative:** MySQL or MongoDB acceptable if technical constraints require
```

**Why:** Playbook preferences are advisory, not mandatory. Using language like "MUST" or "REQUIRED" violates the non-binding principle.

---

### Mistake 2: Duplicating PRD Requirements in Playbook

❌ **WRONG:**
```markdown
### Performance Requirements
- Application must support 10,000 concurrent users
- All API responses must complete in under 200ms
- Database queries must complete in under 100ms
```

✅ **CORRECT:**
```markdown
### Performance Preferences
- **PRD Requirement:** Support 10,000 concurrent users (see PRD Section 3.2)
- **Preferred Approach:** Horizontal scaling with load balancer
- **Monitoring:** Real-time performance dashboard to track against targets
- **Optimization Priority:** Focus on database query optimization first
```

**Why:** PRD already contains binding requirements. Playbook should provide HOW to achieve them, not repeat WHAT is required.

---

### Mistake 3: Creating Playbook Without PRD

❌ **WRONG:**
```
Product idea: "Build a task management app"
↓
Jump straight to Design Playbook creation
```

✅ **CORRECT:**
```
Product idea: "Build a task management app"
↓
Create PRD v3.1 first (define WHAT and WHY)
↓
Validate PRD is complete and approved
↓
Then create Design Playbook (define HOW preferences)
```

**Why:** The playbook provides technical context for implementing requirements. Without a PRD defining those requirements, the playbook has no foundation.

---

### Mistake 4: Being Too Vague

❌ **WRONG:**
```markdown
### Database Preferences
- Use a modern database
- Should be scalable
- Performance is important
```

✅ **CORRECT:**
```markdown
### Database Preferences
- **Preferred:** PostgreSQL 15+ hosted on Supabase
- **Scalability:** Prefer horizontal read replicas over vertical scaling
- **Performance Target:** Sub-100ms query response times for 95th percentile
- **Rationale:** PostgreSQL for relational data integrity, Supabase for managed service simplicity and built-in auth integration
```

**Why:** Vague preferences provide no value to developers. Be specific about technologies, patterns, and targets.

---

### Mistake 5: Ignoring Solopreneur Defaults

❌ **WRONG:**
```
Solopreneur Defaults file exists with Next.js preference
↓
Manually type "Next.js" into playbook without reading defaults
↓
Miss other configured preferences (styling, hosting, etc.)
```

✅ **CORRECT:**
```
Solopreneur Defaults file exists
↓
Use Auto Mode: Defaults automatically populate playbook
↓
Review and adjust only project-specific deviations
```

**Why:** Defaults save time and ensure consistency. Ignoring them wastes effort and may miss valuable preferences.

---

### Mistake 6: Creating Playbook for Every Project

❌ **WRONG:**
```
Every project must have:
✓ PRD
✓ Design Playbook  ← NOT always necessary
✓ Architecture doc
```

✅ **CORRECT:**
```
Every project must have:
✓ PRD (always required)

Optionally add:
⚠ Design Playbook (only if meaningful technical preferences exist)
⚠ Architecture doc (created during development, not before)
```

**Why:** Simple projects don't need extensive playbooks. Create playbooks only when they add genuine value.

---

### Mistake 7: Making Playbook Overly Detailed

❌ **WRONG:**
```markdown
### Frontend Preferences
- Use React 18.2.0 exactly
- Component structure: src/components/[feature]/[ComponentName].tsx
- State management: Zustand with persist middleware v2.1.1
- Testing: Jest 29.3.1 with React Testing Library 14.0.0
- Exact folder structure:
  - src/
    - components/
      - auth/
      - dashboard/
    - hooks/
    - utils/
```

✅ **CORRECT:**
```markdown
### Frontend Preferences
- **Framework:** React 18+ with TypeScript
- **State Management:** Zustand preferred for simplicity
- **Organization:** Feature-based component structure
- **Testing:** Jest + React Testing Library for component tests
- **Rationale:** Team familiarity, TypeScript for type safety, Zustand for simpler state management vs Redux
```

**Why:** Playbook provides preferences and rationale, not prescriptive implementation details. Developers need flexibility, not micromanagement.

---

### Mistake 8: Forgetting the Override Protocol

❌ **WRONG:**
```markdown
# Design Playbook

[All technical preferences listed]

[No mention of flexibility or override guidelines]
```

✅ **CORRECT:**
```markdown
# Design Playbook

[All technical preferences listed]

## Flexibility & Override Guidelines

All preferences are advisory. Developers should:
✅ Override with justification
✅ Suggest better alternatives
✅ Focus on meeting PRD requirements

PRD wins in any conflict.
```

**Why:** Without clear override guidelines, developers may treat playbook as binding, limiting their technical judgment.

---

### Mistake 9: Not Cross-Referencing PRD

❌ **WRONG:**
```
PRD exists: PRD-TaskMaster-v3.1.md
Playbook exists: Design-Playbook-TaskMaster-v1.0.md
↓
No links between them
Developer may miss one or the other
```

✅ **CORRECT:**
```
PRD header metadata:
  Design Playbook: Design-Playbook-TaskMaster-v1.0.md

Playbook header:
  PRD Version: v3.1 (link: PRD-TaskMaster-v3.1.md)
```

**Why:** Clear cross-referencing ensures developers find both documents and understand their relationship.

---

### Mistake 10: Creating Playbook Too Early

❌ **WRONG:**
```
Day 1: Product idea conceived
Day 2: Create Design Playbook with technical preferences
Day 10: Finally create PRD
↓
Playbook created before requirements are clear
```

✅ **CORRECT:**
```
Day 1: Product idea conceived
Day 2-5: Create and refine PRD v3.1
Day 6: PRD approved and finalized
Day 7: Create Design Playbook based on PRD context
```

**Why:** Technical preferences should be informed by business requirements. Creating playbook before PRD is finalized leads to misalignment.

---

## Appendix: Quick Reference Card

### Design Playbook Creation at a Glance

**Prerequisites:**
- ✅ PRD v3.1 finalized and approved
- ✅ Clear technical preferences to document
- ✅ Solopreneur Defaults file (optional but helpful)

**Mode Selection:**
- **Auto Mode:** 30-60 minutes, defaults-driven, focused questions
- **Engaged Mode:** 2-4 hours, comprehensive discussion, trade-off analysis

**Core Phases:**
1. **Phase 0:** Pre-Creation Review (5-10 min)
2. **Phase 1:** Technical Preferences (15-30 min)
3. **Phase 2:** Architecture Patterns (20-40 min)
4. **Phase 3:** Integration Preferences (15-25 min)
5. **Phase 4:** Security & Performance (15-25 min)
6. **Phase 5:** Developer Notes & Finalization (10-15 min)

**Key Sections:**
- Database, Auth, Hosting preferences
- Frontend & Backend stack
- Caching, Error Handling, Testing
- Third-party integrations
- Security baselines & Performance targets
- Business context for developers

**Critical Principles:**
- ✅ All preferences are NON-BINDING
- ✅ PRD always wins in conflicts
- ✅ Developers can override with justification
- ✅ Playbook is OPTIONAL (not every PRD needs one)

**Commands:**
```bash
# Auto Mode (recommended)
/coord design-playbook-creation auto "PRD-Product-Name.md"

# Engaged Mode (complex products)
/coord design-playbook-creation engaged "PRD-Product-Name.md"

# Create Solopreneur Defaults (first time)
/coord create-solopreneur-defaults
```

**Validation Checklist:**
- [ ] All relevant sections completed
- [ ] PRD referenced and aligned
- [ ] Flexibility guidelines included
- [ ] Business context provided
- [ ] Version control updated
- [ ] Ready for developer handoff

**Common Mistakes:**
- ❌ Making preferences binding (use "preferred", not "must")
- ❌ Duplicating PRD requirements
- ❌ Creating playbook before PRD
- ❌ Being too vague or too detailed
- ❌ Forgetting override protocol

**Remember:**
- **PRD** = WHAT and WHY (binding)
- **Design Playbook** = HOW preferences (non-binding)
- **Conflict Resolution** = PRD wins

---

**Questions or need help?**
- Review PRD Creation SOP v2.1 for similar structure patterns
- Check Design Playbook Template for section details
- Use `/meeting @solution-design "playbook creation help"` for guidance

---

**Document Status:** Active SOP for Design Playbook creation process
**Last Updated:** January 10, 2026
**Version:** 1.0

---

*Design Playbook Creation SOP v1.0 - Part of BOS-AI Foundation Document Library*
*Companion to PRD v3.1 and PRD Creation SOP v2.1*
