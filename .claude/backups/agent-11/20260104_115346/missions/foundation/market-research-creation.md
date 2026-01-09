# Mission: Market Research Creation

**Mission Type:** Foundation Document Creation
**Duration:** 60-120 minutes
**Output:** `/documents/foundation/market-research.md`

---

## Mission Objective

Create comprehensive market research that validates the business opportunity, maps the competitive landscape, and identifies market dynamics that inform strategic decisions.

## Required Agents

- `market-intelligence` (primary) - Market analysis and research
- `strategic-opportunity` (support) - Opportunity assessment
- `opportunity-validation` (support) - Validation frameworks

---

## Reference Documents

**Before starting this mission, read these reference documents:**

| Document | Purpose | Location |
|----------|---------|----------|
| **Market Research SOP** | Process methodology and AI prompts | `/docs/Document Library/Foundation/Market and Client Research SOP (Rapid AI-Driven).md` |
| **Market Research Template** | Output document structure | `/docs/Document Library/Foundation/Market and Client Research Template.md` |

**Key Research Areas from SOP:**
- Market Size & Growth Analysis (TAM/SAM/SOM)
- Competitive Landscape Mapping
- Customer Segmentation & Analysis
- Industry Trends & Disruptions
- Opportunity Assessment Framework

---

## PHASE 0: MODE SELECTION

**Before proceeding, ask the user:**

> **How would you like to create your Market Research document?**
>
> | Mode | Description | Time |
> |------|-------------|------|
> | **Auto** | I'll create comprehensive market research based on your inputs. You review and refine at the end. | 30-45 min |
> | **Engaged** | We work section by section. I research, present findings, you validate before moving on. | 60-90 min |
>
> Which mode works for you today?

**Wait for user response before proceeding.**

---

## PHASE 1: CONTEXT GATHERING

Gather essential context:

1. **Read provided context files** (PRD, vision-mission, ideation docs)
2. **Ask clarifying questions:**
   - What industry/market are you entering?
   - Who are your known competitors?
   - What geographic markets are you targeting?
   - Any existing market data or research to incorporate?

---

## AUTO MODE EXECUTION

If user selected **Auto**:

### Step 1: Generate Complete Document

Create the full Market Research document:

```markdown
# Market Research

## Executive Summary
[2-3 paragraph overview of key findings]

## Market Overview
### Market Size
- **TAM (Total Addressable Market):** $X
- **SAM (Serviceable Addressable Market):** $X
- **SOM (Serviceable Obtainable Market):** $X

### Market Growth
- Current growth rate: X%
- Projected 5-year CAGR: X%
- Key growth drivers: [List]

### Market Trends
1. [Trend 1] - [Impact on business]
2. [Trend 2] - [Impact on business]
3. [Trend 3] - [Impact on business]

## Competitive Landscape
### Direct Competitors
| Competitor | Positioning | Strengths | Weaknesses | Pricing |
|------------|-------------|-----------|------------|---------|
| [Name] | [Position] | [Strengths] | [Weaknesses] | [Price] |

### Indirect Competitors
[Alternative solutions customers use]

### Competitive Gaps
[Opportunities not addressed by competitors]

## Customer Analysis
### Customer Segments
1. [Segment 1] - Size, characteristics, needs
2. [Segment 2] - Size, characteristics, needs
3. [Segment 3] - Size, characteristics, needs

### Customer Pain Points
1. [Pain 1] - Severity, current solutions
2. [Pain 2] - Severity, current solutions
3. [Pain 3] - Severity, current solutions

### Buying Behavior
- Decision makers: [Who]
- Buying triggers: [What]
- Evaluation criteria: [How]

## Market Opportunities
### Primary Opportunity
[Description and size]

### Secondary Opportunities
[List with potential]

### Timing Considerations
[Why now is the right time]

## Market Risks
1. [Risk 1] - Likelihood, mitigation
2. [Risk 2] - Likelihood, mitigation
3. [Risk 3] - Likelihood, mitigation

## Strategic Implications
[How this research should inform strategy]
```

### Step 2: Present for Review

Show complete document and ask what to refine.

### Step 3: Save Document

Save to `/documents/foundation/market-research.md`

---

## ENGAGED MODE EXECUTION

If user selected **Engaged**:

### Section 1: Market Overview & Size

**Research and present:**

> **Market Overview:**
>
> **Market Size:**
> - TAM: $[X] - [How calculated]
> - SAM: $[X] - [Your serviceable portion]
> - SOM: $[X] - [Realistic capture in 3 years]
>
> **Growth Dynamics:**
> - Current growth: [X]%
> - 5-year projection: [X]%
> - Key drivers: [List]
>
> ---
>
> **Different Perspectives:**
>
> **Investor lens:** [Is this market big enough? Is growth sustainable?]
>
> **Timing lens:** [Is the market mature, growing, or emerging?]
>
> **Risk lens:** [What could shrink this market?]
>
> ---
>
> **Your thoughts?** Does this match your understanding? Any data to add?

**Wait for approval before proceeding.**

---

### Section 2: Market Trends

**Research and present:**

> **Key Market Trends:**
>
> 1. **[Trend 1]**
>    - What's happening: [Description]
>    - Impact on your business: [Opportunity/threat]
>
> 2. **[Trend 2]**
>    - What's happening: [Description]
>    - Impact on your business: [Opportunity/threat]
>
> 3. **[Trend 3]**
>    - What's happening: [Description]
>    - Impact on your business: [Opportunity/threat]
>
> ---
>
> **Different Perspectives:**
>
> **Strategic lens:** [Which trends should you ride vs. ignore?]
>
> **Innovation lens:** [Are there emerging trends not yet mainstream?]
>
> ---
>
> **Your thoughts?** Any trends to add or remove?

**Wait for approval before proceeding.**

---

### Section 3: Competitive Landscape

**Research and present:**

> **Competitive Analysis:**
>
> **Direct Competitors:**
> | Competitor | Positioning | Strengths | Weaknesses |
> |------------|-------------|-----------|------------|
> | [Name 1] | [Position] | [Strengths] | [Gaps] |
> | [Name 2] | [Position] | [Strengths] | [Gaps] |
> | [Name 3] | [Position] | [Strengths] | [Gaps] |
>
> **Indirect Competitors:**
> [What else do customers use to solve this problem?]
>
> **Competitive Gaps:**
> [What's nobody doing well?]
>
> ---
>
> **Different Perspectives:**
>
> **Positioning lens:** [Where's the white space?]
>
> **Threat lens:** [Who could crush you? Who might enter?]
>
> **Differentiation lens:** [What can you do that they can't easily copy?]
>
> ---
>
> **Your thoughts?** Any competitors to add? Gaps I missed?

**Wait for approval before proceeding.**

---

### Section 4: Customer Analysis

**Research and present:**

> **Customer Analysis:**
>
> **Primary Segments:**
> 1. **[Segment 1]:** [Size, characteristics, why they buy]
> 2. **[Segment 2]:** [Size, characteristics, why they buy]
> 3. **[Segment 3]:** [Size, characteristics, why they buy]
>
> **Top Pain Points:**
> 1. [Pain] - How severe? What do they do now?
> 2. [Pain] - How severe? What do they do now?
> 3. [Pain] - How severe? What do they do now?
>
> **Buying Behavior:**
> - Who decides: [Role]
> - What triggers purchase: [Events]
> - How they evaluate: [Criteria]
>
> ---
>
> **Different Perspectives:**
>
> **Sales lens:** [Who's easiest to sell to? Who has budget?]
>
> **Product lens:** [Which segment should you build for first?]
>
> **Growth lens:** [Which segment has viral/referral potential?]
>
> ---
>
> **Your thoughts?** Does this match your customer understanding?

**Wait for approval before proceeding.**

---

### Section 5: Opportunities & Risks

**Research and present:**

> **Market Opportunities:**
>
> **Primary Opportunity:**
> [Description, size, why it's compelling]
>
> **Secondary Opportunities:**
> 1. [Opportunity] - [Potential]
> 2. [Opportunity] - [Potential]
>
> ---
>
> **Market Risks:**
>
> 1. **[Risk]** - Likelihood: [H/M/L], Mitigation: [Strategy]
> 2. **[Risk]** - Likelihood: [H/M/L], Mitigation: [Strategy]
> 3. **[Risk]** - Likelihood: [H/M/L], Mitigation: [Strategy]
>
> ---
>
> **Different Perspectives:**
>
> **Optimist lens:** [Best case scenario if trends continue]
>
> **Pessimist lens:** [What could go wrong?]
>
> **Realist lens:** [Most likely outcome]
>
> ---
>
> **Your thoughts?** Any opportunities or risks to add?

**Wait for approval before proceeding.**

---

### Section 6: Strategic Implications

**Synthesize and present:**

> **Strategic Implications:**
>
> Based on this research:
>
> 1. **Target Market:** [Recommended focus]
> 2. **Positioning:** [Recommended angle]
> 3. **Timing:** [Why now]
> 4. **Key Success Factors:** [What must go right]
>
> ---
>
> **Your thoughts?** Does this synthesis feel right?

**Wait for approval.**

---

### Final Assembly

Compile all approved sections and save to `/documents/foundation/market-research.md`

---

## Success Criteria

- [ ] Market size (TAM/SAM/SOM) documented with sources
- [ ] Key trends identified with business impact
- [ ] Competitive landscape mapped (direct + indirect)
- [ ] Customer segments defined with pain points
- [ ] Opportunities and risks assessed
- [ ] Strategic implications synthesized
- [ ] Document saved to correct location

---
*Market Research Creation Mission | Foundation Document | BOS-AI*
