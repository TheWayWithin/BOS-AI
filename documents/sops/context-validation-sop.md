# Standard Operating Procedure: Context Validation

## Purpose
Ensure all BOS-AI agents consistently access, preserve, and validate critical context documents throughout multi-agent missions, preventing misalignment and ensuring requirements are met.

## Scope
Applies to:
- All 29 BOS-AI specialized agents
- Chassis Intelligence coordinator delegations
- Multi-agent mission workflows
- PRD creation and handoff processes
- Strategic planning and execution tasks
- All business operations requiring context preservation

## Context Requirements Framework

### 1. Mandatory Context Documents

#### Core Context Files (Always Required)
- `/workspace/agent-context.md` - Mission context and current state
- `/workspace/handoff-notes.md` - Specific task requirements
- `/workspace/business-plan.md` - Overall mission plan
- `/workspace/chassis-metrics.md` - Business metrics tracking

#### Foundation Documents (Task-Specific)
- **PRD Creation**: `/documents/foundation/vision-mission.md`, `/documents/foundation/strategic-roadmap.md`
- **Customer Work**: `/documents/foundation/client-success-blueprint.md`
- **Market Analysis**: `/documents/foundation/market-research.md`
- **Strategy Work**: `/documents/foundation/strategic-roadmap.md`
- **Positioning**: `/documents/foundation/positioning-statement.md`

### 2. Pre-Task Validation Protocol

#### Agent Self-Check (Before Starting Any Task)
1. [ ] Locate and read `/workspace/agent-context.md`
2. [ ] Read `/workspace/handoff-notes.md` for specific instructions
3. [ ] Identify which foundation documents apply to task
4. [ ] Read all applicable foundation documents
5. [ ] Confirm understanding of requirements
6. [ ] If any document missing, STOP and report

#### Coordinator Verification (Before Delegation)
1. [ ] Update `/workspace/agent-context.md` with current state
2. [ ] Create specific `/workspace/handoff-notes.md` for agent
3. [ ] List required documents in Task prompt
4. [ ] Include validation instructions in delegation
5. [ ] Set expectation for context preservation

### 3. During-Task Context Management

#### Active Context Tracking
- Maintain awareness of mission objectives throughout task
- Reference context documents when making decisions
- Validate outputs against original requirements
- Document deviations or discoveries immediately

#### Decision Documentation
- Record key decisions in `/workspace/decision-log.md`
- Explain rationale with context references
- Note any constraints or limitations discovered
- Flag items requiring escalation

### 4. Post-Task Validation Protocol

#### Agent Completion Checklist
1. [ ] Task output aligns with requirements in handoff notes
2. [ ] Updated `/workspace/agent-context.md` with findings
3. [ ] Created/updated `/workspace/handoff-notes.md` for next agent
4. [ ] Updated `/workspace/chassis-metrics.md` if applicable
5. [ ] Saved any deliverables to correct locations
6. [ ] Documented all key decisions and discoveries

#### Coordinator Post-Task Review
1. [ ] Verify agent read required documents (check content alignment)
2. [ ] Confirm context documents were updated
3. [ ] Validate output meets original requirements
4. [ ] Check handoff notes created for next agent
5. [ ] Log compliance in mission dashboard
6. [ ] If non-compliant, re-delegate with enforcement

## Validation Criteria

### Compliance Indicators (Green Flags)
- Output explicitly references context documents
- Deliverables align with stated requirements
- Context files show meaningful updates
- Handoff notes contain specific, actionable information
- Metrics updated with relevant data

### Non-Compliance Indicators (Red Flags)
- Generic output without context awareness
- Missing or unchanged context documents
- Output misaligned with requirements
- No handoff notes or generic templates
- Metrics not updated or incorrect

## Enforcement Mechanisms

### Automated Checks
- Mission dashboard tracks document access
- Context file timestamps validate updates
- Output scanning for requirement keywords
- Compliance scoring algorithm

### Manual Reviews
- Spot checks by Chassis Intelligence
- Mission retrospectives include context audit
- Weekly compliance reports
- Escalation for repeated violations

## Recovery Procedures

### When Context Is Lost
1. **Immediate Stop** - Halt current task execution
2. **Context Reconstruction** - Read all workspace files
3. **Mission Review** - Check TodoWrite for progress
4. **Checkpoint Recovery** - Find latest checkpoint file
5. **Resume with Context** - Continue with full awareness

### When Output Misaligns
1. **Root Cause Analysis** - Identify which context was missing
2. **Context Remediation** - Ensure all documents available
3. **Re-delegation** - Repeat task with explicit context requirements
4. **Validation** - Verify new output aligns properly
5. **Process Update** - Add safeguards to prevent recurrence

## Key Metrics

### Primary KPIs
- Context Document Access Rate (target: 100%)
- Output Alignment Score (target: >95%)
- Context Preservation Rate (target: 100%)
- Handoff Completion Rate (target: 100%)
- Recovery Success Rate (target: >90%)

### Supporting Metrics
- Time to context access
- Context update quality score
- Handoff clarity rating
- Mission success correlation
- Rework reduction percentage

## Tools & Templates

### Required Tools
- `/workspace/templates/agent-delegation-template.md`
- Context validation checklist
- Compliance tracking dashboard
- Automated validation scripts

### Documentation Standards
- Clear, specific handoff notes
- Comprehensive context updates
- Decision rationale with references
- Metrics with source attribution

## Frequency
- Pre-task validation: Every delegation
- During-task checks: Continuous
- Post-task validation: Every completion
- Compliance reviews: Weekly
- Full audits: Monthly

## Responsibilities

### Chassis Intelligence
- Enforce context protocols in all delegations
- Monitor compliance across missions
- Update context before delegations
- Validate outputs post-task
- Escalate non-compliance issues

### Specialized Agents
- Read all required context documents
- Validate understanding before starting
- Update context documents after completion
- Create comprehensive handoff notes
- Report missing or unclear context

### Mission Control
- Maintain context document integrity
- Provide recovery support
- Generate compliance reports
- Update validation procedures
- Train agents on protocols

## Success Criteria
- [ ] 100% of agents accessing required context
- [ ] >95% output alignment with requirements
- [ ] Zero context loss between handoffs
- [ ] <5% tasks requiring rework
- [ ] All PRDs properly aligned with vision

## Escalation Protocol

### Severity Levels
- **Level 1**: Single context miss - Agent reminder
- **Level 2**: Repeated misses - Retraining required
- **Level 3**: Mission impact - Immediate intervention
- **Level 4**: System failure - Emergency protocol activation

### Escalation Path
1. Agent self-correction
2. Coordinator intervention
3. Mission Control review
4. System administrator action
5. Process improvement team

## Related Documents
- `/documents/sops/mission-coordination-sop.md`
- `/workspace/templates/agent-delegation-template.md`
- `/documents/foundation/` - All foundation documents
- `/workspace/` - All context files
- `BOUNDARIES.md` - System boundaries

## Revision History
- v1.0: Initial creation for context guardrails
- Created: Current date
- Next Review: 30 days

---
*This SOP ensures consistent context preservation and validation across all BOS-AI operations.*