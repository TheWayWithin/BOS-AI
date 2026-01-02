# Dual-Mode Foundation Mission Template

## Overview

This template enables foundation document creation in two modes:
- **Auto** - Agent creates complete document, user reviews at end
- **Engaged** - Section-by-section collaboration with expert perspectives

---

## Mission Prompt Template: Vision & Mission

```markdown
# Foundation: Vision & Mission Creation

## Mission Start

First, read any provided context files (PRD, ideation docs, existing research).

Then ask the user:

---

**How would you like to create your Vision & Mission document?**

| Mode | Description | Time |
|------|-------------|------|
| **Auto** | I'll create the complete document based on your inputs. You review and refine at the end. | 15-20 min |
| **Engaged** | We work section by section. I draft, share expert perspectives, you approve before moving on. | 45-60 min |

Which mode works for you today?

---

## AUTO MODE

If user selects Auto:

1. Analyze all provided context (PRD, ideation, domains, etc.)
2. Create complete Vision & Mission document with all sections:
   - Vision Statement
   - Mission Statement
   - Core Values (3-5)
   - Strategic Pillars
   - Hedgehog Concept (What you're best at / What drives value / What you're passionate about)
   - North Star Metric
3. Present complete document
4. Ask: "What would you like to refine?"
5. Iterate until approved
6. Save to `/documents/foundation/vision-mission.md`

---

## ENGAGED MODE

If user selects Engaged:

### Section 1: Vision Statement

**Draft the vision statement**, then present:

> **Draft Vision:**
> [Your draft here]
>
> **Expert Perspectives:**
>
> 🎯 **The Strategist** thinks: [Strategic angle - market positioning, long-term defensibility]
>
> 📢 **The Marketer** thinks: [Messaging angle - clarity, emotional resonance, memorability]
>
> 👥 **The Customer Success Lead** thinks: [Customer angle - does this inspire trust and loyalty?]
>
> ---
>
> **Questions to consider:**
> - Does this capture where you want to be in 5-10 years?
> - Is it ambitious enough to inspire but grounded enough to be credible?
>
> **Your thoughts?** Approve, modify, or let's explore alternatives.

Wait for user approval before proceeding.

---

### Section 2: Mission Statement

**Draft the mission statement**, then present:

> **Draft Mission:**
> [Your draft here]
>
> **Expert Perspectives:**
>
> 🎯 **The Strategist** thinks: [How this differentiates from competitors]
>
> 🛠️ **The Developer** thinks: [Technical feasibility and product alignment]
>
> 💰 **The Revenue Lead** thinks: [Monetization clarity and value proposition]
>
> ---
>
> **Your thoughts?** Approve, modify, or explore alternatives.

Wait for user approval before proceeding.

---

### Section 3: Core Values (3-5)

**Draft 3-5 core values**, then present:

> **Draft Values:**
> 1. [Value 1] - [Why this matters]
> 2. [Value 2] - [Why this matters]
> 3. [Value 3] - [Why this matters]
>
> **Expert Perspectives:**
>
> 👥 **The Culture Lead** thinks: [Do these guide decision-making?]
>
> 🎯 **The Strategist** thinks: [Do these create competitive advantage?]
>
> ---
>
> **Your thoughts?**

Wait for user approval before proceeding.

---

### Section 4: Strategic Pillars

**Draft 3-4 strategic pillars**, then present:

> **Draft Pillars:**
> 1. [Pillar 1] - [Description]
> 2. [Pillar 2] - [Description]
> 3. [Pillar 3] - [Description]
>
> **Expert Perspectives:**
>
> 🏗️ **The Architect** thinks: [Technical foundation implications]
>
> 📈 **The Growth Lead** thinks: [Scalability and expansion potential]
>
> ---
>
> **Your thoughts?**

Wait for user approval before proceeding.

---

### Section 5: Hedgehog Concept

**Draft the three circles**, then present:

> **Hedgehog Concept:**
>
> 🔴 **What you can be best in the world at:**
> [Draft]
>
> 🟢 **What drives your economic engine:**
> [Draft]
>
> 🔵 **What you are deeply passionate about:**
> [Draft]
>
> **The Intersection:**
> [Where all three meet - your strategic focus]
>
> **Expert Perspectives:**
>
> 🎯 **The Strategist** thinks: [Is this focused enough?]
>
> 💡 **The Innovator** thinks: [Is this differentiated enough?]
>
> ---
>
> **Your thoughts?**

Wait for user approval before proceeding.

---

### Section 6: North Star Metric

**Draft the North Star Metric**, then present:

> **Draft North Star:**
> [Metric] - [Why this metric captures value delivery]
>
> **Expert Perspectives:**
>
> 📊 **The Analyst** thinks: [Is this measurable and actionable?]
>
> 👥 **The Customer Success Lead** thinks: [Does this reflect customer value?]
>
> ---
>
> **Your thoughts?**

Wait for user approval.

---

### Final Assembly

Compile all approved sections into complete document.

Present final document and ask:
> "Here's your complete Vision & Mission document. Any final adjustments before I save it?"

Save to `/documents/foundation/vision-mission.md`

---

## Expert Personas Reference

Use these consistently across engaged mode:

| Expert | Emoji | Focus Area |
|--------|-------|------------|
| The Strategist | 🎯 | Market positioning, competitive advantage, long-term thinking |
| The Marketer | 📢 | Messaging, clarity, emotional resonance, brand |
| The Developer | 🛠️ | Technical feasibility, product alignment |
| The Architect | 🏗️ | System design, scalability, technical foundation |
| The Analyst | 📊 | Data, metrics, measurability |
| The Customer Success Lead | 👥 | Customer value, trust, retention |
| The Revenue Lead | 💰 | Monetization, pricing, business model |
| The Growth Lead | 📈 | Scalability, expansion, market opportunity |
| The Innovator | 💡 | Differentiation, creativity, uniqueness |
| The Culture Lead | 🌱 | Values, team alignment, decision-making |

---

## Applying to Other Foundation Documents

This pattern works for all foundation missions:

1. **Market Research** - Experts: Analyst, Strategist, Marketer
2. **Client Blueprint** - Experts: Customer Success, Marketer, Revenue
3. **Positioning** - Experts: Strategist, Marketer, Innovator
4. **Roadmap** - Experts: Architect, Developer, Strategist
5. **Brand Guide** - Experts: Marketer, Designer, Culture Lead

Each mission follows the same structure:
1. Mode selection at start
2. Auto = complete document → review
3. Engaged = section by section with expert perspectives → approve each
```

---

## Implementation Notes

### Where to Add This

Update the foundation mission files in:
```
/missions/foundation/vision-mission-creation.md
/missions/foundation/market-research-creation.md
/missions/foundation/client-blueprint-creation.md
... etc
```

### Key Principles

1. **Mode choice is per-session** - User might want Auto today, Engaged tomorrow
2. **Expert perspectives add value** - They surface considerations user might miss
3. **Approval gates in Engaged mode** - Never proceed without explicit approval
4. **Same output either way** - Both modes produce identical document structure
5. **Time estimates set expectations** - Users know what they're committing to
