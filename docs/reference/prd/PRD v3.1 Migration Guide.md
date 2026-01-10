# PRD v3.1 Migration Guide

**Purpose:** Guide for transitioning existing v1 PRDs to the v3.1 format
**Estimated Time:** 2-3 hours per PRD
**Difficulty:** Moderate

---

## Overview

This guide helps you upgrade existing Product Requirements Documents from v1 to v3.1. The migration focuses on adding the **System Skeleton** sections that bridge business requirements and technical implementation.

### Why Migrate?

| Benefit | Impact |
|---------|--------|
| **Reduced developer questions** | >50% fewer clarification requests |
| **Faster implementation** | Clear data model and business rules |
| **Better test coverage** | GWT format enables automation |
| **Cleaner handoffs** | Validation checklist catches gaps |
| **Traceability** | Feature→Test→Entity mapping |

---

## Migration Steps

### Step 1: Create Section 0 - At-a-Glance (15 min)

**Extract from your existing PRD:**

| Field | Where to Find It |
|-------|------------------|
| Product Sentence | Vision statement (summarize to 1 sentence) |
| Primary User | Target Users section |
| Core Problem | Problem Statement |
| MVP Scope | MVP Features (top 3-5) |
| Non-Goals | Out of Scope section |
| Key Constraints | Technical Considerations |
| Success Metric | Success Metrics (pick #1) |
| Target Launch | Timeline section |

**Add Open Questions Table:**
- Review all "TBD", "TODO", or unclear items
- Tag each as [BLOCKING] or [NON-BLOCKING]
- Assign owners and due dates

```markdown
| ID | Question | Owner | Tag | Due Date | Resolution |
|----|----------|-------|-----|----------|------------|
| Q-001 | What authentication provider? | [Name] | [BLOCKING] | [Date] | Pending |
```

---

### Step 2: Create Section 2 - System Skeleton (60-90 min)

This is the most significant addition. You'll need to analyze your existing PRD to extract implicit information.

#### 2.1 Glossary (15 min)

**Find domain terms in your PRD:**
1. Search for capitalized nouns (User, Project, Task)
2. Search for quoted terms ("active", "pending")
3. Look for acronyms (MVP, KPI, API)

**For each term, document:**
- Definition (unambiguous)
- Example (concrete)
- Related terms

#### 2.2 Conceptual Data Model (20 min)

**Identify entities from your features:**
1. What "things" does your system manage?
2. What are the relationships between them?
3. What states can each entity be in?

**Example transformation:**

Before (v1 Feature):
```
Users can create and manage projects
```

After (v3.1 Data Model):
```markdown
| Entity | Description | Key Attributes | Relationships | Lifecycle |
|--------|-------------|----------------|---------------|-----------|
| User | System user | id, email, name | Has many Projects | active→suspended→deleted |
| Project | Work container | id, title, status | Belongs to User, Has many Tasks | draft→active→complete→archived |
```

#### 2.3 UI Structure - Sitemap (15 min)

**Map your user flows to routes:**
1. What screens exist in your application?
2. Who can access each screen?
3. What are the primary actions on each?

**Example:**
```markdown
| Route | View Name | Access Level | Primary Actions |
|-------|-----------|--------------|-----------------|
| /projects | Project List | Authenticated | Create, Search, Filter |
| /projects/:id | Project Detail | Owner, Member | Edit, Delete, Add Task |
```

#### 2.4 Business Rules & State Machines (15 min)

**Find implicit rules in your features:**
- Look for "only", "must", "cannot", "should"
- Look for validation requirements
- Look for conditional logic

**Example transformation:**

Before (v1 Feature):
```
Only project owners can delete projects
```

After (v3.1 Business Rule):
```markdown
| Rule ID | Entity | Rule | Trigger | Error |
|---------|--------|------|---------|-------|
| BR-001 | Project | Only owner can delete | Delete action | "Unauthorized" (403) |
```

**Create state machines for entities with "status" fields:**
- What states exist?
- What triggers transitions?
- What are the side effects?

#### 2.5 External API Dependencies (10 min)

**List all third-party services:**
- Authentication providers
- Payment processors
- Email services
- Analytics platforms

**For each, document:**
- Rate limits
- Authentication method
- Fallback strategy

#### 2.6 Data Privacy & Compliance (10 min)

**Classify your data:**
- What is PII? (email, name, phone)
- What is financial? (payment tokens)
- What is public? (project titles)

**Check compliance requirements:**
- GDPR (if EU users)
- CCPA (if California users)
- HIPAA (if health data)

---

### Step 3: Enhance Features with IDs and Types (30 min)

**Add to each feature:**

1. **Feature ID:** F-001, F-002, etc.
2. **Type:** CRUD, AUTH, INTEGRATION, ANALYTICS, WORKFLOW, NOTIFICATION, SEARCH, IMPORT/EXPORT
3. **Touched Entities:** Which entities from 2.2 does this feature affect?
4. **Priority:** P0 (MVP critical), P1 (MVP if time), P2 (post-launch), P3 (future)

**Example transformation:**

Before (v1):
```markdown
## User Registration
As a visitor, I want to create an account so I can access the platform.
- Email validation
- Password requirements
- Email verification
```

After (v3.1):
```markdown
#### F-001: User Registration

| Attribute | Value |
|-----------|-------|
| **Type** | AUTH |
| **Priority** | P0 |
| **Touched Entities** | User, VerificationToken |
| **Dependencies** | Email service |
| **Effort** | M (1-3 days) |

**User Story:**
> As a visitor, I want to create an account so I can access the platform.

**Acceptance Criteria (GWT):**

| AC ID | Given | When | Then |
|-------|-------|------|------|
| AC-001-01 | I'm on registration page | I submit valid email/password | Account is created, verification email sent |
| AC-001-02 | I'm on registration page | I submit invalid email | Error "Invalid email format" displays |
| AC-001-03 | I have verification email | I click verification link | Account is verified, redirected to login |
```

---

### Step 4: Convert Acceptance Criteria to GWT (20 min)

**For each feature, rewrite criteria in Given-When-Then format:**

Before:
```
- Users can log in with email and password
- Invalid credentials show error message
```

After:
```markdown
| AC ID | Given | When | Then |
|-------|-------|------|------|
| AC-002-01 | I'm on login page with valid credentials | I click "Sign In" | I'm redirected to dashboard |
| AC-002-02 | I'm on login page with invalid credentials | I click "Sign In" | Error "Invalid credentials" displays |
```

---

### Step 5: Add Test Cases with IDs (15 min)

**Create test cases linked to features:**

```markdown
| Test ID | Feature ID | Type | Description | Priority |
|---------|------------|------|-------------|----------|
| T-001 | F-001 | E2E | Happy path registration | P0 |
| T-002 | F-001 | E2E | Registration with invalid email | P0 |
| T-003 | F-001 | Integration | Email service sends verification | P1 |
```

---

### Step 6: Complete Handoff Checklist (10 min)

**Go through each item in Section 7:**

- [ ] Product sentence is clear
- [ ] MVP scope has 3-5 bullets
- [ ] All domain terms defined
- [ ] All entities documented
- [ ] All routes mapped
- [ ] All business rules explicit
- [ ] All features have IDs
- [ ] All acceptance criteria in GWT
- [ ] All [BLOCKING] questions resolved

---

### Step 7: Add Preference Profile (10 min)

**Fill in Appendix A JSON:**

```json
{
  "product": {
    "name": "Your Product",
    "version": "1.0.0",
    "type": "web-app"
  },
  "technology": {
    "frontend": {
      "framework": "react",
      "styling": "tailwind"
    },
    "backend": {
      "runtime": "node",
      "framework": "express"
    },
    "database": {
      "primary": "postgresql",
      "orm": "prisma"
    }
  }
}
```

---

## Migration Checklist

Use this checklist to track your progress:

### Section 0: At-a-Glance
- [ ] Product sentence written
- [ ] MVP scope documented (3-5 items)
- [ ] Non-goals listed
- [ ] Open questions with tags

### Section 2: System Skeleton
- [ ] 2.1 Glossary complete
- [ ] 2.2 Data model with entities and relationships
- [ ] 2.3 Sitemap with routes and access levels
- [ ] 2.4 Business rules and state machines
- [ ] 2.5 API dependencies listed
- [ ] 2.6 Data classification complete

### Section 3: Features
- [ ] All features have F-XXX IDs
- [ ] All features have types
- [ ] All features have touched entities
- [ ] All features have priorities
- [ ] All acceptance criteria in GWT format

### Section 4: Testing
- [ ] Test cases have T-XXX IDs
- [ ] Test cases linked to features
- [ ] Test cases in GWT format

### Section 7: Handoff Checklist
- [ ] All items verified
- [ ] All [BLOCKING] questions resolved
- [ ] Stakeholder sign-off obtained

### Appendix A: Preference Profile
- [ ] JSON configuration complete

---

## Common Migration Issues

### Issue 1: "I don't know my data model"

**Solution:** Start with your features and work backwards.
1. List all nouns in your features (User, Project, Task)
2. These are your entities
3. Determine relationships by asking "does X have many Y?"

### Issue 2: "My acceptance criteria are vague"

**Solution:** Ask the 3 questions:
1. What must be true before? (Given)
2. What action triggers the behavior? (When)
3. What should happen? (Then)

### Issue 3: "I have too many TBDs"

**Solution:** Tag them appropriately:
- [BLOCKING] if development can't proceed without answer
- [NON-BLOCKING] if it can be decided during development
- Assign owners and due dates

### Issue 4: "I don't know what business rules I have"

**Solution:** Search your PRD for:
- "must", "should", "cannot", "only"
- "if...then" statements
- Validation requirements
- Error conditions

---

## Success Criteria

Your migration is complete when:

1. **Handoff Checklist** - All items checked
2. **No TBDs** - All [BLOCKING] questions resolved
3. **Traceability** - Every feature has ID, type, entities, tests
4. **GWT Format** - All acceptance criteria are automatable
5. **Stakeholder Sign-off** - Business and technical approval

---

## Need Help?

- See `PRD-TEMPLATE-GUIDE.md` for section-by-section guidance
- See `CHANGELOG.md` for what changed from v1 to v3.1
- See the complete template in `Product Requirements Document (PRD) v3.1.md`

---

*Part of BOS-AI Document Library - Foundation*
