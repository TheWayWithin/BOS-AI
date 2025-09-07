# Mission: Foundation Document Review & Update

**Type**: Document Review & Refresh  
**Duration**: 4-6 hours total  
**Frequency**: Quarterly  
**Agents Required**: Multiple specialists

## Mission Objective
Systematically review and update all foundation documents to ensure they remain current, aligned, and formatted according to latest templates.

## Review Sequence (Order Matters)

### 1. Vision & Mission Review
**Agent**: @strategic-opportunity  
**Duration**: 1 hour  
**Priority**: FIRST (all other docs depend on this)

**Steps**:
1. Read current: `/documents/foundation/vision-mission.md`
2. Load template: `.claude/document-library/Vision and Mission.md`
3. Read SOP: `.claude/document-library/Vision and Mission Development SOP (Rapid AI-Driven).md`
4. Evaluate:
   - Is vision still inspiring and achievable?
   - Is mission still relevant to current operations?
   - Do they reflect current market position?
5. If updates needed:
   - Archive: `cp /documents/foundation/vision-mission.md /documents/archive/$(date +%Y-%m-%d)-vision-mission.md`
   - Update using template structure
   - Save to: `/documents/foundation/vision-mission.md`

---

### 2. Market Research Review
**Agent**: @market-intelligence  
**Duration**: 1.5 hours  
**Priority**: SECOND (informs positioning)

**Steps**:
1. Read current: `/documents/foundation/market-research.md`
2. Load template: `.claude/document-library/Market and Client Research Template.md`
3. Read SOP: `.claude/document-library/Market and Client Research SOP (Rapid AI-Driven).md`
4. Evaluate:
   - Market conditions changed?
   - New competitors emerged?
   - Customer segments evolved?
   - Industry trends shifted?
5. If updates needed:
   - Archive current version
   - Update with latest market data
   - Maintain standard format

---

### 3. Client Success Blueprint Review
**Agent**: @client-success-intelligence  
**Duration**: 1 hour  
**Priority**: THIRD (defines who we serve)

**Steps**:
1. Read current: `/documents/foundation/client-success-blueprint.md`
2. Load template: `.claude/document-library/Client Success Blueprint.md`
3. Read SOP: `.claude/document-library/Client Success Blueprint Creation SOP (Revised).md`
4. Evaluate:
   - Customer profiles still accurate?
   - Success metrics still relevant?
   - Pain points evolved?
   - New segments emerged?
5. Update as needed following archival protocol

---

### 4. Positioning Statement Review
**Agent**: @strategic-opportunity  
**Duration**: 45 minutes  
**Priority**: FOURTH (depends on market & customers)

**Steps**:
1. Read current: `/documents/foundation/positioning-statement.md`
2. Load template: `.claude/document-library/Positioning Statement Template.md`
3. Read SOP: `.claude/document-library/Positioning Statement SOP: 3-Hour Sprint.md`
4. Evaluate against:
   - Current market research
   - Updated client blueprint
   - Competitive landscape
5. Refine positioning if needed

---

### 5. Strategic Roadmap Review
**Agent**: @chassis-intelligence  
**Duration**: 1 hour  
**Priority**: FIFTH (incorporates all updates)

**Steps**:
1. Read current: `/documents/foundation/strategic-roadmap.md`
2. Load template: `.claude/document-library/Strategic Roadmap_ Vision to Great.md`
3. Read SOP: `.claude/document-library/Strategic Roadmap Creation SOP (AI-Driven).md`
4. Evaluate:
   - Milestones on track?
   - Priorities still valid?
   - Resource allocation optimal?
   - New opportunities to incorporate?
5. Update quarterly targets and long-term vision

---

### 6. Brand Style Guide Review
**Agent**: @brand-strategy  
**Duration**: 45 minutes  
**Priority**: LAST (visual/voice consistency)

**Steps**:
1. Read current: `/documents/foundation/brand-style-guide.md`
2. Load template: `.claude/document-library/Brand Style Guide.md`
3. Read SOP: `.claude/document-library/Brand Style Guide Creation SOP (AI-Driven).md`
4. Evaluate:
   - Brand elements still resonate?
   - Voice/tone appropriate?
   - Visual identity current?
5. Refresh if brand evolution needed

## Context Preservation

### Use Workspace Files
- Update `/workspace/business-plan.md` with review progress
- Log changes in `/workspace/decision-log.md`
- Create `/workspace/handoff-notes.md` between agents

### Archive Management
- Keep last 3 versions only
- Name format: `YYYY-MM-DD-[document-name].md`
- Store in `/documents/archive/`

## Success Criteria
- [ ] All 6 foundation documents reviewed
- [ ] Outdated content updated
- [ ] Templates/format current
- [ ] Cross-references consistent
- [ ] Archives created for changes
- [ ] Standard names maintained

## Red Flags Requiring Immediate Update
- Market pivot or major shift
- Customer segment change
- Competitive disruption
- Strategic direction change
- Brand crisis or refresh
- Major milestone achieved/missed

## Coordination Protocol
1. Run reviews in sequence (not parallel)
2. Each agent reads previous updates
3. Maintain consistency across documents
4. Flag conflicts for resolution
5. Update workspace tracking files

## Post-Review Actions
1. Generate summary of changes
2. Update operational documents if needed
3. Communicate changes to team
4. Schedule next quarterly review
5. Update PRDs if strategy shifted

---
*Foundation Review Mission v1.0 | Quarterly document refresh protocol*