# Mission Sequence: Product Launch

**Type**: Sequential Product/Service Launch  
**Duration**: 5-7 days  
**Agents Required**: 7  
**Expected Impact**: New revenue stream activation

## Mission Objective
Orchestrate a complete product or service launch from strategic positioning through market introduction and initial customer success.

## Sequential Agent Flow

### Step 1: Strategic Positioning
**Agent**: `strategic-opportunity`  
**Duration**: 4 hours  
**Task**: Define market position and strategy

**Context Input**:
- Product/service concept brief
- Read `/workspace/chassis-metrics.md`
- Target market definition

**Expected Output**:
- Positioning statement created
- Competitive differentiation defined
- Target segments identified
- Update `/workspace/agent-context.md`

---

### Step 2: Solution Architecture
**Agent**: `solution-design`  
**Duration**: 6 hours  
**Task**: Create comprehensive PRD

**Context Input**:
- Read `/workspace/agent-context.md`
- Positioning from Step 1
- Customer needs analysis

**Expected Output**:
- Complete PRD document
- Feature prioritization
- Success metrics defined
- Save PRD to `/documents/foundation/prds/`
- Update `/workspace/handoff-notes.md`

---

### Step 3: Value Optimization
**Agent**: `value-optimization`  
**Duration**: 3 hours  
**Task**: Maximize value proposition

**Context Input**:
- Read PRD from Step 2
- Read `/workspace/handoff-notes.md`
- Margin requirements

**Expected Output**:
- Value proposition refined
- Pricing strategy developed
- ROI projections calculated
- Update `/workspace/business-plan.md`

---

### Step 4: Brand Messaging
**Agent**: `brand-strategy`  
**Duration**: 4 hours  
**Task**: Develop launch messaging

**Context Input**:
- Read `/workspace/business-plan.md`
- Value proposition from Step 3
- Brand guidelines

**Expected Output**:
- Key messages created
- Brand story developed
- Visual identity defined
- Update `/workspace/agent-context.md`

---

### Step 5: Campaign Development
**Agent**: `campaign-execution`  
**Duration**: 8 hours  
**Task**: Create and launch marketing campaigns

**Context Input**:
- Read `/workspace/agent-context.md`
- Brand messaging from Step 4
- Target segments

**Expected Output**:
- Campaign assets created
- Launch calendar defined
- Channels activated
- Update `/workspace/handoff-notes.md`

---

### Step 6: Sales Enablement
**Agent**: `pipeline-management`  
**Duration**: 4 hours  
**Task**: Prepare sales process

**Context Input**:
- Read `/workspace/handoff-notes.md`
- Campaign materials from Step 5
- Pricing strategy

**Expected Output**:
- Sales playbook created
- Pipeline stages defined
- CRM configured
- Update `/workspace/business-plan.md`

---

### Step 7: Customer Success Setup
**Agent**: `customer-success`  
**Duration**: 4 hours  
**Task**: Establish success protocols

**Context Input**:
- Read all `/workspace/*.md` files
- Success metrics from PRD
- Support requirements

**Expected Output**:
- Onboarding process created
- Success metrics tracking
- Support documentation
- Update `/workspace/chassis-metrics.md`
- Launch readiness confirmed

## Context File Updates

### Required Updates Per Step:
1. **After Step 1**: Initialize `/workspace/agent-context.md` with positioning
2. **After Step 2**: Create PRD, update `/workspace/handoff-notes.md`
3. **After Step 3**: Update `/workspace/business-plan.md` with pricing
4. **After Step 4**: Update `/workspace/agent-context.md` with messaging
5. **After Step 5**: Update `/workspace/handoff-notes.md` with campaign details
6. **After Step 6**: Update `/workspace/business-plan.md` with sales process
7. **After Step 7**: Update `/workspace/chassis-metrics.md` with new product metrics

## Success Criteria
- [ ] PRD completed and validated
- [ ] Positioning clearly differentiated
- [ ] Pricing optimized for value
- [ ] Campaign launched successfully
- [ ] Sales team enabled
- [ ] Customer success ready
- [ ] First customers acquired

## Fallback Sequences
If any agent fails:
1. **Strategic Opportunity fails**: Use `market-intelligence` for positioning
2. **Solution Design fails**: Escalate to human for PRD
3. **Value Optimization fails**: Use `revenue-optimization` for pricing
4. **Brand Strategy fails**: Use `content-creation` for messaging
5. **Campaign Execution fails**: Use `market-expansion` for go-to-market
6. **Pipeline Management fails**: Use `revenue-operations` for sales setup
7. **Customer Success fails**: Use `satisfaction-optimization` for support

## PRD Handoff Point
After Step 2, if technical implementation is needed:
```
PRD Complete: /documents/foundation/prds/[product]-prd.md
Ready for AGENT-11 technical implementation
Use separate command for development
```

## Example Command
```bash
/coord launch product-brief.md market-research.md
```

This triggers the full launch sequence with provided context files.