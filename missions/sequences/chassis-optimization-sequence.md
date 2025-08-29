# Mission Sequence: Chassis Optimization

**Type**: Sequential Business Optimization  
**Duration**: 2-3 days  
**Agents Required**: 5  
**Expected Impact**: 15-30% profit increase

## Mission Objective
Systematically identify and improve the weakest Business Chassis multiplier through data-driven analysis and targeted interventions.

## Sequential Agent Flow

### Step 1: Multiplication Analysis
**Agent**: `multiplication-engine`  
**Duration**: 2 hours  
**Task**: Identify weakest multiplier

**Context Input**:
- Read `/workspace/chassis-metrics.md`
- Analyze current multiplier values
- Compare to industry benchmarks

**Expected Output**:
- Weakest multiplier identified
- Root cause analysis
- Improvement potential calculated
- Update `/workspace/handoff-notes.md`

---

### Step 2: Market Research
**Agent**: `market-intelligence`  
**Duration**: 4 hours  
**Task**: Research improvement opportunities

**Context Input**:
- Read `/workspace/handoff-notes.md` from Step 1
- Focus on identified weak multiplier
- Research competitor approaches

**Expected Output**:
- Market best practices identified
- Competitor strategies analyzed
- Opportunity sizing completed
- Update `/workspace/agent-context.md`

---

### Step 3: Solution Design
**Agent**: `solution-design`  
**Duration**: 3 hours  
**Task**: Design intervention strategy

**Context Input**:
- Read `/workspace/agent-context.md`
- Review market research findings
- Consider resource constraints

**Expected Output**:
- Detailed intervention plan
- Implementation roadmap
- Success metrics defined
- Update `/workspace/business-plan.md`

---

### Step 4: Implementation
**Agent**: Based on weak multiplier:
- If Lead Conversion: `conversion-optimization`
- If Client Conversion: `pipeline-management`
- If Average Spend: `revenue-optimization`
- If Frequency: `retention-strategy`
- If Margin: `value-optimization`
- If Prospects: `market-expansion`

**Duration**: 8 hours  
**Task**: Execute improvement plan

**Context Input**:
- Read `/workspace/business-plan.md`
- Follow implementation roadmap
- Track progress metrics

**Expected Output**:
- Intervention executed
- Initial results captured
- Challenges documented
- Update `/workspace/chassis-metrics.md`

---

### Step 5: Performance Analysis
**Agent**: `performance-analysis`  
**Duration**: 2 hours  
**Task**: Measure and report impact

**Context Input**:
- Read all `/workspace/*.md` files
- Compare before/after metrics
- Calculate ROI

**Expected Output**:
- Impact assessment complete
- ROI calculated
- Lessons learned documented
- Update `/workspace/decision-log.md`
- Final report generated

## Context File Updates

### Required Updates Per Step:
1. **After Step 1**: Create initial `/workspace/handoff-notes.md`
2. **After Step 2**: Update `/workspace/agent-context.md` with findings
3. **After Step 3**: Update `/workspace/business-plan.md` with implementation plan
4. **After Step 4**: Update `/workspace/chassis-metrics.md` with new values
5. **After Step 5**: Update `/workspace/decision-log.md` with outcomes

## Success Criteria
- [ ] Weakest multiplier improved by >10%
- [ ] Overall profit impact >15%
- [ ] All context files updated
- [ ] Lessons learned documented
- [ ] Next optimization target identified

## Fallback Sequences
If any agent fails to deliver:
1. **Multiplication Engine fails**: Use `performance-analysis` for manual analysis
2. **Market Intelligence fails**: Use `strategic-opportunity` for internal analysis
3. **Solution Design fails**: Use `value-optimization` for alternative approach
4. **Implementation fails**: Escalate to human intervention
5. **Performance Analysis fails**: Use `chassis-intelligence` for review

## Example Command
```bash
/coord optimize
```

This triggers the full sequence automatically with context preservation between each step.