# PRD Before/After Examples: v1 to v3.1 Transformation

> **Purpose**: Concrete examples showing how to transform v1 PRD content into v3.1 format
> **Audience**: Teams learning v3.1 structure through practical examples

---

## Example 1: Feature Definition

### BEFORE (v1 Style)

```markdown
## Features and Requirements

### User Authentication

Users should be able to log in to the system using their email and password.
The system should remember users who choose to stay logged in. Premium users
should have priority access during high-traffic periods. Failed login attempts
should be tracked for security purposes.

**Acceptance Criteria:**
- User can log in with email and password
- "Remember me" functionality works
- Premium users get priority
- Failed attempts are logged
```

**Problems with v1:**
- No feature ID for traceability
- Business rules buried in prose ("premium users should have priority")
- Acceptance criteria not testable ("works" is vague)
- No indication of what data entities are involved
- No feature type classification

---

### AFTER (v3.1 Style)

```markdown
## Section 3: Features & Requirements

### 3.1 Feature Summary

| Feature ID | Feature Name | Type | Priority | Touched Entities | Est. Effort | Dependencies |
|------------|--------------|------|----------|------------------|-------------|--------------|
| F-001 | User Authentication | AUTH | P0 | User, Session, AuditLog | M | - |

### F-001: User Authentication

| Attribute | Value |
|-----------|-------|
| **Type** | AUTH |
| **Priority** | P0 |
| **Touched Entities** | User, Session, AuditLog |
| **Dependencies** | - |
| **Estimated Effort** | M (1-3 days) |

**Description**: Secure authentication system allowing users to access the platform using email/password credentials with session persistence options.

**User Story:**
> As a registered user, I want to log in securely so that I can access my account.

**Acceptance Criteria (GWT Format):**

| AC ID | Given | When | Then |
|-------|-------|------|------|
| AC-001-01 | A registered user on login page | They submit valid credentials | They are authenticated and redirected to dashboard within 2 seconds |
| AC-001-02 | A registered user on login page | They submit invalid credentials | They see error "Invalid email or password" and attempt is logged |
| AC-001-03 | A user selects "Remember me" during login | They close and reopen browser within 30 days | They remain authenticated without re-entering credentials |
| AC-001-04 | 5 failed login attempts from same IP in 15 minutes | A 6th attempt is made | The IP is temporarily blocked for 30 minutes |

**Related Business Rules**: BR-003 (Premium Priority), BR-007 (Rate Limiting)
```

**Improvements in v3.1:**
- F-001 ID enables traceability
- Feature type (AUTH) clarifies category
- Touched entities explicit for developers
- GWT format makes criteria testable
- Business rules extracted and cross-referenced
- Specific numbers (2 seconds, 5 attempts, 30 minutes) remove ambiguity

---

## Example 2: Business Rules

### BEFORE (v1 Style)

Business rules scattered throughout the document:

```markdown
## Product Overview
...Our premium tier customers expect faster response times and priority
processing during peak hours...

## Features and Requirements
### Order Processing
...Premium users should have priority access during high-traffic periods.
Orders over $500 require manager approval before processing...

## Technical Considerations
...The system should process premium orders before standard orders during
high load situations...
```

**Problems with v1:**
- Same rule mentioned 3 times in different sections
- No consistent definition of "priority"
- No rule about what happens when rules conflict
- Rules mixed with context and requirements

---

### AFTER (v3.1 Style)

```markdown
## Section 2.4: Business Rules & State Machines

### Business Rules

| Rule ID | Entity | Rule Description | Trigger | Action | Error Handling |
|---------|--------|------------------|---------|--------|----------------|
| BR-003 | Order | Premium users get queue priority when system load > 70% | Order submission | Set Order.queuePriority = HIGH | - |
| BR-004 | Order | Orders >= $500 require manager approval | Order submission | Set Order.status = PENDING_APPROVAL | - |
| BR-005 | Order | Standard users get normal queue priority | Order submission | Set Order.queuePriority = NORMAL | - |

### BR-003: Premium Queue Priority

**Condition**:
```
IF User.tier = 'Premium'
AND System.currentLoad > 70%
```

**Action**:
```
SET Order.queuePriority = 'HIGH'
SET Order.maxWaitTime = 30 seconds
```

**Exception**: Does not apply to orders flagged for fraud review (BR-012 takes precedence).

**Conflicts With**: BR-005 (Standard Queue) - this rule takes precedence.

**Applied In Features**: F-001 (Authentication), F-004 (Order Processing)
```

**Improvements in v3.1:**
- Single source of truth for each rule
- BR-ID enables cross-referencing from features
- Explicit conditions and actions (pseudocode)
- Conflict resolution documented
- Traceability to features that use this rule

---

## Example 3: Acceptance Criteria

### BEFORE (v1 Style)

```markdown
### Password Reset

**Acceptance Criteria:**
- User can request password reset
- Email is sent with reset link
- Link expires after some time
- User can set new password
- Old password no longer works
```

**Problems with v1:**
- "Some time" is not testable
- No error scenarios
- No edge cases
- Cannot be converted to test cases directly

---

### AFTER (v3.1 Style)

```markdown
### F-003: Password Reset

**Acceptance Criteria (GWT Format):**

| AC ID | Given | When | Then |
|-------|-------|------|------|
| AC-003-01 | A registered user with email "user@example.com" | They request a password reset | An email with reset link is sent within 60 seconds |
| AC-003-02 | A valid reset link (less than 24 hours old) | User clicks the link | They are directed to the password reset form |
| AC-003-03 | An expired reset link (more than 24 hours old) | User clicks the link | They see "This link has expired" and option to request new link |
| AC-003-04 | A reset link that has already been used | User clicks the link | They see "This link has already been used" message |
| AC-003-05 | User on reset form with valid new password | They submit the form | Password is updated AND confirmation email sent AND old password invalidated AND all existing sessions terminated |
| AC-003-06 | User enters password that doesn't meet requirements | They submit the form | They see specific validation errors (min 8 chars, 1 uppercase, 1 number) |
| AC-003-07 | Email address not in system | They request reset | They see same "Check your email" message (prevents email enumeration) |

**Related Business Rules**: BR-015 (Password Complexity), BR-016 (Session Invalidation)
```

**Improvements in v3.1:**
- Each criterion has unique ID for test mapping
- GWT format is directly convertible to test cases
- Specific times and values (60 seconds, 24 hours, 8 chars)
- Happy path AND error scenarios covered
- Security consideration included (AC-003-07 prevents enumeration)
- Cross-reference to related business rules

---

## Example 4: Data Model

### BEFORE (v1 Style)

```markdown
## Features and Requirements

### User Management

Users have profiles with their name, email, and account settings. Users
can belong to organizations. Each organization has multiple users and
projects. Projects contain tasks assigned to users.
```

**Problems with v1:**
- Relationships implied but not explicit
- Cardinality unclear (many-to-many? one-to-many?)
- No attribute specifications
- Developers must infer structure

---

### AFTER (v3.1 Style)

```markdown
## Section 2.2: Conceptual Data Model

### Entity Overview

```
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

### Entity Definitions

| Entity | Description | Key Attributes | Relationships | Lifecycle States |
|--------|-------------|----------------|---------------|------------------|
| User | Platform user account | id, email (unique), name, tier | Has one Profile, Has many Projects | active→suspended→deleted |
| Profile | User settings and preferences | id, userId, settings, avatarUrl | Belongs to User | created→updated |
| Project | Work container | id, ownerId, name, status | Belongs to User, Has many Tasks | draft→active→archived |
| Task | Work item | id, projectId, assigneeId, title, status | Belongs to Project | todo→in_progress→done |

### Entity Detail: User

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID | Yes | Unique, immutable | Primary identifier |
| email | String | Yes | Unique, valid email format | Login credential |
| name | String | Yes | 1-100 characters | Display name |
| tier | Enum | Yes | Free/Premium/Enterprise | Subscription level |
| created_at | Timestamp | Yes | Auto-generated | Account creation |
| updated_at | Timestamp | Yes | Auto-updated | Last modification |
```

**Improvements in v3.1:**
- Visual ERD shows relationships at a glance
- Cardinality explicit (1:N, 1:1)
- Key attributes listed with types
- Lifecycle states documented
- Constraints (unique, format) specified
- Developers can derive schema directly

---

## Example 5: Non-Functional Requirements

### BEFORE (v1 Style)

```markdown
## Technical Considerations

### Performance
- The system should be fast
- Pages should load quickly
- The system should handle many users

### Security
- The system should be secure
- User data should be protected
- Passwords should be encrypted
```

**Problems with v1:**
- "Fast" and "quickly" are not measurable
- "Many users" has no number
- "Secure" has no specific requirements
- Cannot be tested or verified

---

### AFTER (v3.1 Style)

```markdown
## Section 6.2: Performance Requirements

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| Page Load (LCP) | < 2.5s | Lighthouse |
| Time to Interactive | < 3.5s | Lighthouse |
| API Response (p50) | < 200ms | APM |
| API Response (p99) | < 1000ms | APM |
| Concurrent Users | 10,000 users | Load testing |

## Section 6.3: Security Requirements

| Requirement | Implementation | Priority |
|-------------|----------------|----------|
| Authentication | JWT with 24h expiry | P0 |
| Password Storage | bcrypt with cost factor 12 | P0 |
| Data Encryption | AES-256 at rest, TLS 1.3 in transit | P0 |
| Rate Limiting | 100 requests/minute per user | P1 |
| Session Timeout | 30 min inactive, 24h absolute | P1 |
```

**Improvements in v3.1:**
- Specific measurable targets (2.5s, 200ms, 10,000 users)
- Measurement method defined
- Testable during development and operations
- Can be directly converted to monitoring alerts
- Priority levels for implementation order

---

## Transformation Summary

| Aspect | v1 Problem | v3.1 Solution |
|--------|------------|---------------|
| **Traceability** | No IDs, can't track | F-ID, BR-ID, AC-ID, T-ID |
| **Testability** | Vague criteria | GWT format with specific values |
| **Developer Clarity** | Implied data model | Explicit ERD with constraints |
| **Rule Management** | Scattered in prose | Centralized inventory with conflict resolution |
| **Measurability** | "Fast", "secure" | "< 200ms", "bcrypt cost 12" |
| **Completeness** | Happy path only | Error scenarios, edge cases |
| **Handoff Quality** | No validation | Handoff Readiness Checklist |

---

## Quick Conversion Checklist

When transforming v1 content to v3.1:

### Features
- [ ] Assign F-ID (F-001, F-002, etc.)
- [ ] Classify type (CRUD/AUTH/INTEGRATION/etc.)
- [ ] List touched entities explicitly
- [ ] Convert acceptance criteria to GWT table
- [ ] Add specific numbers to all criteria
- [ ] Include error/edge case scenarios

### Business Rules
- [ ] Extract from prose into dedicated section
- [ ] Assign BR-ID (BR-001, BR-002, etc.)
- [ ] Write as IF/THEN pseudocode
- [ ] Document conflicts and precedence
- [ ] Cross-reference to related features

### Data Model
- [ ] Draw entity relationship diagram
- [ ] Specify cardinality (1:1, 1:N, M:N)
- [ ] Define attributes with types
- [ ] Document lifecycle states
- [ ] Note constraints and validation rules

### NFRs
- [ ] Replace vague words with numbers
- [ ] Define measurement method
- [ ] Ensure testability
- [ ] Set priority levels

---

*Document created as part of PRD Process Improvement Initiative - Phase 1*
