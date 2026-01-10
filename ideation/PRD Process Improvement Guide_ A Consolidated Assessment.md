# PRD Process Improvement Guide: A Consolidated Assessment

**Date:** January 9, 2026
**Author:** Manus AI
**Version:** 2.1

---

## 1. Executive Summary

This document presents a final, refined set of recommendations to significantly improve the Product Requirements Document (PRD) creation process within the BOS-AI framework. This version (2.1) incorporates two full rounds of feedback from six leading LLMs, resulting in a highly robust and agent-native framework for producing PRDs that can be autonomously executed by a developer agent like AGENT-11.

The core diagnosis remains unchanged: the original process excelled at defining the product's **"Soul"** (strategy) but failed to define its **"Skeleton"** (structure). This guide solidifies the shift to a "structure-first" approach.

**Key Artifacts in this Guide:**

1.  **The Refined PRD Template (v3.1):** A lean, machine-parsable template that now includes a UI sitemap, data privacy section, testing requirements, and explicit traceability between features and the data model.
2.  **The Refined SOP (v2.1):** A streamlined, single-session workflow that now includes explicit guidance for `Auto` mode, incremental updates, and handling of missing prerequisites.
3.  **The Design Playbook Template:** A new, optional document for capturing non-binding technical preferences, keeping the PRD pure while still allowing for architectural influence.

By adopting this comprehensive framework, the PRD creation process will become more efficient, consistent, and will produce documents that dramatically reduce ambiguity, minimize implementation drift, and provide the developer agent with the precise, buildable blueprint it needs to succeed.

---

## 2. Diagnosis: The Gap Between Strategy and Structure

*(This section remains unchanged from the previous version, as the diagnosis was universally validated.)*

The initial analysis and the collective feedback from all six LLMs converged on a single, critical diagnosis: the current process is excellent at defining the **"Soul"** of the product (the vision, the mission, the *why*) but fails to define its **"Skeleton"** (the entities, the rules, the relationships, the *what*).

This creates an "Agent Gap" where the developer agent is forced to infer critical structural information from prose user stories, leading to a high risk of misalignment and rework.

---

## 3. The Solution: A Refined Framework for Agent-Ready PRDs

*(This section is updated to reflect the final, refined principles.)*

The solution is a comprehensive framework purpose-built for a developer agent. This framework is built on the following principles:

1.  **Concise & Structured:** Be brief but dense with actionable, machine-parsable information.
2.  **Structure-First:** Define the "Skeleton" (Data Model, UI Structure, Business Rules, State Machines, Privacy) before detailing features.
3.  **Strict Boundaries:** The PRD defines **WHAT** and **WHY**. A separate, optional **Design Playbook** can hint at **HOW**.
4.  **Quantified Constraints:** All non-functional requirements must be specific and measurable.
5.  **Traceability:** Use unique IDs for features and explicit `Touched Entities` fields to enable clear traceability from requirement to code to test.
6.  **Iterative & Ergonomic:** The process supports both one-shot creation and safe, incremental updates.

This guide provides the complete, updated artifacts in the following sections.


---

## 4. The Refined PRD Template (v3.1)

*This template incorporates feedback from all LLMs, adding sections for UI Structure, Data Privacy, and Testing, while strengthening traceability and boundary enforcement.*

```markdown
# Product Requirements Document (PRD) - v3.1

**Product Name:** [Enter product name]
**Date:** [Creation date]
**Version:** 1.0
**Status:** [Draft/Review/Approved]

---

### 0. PRD At-a-Glance

*This section is a mandatory, high-level summary. It serves as a quick reference and anchor for the developer agent.*

| Category | Detail |
| :--- | :--- |
| **Product in 1 Sentence** | [A concise, one-sentence pitch for the product.] |
| **Target User & Job-to-be-Done** | [Who is the primary user and what core job are they hiring this product to do?] |
| **MVP Scope** | - [Bulleted list of the 3-5 core features/capabilities of the MVP.] |
| **Explicit Non-Goals (MVP)** | - [Bulleted list of what is explicitly out of scope for the MVP.] |
| **Key Integrations** | [List of required external services (e.g., Stripe, Gmail, AWS S3).] |
| **Key Business Constraints** | [Budget, timeline, compliance (e.g., GDPR, HIPAA), or other non-negotiable business constraints.] |
| **North Star Metric** | [The single most important metric that defines the success of this product.] |
| **Open Questions** | - [Bulleted list of any open questions, tagged as **[BLOCKING]** or **[NON-BLOCKING]**.] |

---

### 1. Context and Strategy

- **Scope of this Document:** This PRD defines the **WHAT** and **WHY**. It does **not** define the **HOW**. The developer agent is responsible for all implementation decisions.
  - **Banned Content:** This PRD must NOT contain framework/library selections, DB/hosting choices, or specific security mechanism choices (e.g., HMAC, RLS).
- **Problem Statement:** [A brief (1-2 paragraph) description of the core user problem.]
- **Solution Vision:** [A brief (1-2 paragraph) description of how this product solves the problem.]
- **Supplemental Documents:**
  - Vision & Mission: `[Link to document]`
  - Client Success Blueprint (ICP): `[Link to document]`

---

### 2. The System Skeleton: Structural Requirements

#### 2.1 Glossary / Key Definitions

| Term | Definition |
| :--- | :--- |
| `Workspace` | A container for a single user's projects and data. |
| `Project` | A single, user-created initiative within a Workspace. |

#### 2.2 Conceptual Data Model

**Core Entities:**

| Entity | Purpose | Key Attributes (Business Level) | Relationships | Data Lifecycle |
| :--- | :--- | :--- | :--- | :--- |
| `User` | The human operator. | `user_id`, `email`, `name` | Has many `Workspaces` | Created on signup; archived on request. |

**Identity Resolution Rules:**
- **Primary Identifier:** [e.g., email]
- **Matching Rules:** [How duplicates are detected]
- **Merge Behavior:** [What happens when duplicates are found]

#### 2.3 User Interface Structure (Sitemap)

| Route / Page | Access Level | Key Data Displayed | Primary Action |
| :--- | :--- | :--- | :--- |
| `/dashboard` | User | `ProjectList`, `UsageStats` | Create New Project |
| `/settings/billing` | Admin | `SubscriptionStatus`, `Invoices` | Update Payment Method |

#### 2.4 Business Rules & State Machines

**Global Business Rules:**

| Rule ID | Condition | Action | Constraints |
| :--- | :--- | :--- | :--- |
| `GR-01` | When a user's trial period ends | Then their account is converted to the 'Free' tier | Unless they have an active payment method. |

**State Machines:**

- **Workflow:** `Subscription Status`
- **States:** `[trialing, active, past_due, canceled, expired]`
- **Transitions:**

| Trigger | From State | To State | Side Effects |
| :--- | :--- | :--- | :--- |
| `user_adds_payment` | `trialing` | `active` | Send welcome email. |
| `payment_fails` | `active` | `past_due` | Send dunning email. |

#### 2.5 External API Dependencies

| Service | Purpose | Data In/Out | Rate Limits (Business Impact) | Freshness Requirement |
| :--- | :--- | :--- | :--- | :--- |
| `Stripe` | Payment Processing | `Customer`, `Subscription` | 100 req/sec (cost) | Real-time via webhook |

#### 2.6 Data Privacy & Compliance

**Data Classification:**

| Data Type | Sensitivity | Retention Period | Encryption Required |
| :--- | :--- | :--- | :--- |
| Customer PII | High | As long as active | At rest & in transit |

**Compliance Requirements:**
- [ ] GDPR compliance (EU customers)
- [ ] Data export/delete functionality

---

### 3. Features & Requirements (MVP)

*This section defines the P0 (Must-Have) features for the MVP. A suggested build order should be provided.*

**Implementation Phasing / Build Order:**
1.  `F-001` (User Auth)
2.  `F-002` (Stripe Integration)
3.  `F-003` (Dashboard)

#### Feature: [Feature Name]

- **Feature ID:** `F-001`
- **Type:** `[CRUD | Workflow | Analytics | Integration | Automation]`
- **Priority:** `P0`
- **Dependencies:** `[None]`
- **Touched Entities:** `[User, Workspace]`

- **User Stories:**
  - As a [user type], I want to [action] so that [benefit].

- **Acceptance Criteria (GWT Format):**
  - *Note: These scenarios are intended to be the basis for automated tests.*
  - **AC-1:** **Given** a user is on the login page, **When** they enter valid credentials, **Then** they are redirected to the dashboard.

- **Error Handling & Edge Cases:**
  - **Scenario:** User enters incorrect password.
  - **Expected Behavior:** Display "Invalid credentials" error message.

_[Repeat for all P0 features]_

---

### 4. Testing & Launch Requirements

**Critical Test Scenarios:**

| ID | Feature | Given | When | Then |
| :--- | :--- | :--- | :--- | :--- |
| `T-01` | `F-001` | A new user visits the signup page | They complete the form | An account is created and they are logged in. |

**Launch Checklist:**
- [ ] All P0 features pass acceptance criteria.
- [ ] External API integrations are verified in a production environment.

**Rollback Criteria:**
- If user authentication fails for >5% of users in the first hour.

---

### 5. Post-MVP Roadmap

- **P1 - Fast Follow:** [Features to be implemented shortly after initial launch.]
- **P2 - Future Enhancements:** [Longer-term ideas for the product.]

---

### 6. Success Metrics & Kill Criteria

| Metric | Target | Rationale |
| :--- | :--- | :--- |
| **User Activation Rate** | > 30% within 7 days | Measures if users are reaching the "aha!" moment. |

**Kill Criteria:**
- If after 3 months, the product has fewer than 100 active users.

---

### 7. Handoff Readiness Checklist

- [ ] Every entity in the Data Model has defined attributes and relationships.
- [ ] Every P0 feature has testable acceptance criteria (Given/When/Then).
- [ ] Every external API has rate limits and freshness specified.
- [ ] All complex workflows have a defined State Machine.
- [ ] Zero `[BLOCKING]` open questions remain.

---

### Appendix A: Assumptions & Preference Profile

*This section captures the high-level preferences for the project, either from the SOP discovery questions or the Solopreneur Defaults.*

```json
{
  "timeline_bias": "speed",
  "budget_band": "bootstrap",
  "operational_simplicity": "high",
  "risk_tolerance": "medium",
  "data_sensitivity": "low",
  "nfr_defaults": {
    "response_p95_ms": 1500,
    "availability_target_percent": 99.5,
    "max_data_loss_minutes": 15
  }
}
```

### Appendix B: Before/After Example

*This section illustrates the value of the new template.*

**Before (from `solocmd-mvp-prd.md`):**
> "The core of the product is a unified customer profile that aggregates data from multiple Stripe accounts..."

**After (in the new v3.1 template):**

**Conceptual Data Model:**

| Entity | Purpose | Key Attributes | Relationships |
| :--- | :--- | :--- | :--- |
| `Customer` | Represents a unique person. | `customer_id`, `email`, `name` | Has many `StripeAccounts` |
| `StripeAccount` | A linked Stripe account. | `stripe_id`, `account_name` | Belongs to a `Customer` |

**Identity Resolution Rules:**
- **Primary Identifier:** `email`
- **Matching Rules:** A `Customer` is created for each unique email. Subsequent Stripe accounts with the same email are linked to the existing `Customer`.

```


---

## 5. The Refined SOP (v2.1)

*This SOP is updated to include guidance for Auto mode, incremental updates, and handling missing prerequisites.*

```markdown
# Product Requirements Document (PRD) Creation SOP - v2.1

**Version:** 2.1
**Purpose:** To guide the creation of a concise, structured, and machine-parsable PRD using the BOS-AI `/coord prd-creation` command.

---

### Overview

This SOP outlines a flexible, section-by-section process for creating a PRD that is optimized for handoff to a developer agent. It supports both a single-session `Engaged` mode for collaborative creation and an `Auto` mode for rapid drafting.

---

### Prerequisites

Before starting, ensure the following foundation documents are available. If any are missing, the agent will prompt for key excerpts during the process.

- Vision & Mission
- Client Success Blueprint (ICP)

---

### The Process

#### Step 1: Initiate the Mission

Run the command: `/coord prd-creation`

#### Step 2: Mode Selection & Context Gathering

- **Select Mode:** Choose `Engaged` for a collaborative walkthrough or `Auto` for a one-shot draft.
- **Context Gathering:** The agent will ask a series of discovery questions. Unanswered questions will be filled using the **Standard Solopreneur Defaults**.

#### Step 3: The Core Loop

**In `Engaged` Mode:**
1.  **Agent Drafts:** The agent presents a draft of a single section.
2.  **User Reviews & Approves:** You review, provide feedback, and approve the section before the agent proceeds.

**In `Auto` Mode:**
1.  **Agent Drafts:** The agent generates the complete PRD in one pass.
2.  **Agent Flags:** The agent lists all assumptions made and flags any missing information in the "Open Questions" section.
3.  **User Reviews:** A full manual review is required before handoff.

#### Step 4: Incremental Updates (Optional)

For existing PRDs, you can use the `/coord prd-creation` command with an `update` flag:

- `/coord prd-creation --update-skeleton`: Regenerates only the System Skeleton sections.
- `/coord prd-creation --update-features`: Regenerates only the Features section.

**Update Rule:** The agent will never overwrite user-edited sections. It will propose a diff or a new subsection for review.

#### Step 5: Post-PRD Validation (Recommended)

Before handoff, run a final comprehension check by prompting a developer agent with the **Handoff Readiness Checklist** from the PRD template and asking it to confirm that all items are clear and actionable.

---

### Appendix A: Standard Solopreneur Defaults

*(This appendix remains unchanged from the previous version.)*

---

### Appendix B: The Design Playbook Concept

*(This appendix remains unchanged from the previous version.)*

```

---

## 6. The Design Playbook Template

*This is a new, optional artifact for capturing non-binding technical preferences and architectural hints.*

```markdown
# Design Playbook: [Product Name]

**Version:** 1.0
**Purpose:** To provide non-binding technical preferences and architectural suggestions to the developer agent. This document is the **HOW** and is subordinate to the PRD (the **WHAT** and **WHY**).

---

### 1. Technical Preferences (Non-binding)

- **Database:** Preference for PostgreSQL with RLS for multi-tenancy.
- **Authentication:** Preference for JWT with short-lived access tokens and long-lived refresh tokens.
- **Deployment:** Preference for serverless infrastructure (e.g., Vercel, AWS Lambda).

---

### 2. Architecture Patterns

- **Multi-Tenancy:** For the business requirement "Data for one workspace must never be visible to another," consider using Row-Level Security (RLS) in the database.
- **Error Handling:** For external API failures, consider a queue-based retry mechanism with exponential backoff.

---

### 3. Integration Preferences

- **Stripe:** Use the official `stripe-node` library.
- **Authentication:** For the business requirement "User can log in with Google," the preferred access pattern is OAuth 2.0.

---

### 4. Security Baseline

- **Data Encryption:** All data at rest must be encrypted with AES-256.
- **Data Retention:** Customer PII should be deleted 90 days after account closure.

```


---

## 7. LLM Contribution Summary

*(This section remains unchanged from the previous version.)*

---

## 8. Implementation Roadmap

*(This section is updated to include a controlled migration path and success criteria.)*

1.  **Phase 0: Controlled Migration (New)**
    - **Action:** Adopt the v3.1 template for *new projects only*. Keep the v1 template for in-flight work.
    - **Success Criterion:** Run 2-3 new projects through the v3.1 process and compare the developer agent clarification count against v1 projects. Target a >50% reduction in clarification questions.

2.  **Phase 1: Update BOS-AI Mission File**
    - **Action:** Update the `prd-creation.md` mission file in the BOS-AI repository to reference and use the new v3.1 template and v2.1 SOP.
    - **Success Criterion:** The mission file successfully generates a PRD that adheres to the v3.1 structure.

3.  **Phase 2: Full Adoption & Deprecation**
    - **Action:** Once Phase 0 is validated, deprecate the old template and SOP and make the new framework the default for all PRD creation.
    - **Success Criterion:** All new PRDs are created using the v3.1 framework.

---

## 9. Conclusion

*(This section remains unchanged from the previous version.)*

This guide represents a significant evolution of the PRD creation process, driven by a deep analysis and a comprehensive, multi-LLM review cycle. The resulting framework is more robust, more efficient, and fundamentally aligned with the needs of an autonomous developer agent.

By implementing these changes, you will be able to produce PRDs that are not just documents, but true, buildable blueprints for your products.
