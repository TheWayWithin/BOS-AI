# Mission: Strategic Roadmap Creation

**Mission Type:** Foundation Document Creation
**Duration:** 45-75 minutes
**Output:** `/documents/foundation/strategic-roadmap.md`

---

## Mission Objective

Create a strategic roadmap that maps the product/service development sequence, defines MVP and evolution path, and establishes success milestones.

## Required Agents

- `strategic-opportunity` (primary) - Strategic planning
- `solution-design` (support) - Product development sequence
- `scaling-strategy` (support) - Growth path planning

---

## Reference Documents

**Before starting this mission, read these reference documents:**

| Document | Purpose | Location |
|----------|---------|----------|
| **Roadmap SOP** | Process methodology and AI prompts | `/docs/Document Library/Foundation/Strategic Roadmap Creation SOP (AI-Driven).md` |
| **Roadmap Template** | Output document structure | `/docs/Document Library/Foundation/Strategic Roadmap_ Vision to Great.md` |

**Key Frameworks from SOP:**
- Vision to Execution Bridge (10-Year → 3-Year → 1-Year)
- Product Evolution Phases (MVP → Growth → Scale)
- Milestone Definition & Success Criteria
- Risk Assessment & Mitigation Planning
- Resource Allocation Framework

---

## PHASE 0: MODE SELECTION

**Before proceeding, ask the user:**

> **How would you like to create your Strategic Roadmap?**
>
> | Mode | Description | Time |
> |------|-------------|------|
> | **Auto** | I'll create the complete roadmap based on your inputs. You review and refine at the end. | 20-30 min |
> | **Engaged** | We work section by section. I draft, present perspectives, you approve before moving on. | 45-60 min |
>
> Which mode works for you today?

**Wait for user response before proceeding.**

---

## PHASE 1: CONTEXT GATHERING

Gather essential context:

1. **Read provided context files** (PRD, vision-mission, market research, positioning)
2. **Ask clarifying questions:**
   - What's your launch timeline target?
   - What resources do you have (solo, team, budget)?
   - What's the MVP vs. full vision?
   - Any hard deadlines or dependencies?

---

## AUTO MODE EXECUTION

If user selected **Auto**:

### Step 1: Generate Complete Document

```markdown
# Strategic Roadmap

## Executive Summary
[2-3 sentences on the overall product/business evolution strategy]

## Vision to Execution Bridge

### 10-Year Vision
[From vision-mission document]

### 3-Year Strategic Goals
1. [Goal 1] - [Key Result]
2. [Goal 2] - [Key Result]
3. [Goal 3] - [Key Result]

### 1-Year Objectives
1. [Objective 1] - [Measurable outcome]
2. [Objective 2] - [Measurable outcome]
3. [Objective 3] - [Measurable outcome]

## Product Evolution Path

### Phase 1: MVP (Months 1-3)
**Theme:** [Core value delivery]

**Scope:**
- [Feature/capability 1]
- [Feature/capability 2]
- [Feature/capability 3]

**Success Criteria:**
- [Metric 1]: [Target]
- [Metric 2]: [Target]

**Resources Required:**
- [Resource 1]
- [Resource 2]

### Phase 2: Growth (Months 4-6)
**Theme:** [Expansion focus]

**Scope:**
- [Feature/capability 1]
- [Feature/capability 2]
- [Feature/capability 3]

**Success Criteria:**
- [Metric 1]: [Target]
- [Metric 2]: [Target]

### Phase 3: Scale (Months 7-12)
**Theme:** [Scaling focus]

**Scope:**
- [Feature/capability 1]
- [Feature/capability 2]
- [Feature/capability 3]

**Success Criteria:**
- [Metric 1]: [Target]
- [Metric 2]: [Target]

## Milestone Timeline

| Milestone | Target Date | Success Criteria | Dependencies |
|-----------|-------------|------------------|--------------|
| MVP Launch | [Date] | [Criteria] | [Dependencies] |
| First Paying Customer | [Date] | [Criteria] | [Dependencies] |
| Product-Market Fit | [Date] | [Criteria] | [Dependencies] |
| Scale Trigger | [Date] | [Criteria] | [Dependencies] |

## Resource Allocation

### Phase 1 Resources
- Development: [X%]
- Marketing: [X%]
- Operations: [X%]

### Key Hires/Needs
1. [Role/Resource] - [When needed]
2. [Role/Resource] - [When needed]

## Risk & Dependencies

### Key Risks
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | [H/M/L] | [H/M/L] | [Strategy] |
| [Risk 2] | [H/M/L] | [H/M/L] | [Strategy] |

### Critical Dependencies
1. [Dependency] - [Impact if delayed]
2. [Dependency] - [Impact if delayed]

## Decision Checkpoints

### Go/No-Go Gates
| Checkpoint | Date | Decision Criteria |
|------------|------|-------------------|
| MVP Go | [Date] | [What must be true] |
| Scale Go | [Date] | [What must be true] |

## Strategic Priorities

### What We're NOT Doing (Equally Important)
1. [Not doing 1] - [Why]
2. [Not doing 2] - [Why]
3. [Not doing 3] - [Why]
```

### Step 2: Present for Review

Show complete document and iterate until approved.

### Step 3: Save Document

Save to `/documents/foundation/strategic-roadmap.md`

---

## ENGAGED MODE EXECUTION

If user selected **Engaged**:

### Section 1: Vision to Execution Bridge

**Draft the bridge**, then present:

> **Vision to Execution Bridge:**
>
> **10-Year Vision:** [From vision doc]
>
> **3-Year Strategic Goals:**
> 1. [Goal 1] - [Key Result]
> 2. [Goal 2] - [Key Result]
> 3. [Goal 3] - [Key Result]
>
> **1-Year Objectives:**
> 1. [Objective 1]
> 2. [Objective 2]
> 3. [Objective 3]
>
> ---
>
> **Different Perspectives:**
>
> **Ambition lens:** [Are the 3-year goals ambitious enough?]
>
> **Reality lens:** [Are the 1-year objectives achievable?]
>
> **Alignment lens:** [Does this ladder up to the vision?]
>
> ---
>
> **Your thoughts?** Does this bridge feel right?

**Wait for approval before proceeding.**

---

### Section 2: Product Evolution Path

**Draft the phases**, then present:

> **Product Evolution:**
>
> **Phase 1: MVP (Months 1-3)**
> - Theme: [Core value focus]
> - Key capabilities: [List]
> - Success: [How we know it worked]
>
> **Phase 2: Growth (Months 4-6)**
> - Theme: [Expansion focus]
> - Key capabilities: [List]
> - Success: [How we know it worked]
>
> **Phase 3: Scale (Months 7-12)**
> - Theme: [Scaling focus]
> - Key capabilities: [List]
> - Success: [How we know it worked]
>
> ---
>
> **Different Perspectives:**
>
> **Lean lens:** [Is the MVP truly minimal?]
>
> **Customer lens:** [Does each phase deliver more value?]
>
> **Resource lens:** [Is this achievable with your resources?]
>
> ---
>
> **Your thoughts?** Does this evolution make sense?

**Wait for approval before proceeding.**

---

### Section 3: Milestones & Timeline

**Draft milestones**, then present:

> **Key Milestones:**
>
> | Milestone | Target | Success Criteria |
> |-----------|--------|------------------|
> | MVP Launch | [Date] | [What defines success] |
> | First Revenue | [Date] | [Target] |
> | Product-Market Fit | [Date] | [How we'll know] |
> | Scale Trigger | [Date] | [Threshold] |
>
> ---
>
> **Different Perspectives:**
>
> **Optimism lens:** [Best case timing]
>
> **Realism lens:** [Most likely timing]
>
> **Buffer lens:** [Have you added contingency?]
>
> ---
>
> **Your thoughts?** Are these milestones realistic?

**Wait for approval before proceeding.**

---

### Section 4: Risks & Priorities

**Draft risks and priorities**, then present:

> **Key Risks:**
>
> 1. **[Risk 1]** - Mitigation: [Strategy]
> 2. **[Risk 2]** - Mitigation: [Strategy]
> 3. **[Risk 3]** - Mitigation: [Strategy]
>
> **What We're NOT Doing:**
> 1. [Not doing 1] - Because [Why]
> 2. [Not doing 2] - Because [Why]
>
> ---
>
> **Different Perspectives:**
>
> **Paranoid lens:** [What else could go wrong?]
>
> **Focus lens:** [Are we saying no to enough things?]
>
> **Contingency lens:** [What's the backup plan?]
>
> ---
>
> **Your thoughts?** Any risks to add? Anything else to cut?

**Wait for approval.**

---

### Final Assembly

Compile all approved sections and save to `/documents/foundation/strategic-roadmap.md`

---

## Success Criteria

- [ ] Vision to execution bridge established
- [ ] Product evolution phases defined (MVP, Growth, Scale)
- [ ] Key milestones with dates and success criteria
- [ ] Resource allocation considered
- [ ] Risks identified with mitigations
- [ ] Strategic "not doing" list documented
- [ ] Document saved to correct location

---
*Strategic Roadmap Creation Mission | Foundation Document | BOS-AI*
