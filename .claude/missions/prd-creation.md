# Mission: Product Requirements Document (PRD) Creation

**Mission Type:** Foundation Document Creation
**Duration:** 60-120 minutes
**Output:** `/documents/foundation/prds/[product-name]-prd.md`

---

## Mission Objective

Create a comprehensive Product Requirements Document that defines what to build, for whom, and why—providing clear requirements for technical implementation via AGENT-11.

## Required Agents

- `solution-design` (primary) - Product architecture and requirements
- `client-success-intelligence` (support) - Customer needs alignment
- `strategic-opportunity` (support) - Strategic prioritization

---

## Reference Documents

**Before starting this mission, read these reference documents:**

| Document | Purpose | Location |
|----------|---------|----------|
| **PRD SOP** | Process methodology and structure | `/docs/Document Library/Foundation/Product Requirements Document (PRD) Creation SOP.md` |
| **PRD Template** | Output document structure | `/docs/Document Library/Foundation/Product Requirements Document (PRD).md` |

**Key Sections from SOP:**
- Problem Statement & Validation
- User Personas & Stories
- Feature Prioritization (P0/P1/P2)
- Acceptance Criteria Definition
- Technical Considerations
- Success Metrics & Timeline

**Note:** The PRD is the handoff document to AGENT-11 for technical implementation.

---

## PHASE 0: MODE SELECTION

**Before proceeding, ask the user:**

> **How would you like to create your PRD?**
>
> | Mode | Description | Time |
> |------|-------------|------|
> | **Auto** | I'll create the complete PRD based on your inputs. You review and refine at the end. | 30-45 min |
> | **Engaged** | We work section by section. I draft, present perspectives, you approve before moving on. | 60-90 min |
>
> Which mode works for you today?

**Wait for user response before proceeding.**

---

## PHASE 1: CONTEXT GATHERING

Gather essential context:

1. **Read provided context files** (vision-mission, market research, client blueprint, positioning, roadmap)
2. **Ask clarifying questions:**
   - What product/feature are we defining?
   - Is this MVP or a later phase?
   - What's the target launch date?
   - Any technical constraints to consider?
   - What does success look like?

---

## AUTO MODE EXECUTION

If user selected **Auto**:

### Step 1: Generate Complete Document

```markdown
# [Product Name] - Product Requirements Document

**Version:** 1.0
**Date:** [Date]
**Author:** [Author]
**Status:** Draft / Ready for Review / Approved

---

## Executive Summary

[2-3 paragraph overview of the product, its purpose, and key value proposition]

---

## Problem Statement

### The Problem
[Clear description of the problem being solved]

### Who Has This Problem
[Target users from Client Blueprint]

### Current Solutions & Gaps
| Current Solution | Gap/Limitation |
|------------------|----------------|
| [Solution 1] | [What's missing] |
| [Solution 2] | [What's missing] |

### Why Now
[Market timing and urgency]

---

## Solution Overview

### Product Vision
[How this product fits the broader vision]

### Value Proposition
[Primary value delivered - from Positioning]

### Key Differentiators
1. [Differentiator 1]
2. [Differentiator 2]
3. [Differentiator 3]

---

## Target Users

### Primary Persona
**Name:** [Persona name]
**Role:** [Job title/description]
**Goals:** [What they want to achieve]
**Pain Points:** [What frustrates them]

### Secondary Persona
[Same structure]

### User Stories
| As a... | I want to... | So that... | Priority |
|---------|--------------|------------|----------|
| [User type] | [Action] | [Benefit] | P0/P1/P2 |

---

## Features & Requirements

### Feature Priority Matrix
| Priority | Feature | Description | User Story |
|----------|---------|-------------|------------|
| **P0** | [Feature] | [Description] | [Link to story] |
| **P1** | [Feature] | [Description] | [Link to story] |
| **P2** | [Feature] | [Description] | [Link to story] |

### P0 Features (Must Have for MVP)

#### Feature: [Feature Name]
**Description:** [What it does]
**User Story:** As a [user], I want to [action] so that [benefit]
**Acceptance Criteria:**
- [ ] [Criteria 1]
- [ ] [Criteria 2]
- [ ] [Criteria 3]
**Technical Notes:** [Any technical considerations]

[Repeat for each P0 feature]

### P1 Features (Should Have)
[Same structure, less detail]

### P2 Features (Nice to Have)
[Same structure, less detail]

---

## User Experience

### User Flows
**Primary Flow: [Flow Name]**
1. User [action]
2. System [response]
3. User [action]
4. [Continue flow]

### Key Screens/Views
| Screen | Purpose | Key Elements |
|--------|---------|--------------|
| [Screen 1] | [Purpose] | [Elements] |

### UX Requirements
- [Requirement 1]
- [Requirement 2]

---

## Technical Considerations

### Platform/Technology Preferences
- Frontend: [Preference if any]
- Backend: [Preference if any]
- Database: [Preference if any]
- Hosting: [Preference if any]

### Integration Requirements
| System | Integration Type | Priority |
|--------|------------------|----------|
| [System] | [Type] | [P0/P1/P2] |

### Performance Requirements
- Page load: [Target]
- API response: [Target]
- Uptime: [Target]

### Security Requirements
- [Requirement 1]
- [Requirement 2]

### Scalability Considerations
[Expected scale and growth]

---

## Success Metrics

### North Star Metric
[Primary metric that indicates product success]

### Key Performance Indicators
| Metric | Definition | Target | Measurement |
|--------|------------|--------|-------------|
| [Metric 1] | [Definition] | [Target] | [How measured] |
| [Metric 2] | [Definition] | [Target] | [How measured] |

### Validation Hypotheses
| Hypothesis | How to Test | Success Criteria |
|------------|-------------|------------------|
| [Hypothesis 1] | [Test method] | [What proves it] |

---

## Timeline & Milestones

### Target Timeline
| Milestone | Target Date | Deliverable |
|-----------|-------------|-------------|
| Development Start | [Date] | [What's ready] |
| Alpha | [Date] | [What's delivered] |
| Beta | [Date] | [What's delivered] |
| Launch | [Date] | [What's delivered] |

### Dependencies
| Dependency | Owner | Due Date | Impact if Delayed |
|------------|-------|----------|-------------------|
| [Dependency] | [Who] | [When] | [Impact] |

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | H/M/L | H/M/L | [Strategy] |
| [Risk 2] | H/M/L | H/M/L | [Strategy] |

---

## Out of Scope

Explicitly NOT included in this version:
- [Item 1] - [Why out of scope]
- [Item 2] - [Why out of scope]

---

## Open Questions

| Question | Owner | Due Date | Status |
|----------|-------|----------|--------|
| [Question 1] | [Who] | [When] | Open/Resolved |

---

## Appendix

### Glossary
| Term | Definition |
|------|------------|
| [Term] | [Definition] |

### References
- [Reference 1]
- [Reference 2]

---

## Approval

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Product | | | |
| Engineering | | | |
| Design | | | |
```

### Step 2: Present for Review

Show complete document and iterate until approved.

### Step 3: Save Document

Save to `/documents/foundation/prds/[product-name]-prd.md`

---

## ENGAGED MODE EXECUTION

If user selected **Engaged**:

### Section 1: Problem & Solution

**Draft problem/solution**, then present:

> **Problem Statement:**
> [The problem being solved]
>
> **Who Has This Problem:**
> [Target users]
>
> **Solution Overview:**
> [How we solve it]
>
> **Key Differentiators:**
> 1. [Differentiator 1]
> 2. [Differentiator 2]
>
> ---
>
> **Different Perspectives:**
>
> **Customer lens:** [Is this a real, painful problem?]
>
> **Market lens:** [Is the solution differentiated enough?]
>
> **Feasibility lens:** [Can we actually build this?]
>
> ---
>
> **Your thoughts?** Is the problem/solution framing right?

**Wait for approval before proceeding.**

---

### Section 2: Target Users & Stories

**Draft user definition**, then present:

> **Primary Persona:**
> - Name: [Persona]
> - Role: [Description]
> - Goals: [What they want]
> - Pain Points: [What frustrates them]
>
> **Key User Stories:**
> | As a... | I want to... | So that... |
> |---------|--------------|------------|
> | [User] | [Action] | [Benefit] |
> | [User] | [Action] | [Benefit] |
>
> ---
>
> **Different Perspectives:**
>
> **Empathy lens:** [Do we truly understand this user?]
>
> **Prioritization lens:** [Are we solving the most important stories?]
>
> **Validation lens:** [Have we talked to real users?]
>
> ---
>
> **Your thoughts?** Does this capture your target user?

**Wait for approval before proceeding.**

---

### Section 3: Features & Prioritization

**Draft feature matrix**, then present:

> **P0 Features (Must Have):**
> 1. [Feature] - [Description]
> 2. [Feature] - [Description]
> 3. [Feature] - [Description]
>
> **P1 Features (Should Have):**
> 1. [Feature] - [Description]
>
> **P2 Features (Nice to Have):**
> 1. [Feature] - [Description]
>
> ---
>
> **Different Perspectives:**
>
> **MVP lens:** [Is P0 truly minimal?]
>
> **Value lens:** [Do P0 features deliver core value?]
>
> **Effort lens:** [Is this achievable in timeline?]
>
> ---
>
> **Your thoughts?** Is the prioritization right?

**Wait for approval before proceeding.**

---

### Section 4: Success Metrics & Timeline

**Draft success framework**, then present:

> **North Star Metric:**
> [Primary success metric]
>
> **Key KPIs:**
> | Metric | Target |
> |--------|--------|
> | [Metric 1] | [Target] |
> | [Metric 2] | [Target] |
>
> **Timeline:**
> | Milestone | Date |
> |-----------|------|
> | Dev Start | [Date] |
> | Alpha | [Date] |
> | Launch | [Date] |
>
> ---
>
> **Different Perspectives:**
>
> **Measurement lens:** [Can we actually track these metrics?]
>
> **Ambition lens:** [Are targets achievable but stretching?]
>
> **Reality lens:** [Is the timeline realistic?]
>
> ---
>
> **Your thoughts?** Are metrics and timeline right?

**Wait for approval.**

---

### Final Assembly

Compile all approved sections into complete PRD.

> **Complete PRD ready.**
>
> This document will be the input to AGENT-11 for technical implementation.
>
> Save location: `/documents/foundation/prds/[product-name]-prd.md`
>
> **Any final adjustments?**

Save to specified location.

---

## Success Criteria

- [ ] Problem statement clear and validated
- [ ] Target users defined with personas
- [ ] User stories written with priorities
- [ ] Features prioritized (P0/P1/P2)
- [ ] P0 features have acceptance criteria
- [ ] Success metrics defined and measurable
- [ ] Timeline with milestones
- [ ] Risks identified with mitigations
- [ ] Out of scope clearly stated
- [ ] Document ready for AGENT-11 handoff

---

## Post-Mission: AGENT-11 Handoff

After PRD approval:
1. PRD saved to `/documents/foundation/prds/`
2. Ready to copy to AGENT-11 project
3. Use `/coord dev-setup` in AGENT-11 to begin implementation

---
*PRD Creation Mission | Foundation Document | BOS-AI*
