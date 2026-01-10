# PRD Template v3.1 - Quick Reference Guide

## Overview

PRD v3.1 introduces the **System Skeleton** approach to bridge strategic vision (BOS-AI) with technical execution (AGENT-11). This guide helps you complete the template efficiently.

---

## Section Completion Order

### Phase 1: Foundation (30 minutes)

1. **Section 0: PRD At-a-Glance**
   - Complete the executive summary table FIRST
   - This forces clarity on scope before details
   - Add all known open questions with [BLOCKING]/[NON-BLOCKING] tags

2. **Section 1.1-1.3: Problem & Users**
   - Vision statement (2-3 sentences)
   - Problem statement with gap analysis
   - Target user personas

### Phase 2: System Skeleton (60-90 minutes)

3. **Section 2.1: Glossary**
   - Define ALL domain-specific terms
   - Add terms as you write other sections
   - This prevents implementation ambiguity

4. **Section 2.2: Conceptual Data Model**
   - List all entities and their relationships
   - Define key attributes for each entity
   - Document lifecycle states (draft→active→archived)

5. **Section 2.3: UI Structure (Sitemap)**
   - Map all routes/pages
   - Define access levels for each
   - Note primary actions per screen

6. **Section 2.4: Business Rules & State Machines**
   - Document all validation rules
   - Create state diagrams for complex entities
   - Map state transitions with triggers

7. **Section 2.5: External API Dependencies**
   - List all third-party services
   - Document rate limits and fallbacks
   - Note authentication methods

8. **Section 2.6: Data Privacy & Compliance**
   - Classify all data types
   - Complete compliance checklist
   - Document retention policies

### Phase 3: Features (45-60 minutes per feature)

9. **Section 3: Features**
   - Use F-001, F-002 numbering
   - Assign type (CRUD, AUTH, INTEGRATION, etc.)
   - List touched entities
   - Write GWT acceptance criteria

### Phase 4: Testing & Validation (30 minutes)

10. **Section 4: Testing Requirements**
    - Create T-001, T-002 test cases
    - Link to feature IDs
    - Use GWT format for automation

11. **Section 7: Handoff Readiness Checklist**
    - Complete ALL checkboxes
    - Resolve ALL [BLOCKING] questions
    - Get stakeholder sign-off

### Phase 5: Appendices (15 minutes)

12. **Appendix A: Preference Profile**
    - Fill in JSON configuration
    - Document technology preferences
    - Set quality targets

---

## Key Principles

### 1. No Ambiguity
Every requirement must be specific enough that two developers would implement it the same way.

**Bad:** "The system should be fast"
**Good:** "API responses must complete in <200ms (p50), <1000ms (p99)"

### 2. Traceability
Every feature has an ID (F-001) that links to:
- Acceptance criteria (AC-001-01)
- Test cases (T-001)
- Touched entities
- Dependencies

### 3. GWT Format
All acceptance criteria use Given-When-Then:

```
Given: [Precondition - system/user state]
When: [Action taken]
Then: [Expected outcome - observable result]
```

### 4. Blocking vs Non-Blocking
Open questions must be tagged:
- `[BLOCKING]` - Must resolve before handoff
- `[NON-BLOCKING]` - Can resolve during development

---

## Feature Type Reference

| Type | Examples | Typical Effort |
|------|----------|----------------|
| CRUD | User management, project CRUD | S-M |
| AUTH | Login, registration, password reset | M |
| INTEGRATION | Stripe payments, email service | M-L |
| ANALYTICS | Dashboard, reports, charts | M-L |
| WORKFLOW | Multi-step approval, wizard | L-XL |
| NOTIFICATION | Email, push, in-app alerts | S-M |
| SEARCH | Full-text search, filters, sort | M-L |
| IMPORT/EXPORT | CSV upload, data export | M |

---

## Priority Definitions

| Priority | Meaning | MVP Status |
|----------|---------|------------|
| P0 | Must have for launch | IN MVP |
| P1 | Should have for launch | IN MVP (if time) |
| P2 | Nice to have | Post-launch |
| P3 | Future consideration | Backlog |

---

## Common Mistakes to Avoid

### 1. Skipping the Glossary
"Everyone knows what a 'project' is" - No, they don't. Define it.

### 2. Vague Acceptance Criteria
"User can manage projects" - What does "manage" mean? Create? Edit? Delete? Share?

### 3. Missing State Machines
If an entity has a "status" field, you need a state machine diagram.

### 4. Undocumented API Dependencies
Each external service needs rate limits, fallback behavior, and SLA documented.

### 5. Incomplete Handoff Checklist
Don't hand off until ALL checkboxes are checked. Incomplete PRDs cause rework.

---

## Template Sections at a Glance

| Section | Purpose | Agent Benefit |
|---------|---------|---------------|
| 0. At-a-Glance | Quick orientation | Immediate context |
| 1. Product Overview | Vision & context | Business understanding |
| 2. System Skeleton | Architecture blueprint | Implementation clarity |
| 3. Features | Detailed requirements | Development tasks |
| 4. Testing | Verification criteria | Test automation |
| 5. User Flows | Journey mapping | UX implementation |
| 6. Technical | Constraints & preferences | Architecture decisions |
| 7. Handoff Checklist | Quality gate | Prevents incomplete handoffs |
| 8. Success Metrics | Measurement | Post-launch validation |
| 9. Timeline | Planning | Resource allocation |
| A. Preference Profile | Configuration | Automated setup |

---

## AGENT-11 Integration

When this PRD is handed to AGENT-11:

1. **@coordinator** reads Section 0 for quick context
2. **@architect** uses Section 2 (System Skeleton) for technical design
3. **@developer** uses Section 3 (Features) for implementation
4. **@tester** uses Section 4 (Testing) for test automation
5. **Appendix A** (Preference Profile) guides technology selection

---

*For the complete template, see: `Product Requirements Document (PRD) v3.1.md`*
