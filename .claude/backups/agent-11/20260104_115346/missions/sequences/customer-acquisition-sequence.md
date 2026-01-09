# Mission Sequence: Customer Acquisition

**Type**: Sequential Acquisition Campaign  
**Duration**: 3-4 days  
**Agents Required**: 6  
**Expected Impact**: 20-50% increase in customer base

## Mission Objective
Execute a coordinated customer acquisition campaign targeting specific market segments with optimized conversion funnels and compelling value propositions.

## Sequential Agent Flow

### Step 1: Market Segmentation
**Agent**: `market-intelligence`  
**Duration**: 3 hours  
**Task**: Identify and analyze target segments

**Context Input**:
- Acquisition goals
- Read `/workspace/chassis-metrics.md`
- Budget constraints

**Expected Output**:
- Target segments defined
- Segment sizing completed
- Acquisition channels identified
- Update `/workspace/agent-context.md`

---

### Step 2: Opportunity Validation
**Agent**: `opportunity-validation`  
**Duration**: 2 hours  
**Task**: Validate segment attractiveness

**Context Input**:
- Read `/workspace/agent-context.md`
- Segments from Step 1
- Success criteria

**Expected Output**:
- Segments prioritized
- CAC projections
- LTV analysis
- Update `/workspace/handoff-notes.md`

---

### Step 3: Content Strategy
**Agent**: `content-creation`  
**Duration**: 4 hours  
**Task**: Develop acquisition content

**Context Input**:
- Read `/workspace/handoff-notes.md`
- Validated segments from Step 2
- Brand guidelines

**Expected Output**:
- Content calendar created
- Lead magnets developed
- Landing pages designed
- Update `/workspace/business-plan.md`

---

### Step 4: Campaign Execution
**Agent**: `campaign-execution`  
**Duration**: 6 hours  
**Task**: Launch acquisition campaigns

**Context Input**:
- Read `/workspace/business-plan.md`
- Content from Step 3
- Channel strategy

**Expected Output**:
- Campaigns launched
- Ad creative deployed
- Tracking configured
- Update `/workspace/agent-context.md`

---

### Step 5: Conversion Optimization
**Agent**: `conversion-optimization`  
**Duration**: 4 hours  
**Task**: Optimize conversion funnels

**Context Input**:
- Read `/workspace/agent-context.md`
- Campaign data from Step 4
- Conversion goals

**Expected Output**:
- Funnel optimized
- A/B tests implemented
- Conversion rate improved
- Update `/workspace/chassis-metrics.md`

---

### Step 6: Pipeline Integration
**Agent**: `pipeline-management`  
**Duration**: 3 hours  
**Task**: Manage new leads

**Context Input**:
- Read `/workspace/chassis-metrics.md`
- New leads from Step 5
- Sales process

**Expected Output**:
- Leads qualified
- Pipeline updated
- Follow-up scheduled
- Update `/workspace/decision-log.md`
- Acquisition report generated

## Context File Updates

### Required Updates Per Step:
1. **After Step 1**: Initialize `/workspace/agent-context.md` with segments
2. **After Step 2**: Create `/workspace/handoff-notes.md` with validation
3. **After Step 3**: Update `/workspace/business-plan.md` with content plan
4. **After Step 4**: Update `/workspace/agent-context.md` with campaign data
5. **After Step 5**: Update `/workspace/chassis-metrics.md` with conversions
6. **After Step 6**: Update `/workspace/decision-log.md` with results

## Key Metrics Tracked

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| New Prospects | +X% | | |
| Lead Conversion | X% | | |
| CAC | $X | | |
| Campaign ROI | X:1 | | |
| Time to Convert | X days | | |

## Success Criteria
- [ ] Target segments validated
- [ ] CAC below threshold
- [ ] Lead conversion >X%
- [ ] Pipeline value increased
- [ ] ROI positive
- [ ] Scalable process established

## Fallback Sequences
If any agent fails:
1. **Market Intelligence fails**: Use `strategic-opportunity` for segmentation
2. **Opportunity Validation fails**: Use `risk-assessment` for analysis
3. **Content Creation fails**: Use `brand-strategy` for messaging
4. **Campaign Execution fails**: Use `market-expansion` for outreach
5. **Conversion Optimization fails**: Use `revenue-optimization` for improvements
6. **Pipeline Management fails**: Use `revenue-operations` for lead handling

## Chassis Impact Tracking
Monitor real-time impact on multipliers:
- **Prospects**: Should increase by X%
- **Lead Conversion**: Target improvement of Y%
- **Client Conversion**: Monitor for changes
- **Overall Profit Impact**: Calculate after completion

## Example Command
```bash
/coord acquire target-segments.md campaign-budget.md
```

This triggers the acquisition sequence with context about targets and budget.