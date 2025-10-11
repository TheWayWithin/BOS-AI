# Enhanced BOS-AI Mission Template

Template for updating all BOS-AI missions to incorporate Claude Code SDK enhancements: memory integration, extended thinking modes, context editing, tool permissions, and self-verification protocols.

## Mission Template Structure

### Mission Header (Updated)
```markdown
# Mission: [Mission Name] [Emoji]

**Mission Type:** [Category]  
**Duration:** [Time] | **Cognitive Load:** [ultrathink/think harder/think hard/think/standard]  
**Memory Requirements:** [High/Medium/Low] | **Context Management:** [Strategic /clear recommended/Standard]  
**Security Level:** [Standard/Controlled/Critical/Restricted]  
**Value Impact:** [Business outcome description]
```

### Memory Integration Protocol (New Section)
```markdown
## Memory Integration Requirements

**MANDATORY MEMORY ACCESS**: All agents MUST read relevant memory files before task execution and update with new learnings.

**Required Memory Files**:
- `/memories/business/vision.xml` - Strategic alignment verification
- `/memories/business/customers.xml` - Customer-centric decision validation  
- `/memories/business/[domain].xml` - Domain-specific historical intelligence
- `/memories/strategies/[domain].xml` - Proven strategies and failure prevention
- `/memories/lessons/patterns.xml` - Business pattern recognition

**Memory Update Protocol**:
- Document new business insights in appropriate memory files
- Record successful strategies for future reference
- Log failed approaches in failures.xml for prevention
- Update business intelligence with mission outcomes
```

### Enhanced Task Delegation (Updated)
```markdown
### Phase [X]: [Phase Name] ([Duration])

**Lead Agent**: [agent-name] | **Thinking Mode**: [ultrathink/think harder/think hard/think/standard]  
**Support Agents**: [agent-names] | **Tool Permissions**: [security level]  
**Objective**: [Clear business outcome with Business Chassis impact]

**Task Delegation Protocol**:
```
Task(
    subagent_type='[agent-name]',
    description='[Brief 3-5 word description]',
    prompt='''
    MEMORY INTEGRATION REQUIRED: First read relevant memory files for business context and historical intelligence.
    
    [Detailed task instructions]
    
    MANDATORY DELIVERABLES:
    1. [Specific business outcome]
    2. Memory file updates with new insights
    3. Progress tracking documentation
    4. Handoff notes for next agent
    
    SELF-VERIFICATION CHECKLIST:
    - [ ] Business vision alignment verified
    - [ ] Customer impact optimized  
    - [ ] Financial implications assessed
    - [ ] Business Chassis effects considered
    - [ ] Memory files updated with learnings
    - [ ] Progress tracking documentation complete
    
    Update handoff-notes.md with findings for the next specialist.
    '''
)
```

**Expected Outcomes**:
- [Business deliverable with specific location]
- Memory intelligence enhancement
- Business pattern recognition
- Strategic insight documentation
```

### Context Management (New Section)
```markdown
## Context Management Strategy

**Mission Duration Assessment**: [4+ hours = Strategic /clear recommended]

**Context Refresh Points**:
- After Phase [X]: Update memory files, strategic /clear recommended
- Before Phase [Y]: Read memory files, restore business context
- At mission completion: Comprehensive memory update

**Context Preservation Protocol**:
1. Update progress.md with current mission status
2. Update memory files with business intelligence
3. Update handoff-notes.md with agent communication
4. Execute strategic /clear for context refresh
5. Read memory files to restore business context
```

### Security and Compliance (New Section)
```markdown
## Security and Compliance Requirements

**Agent Security Levels**:
- [agent-name]: [Privileged/Standard/Controlled/Critical/Restricted] access
- Financial data handling: [Audit trail required/Not applicable]
- Legal document access: [Read-only required/Controlled updates/Not applicable]

**Compliance Validation**:
- [ ] Tool permissions appropriate for data sensitivity
- [ ] Financial agent access logged and monitored
- [ ] Legal document integrity maintained
- [ ] Customer data handling compliant with privacy requirements
```

## Example: Updated Marketing System Setup Mission

```markdown
# Mission: Marketing System Setup 📊

**Mission Type:** Marketing Foundation Creation  
**Duration:** 4-5 hours | **Cognitive Load:** think harder (brand-strategy), think hard (campaign-execution), think (content-creation)  
**Memory Requirements:** High | **Context Management:** Strategic /clear after each phase  
**Security Level:** Controlled  
**Value Impact:** Complete 3-Document Marketing Framework with Customer Success Focus

## Memory Integration Requirements

**MANDATORY MEMORY ACCESS**: All agents MUST read relevant memory files before task execution.

**Required Memory Files**:
- `/memories/business/vision.xml` - Business objectives and customer focus validation
- `/memories/business/customers.xml` - Customer personas and journey insights
- `/memories/business/markets.xml` - Market positioning and competitive intelligence
- `/memories/strategies/marketing.xml` - Historical marketing performance and patterns
- `/memories/strategies/failures.xml` - Marketing approaches to avoid

## Mission Phases

### Phase 1: Strategic Foundation Creation (90 minutes)

**Lead Agent**: brand-strategy | **Thinking Mode**: think harder  
**Support Agents**: market-intelligence | **Tool Permissions**: Controlled ([Read, Edit])  
**Objective**: Create Marketing Bible with customer-success philosophy and Business Chassis multiplication focus

**Task Delegation Protocol**:
```
Task(
    subagent_type='brand-strategy',
    description='Marketing Bible strategic creation',
    prompt='''
    MEMORY INTEGRATION REQUIRED: First read /memories/business/vision.xml, /memories/business/customers.xml, and /memories/strategies/marketing.xml for business context.
    
    Create Marketing Bible using Operations Library framework with customer-success focused marketing approach:
    
    1. Analyze foundation documents for customer-centric marketing insights
    2. Define 5-core marketing principles based on customer success philosophy
    3. Create value communication framework (Overt Benefits, Dramatic Difference, Real Reasons to Believe)
    4. Map customer journey marketing for all 5 stages (Awareness → Consideration → Decision → Success → Advocacy)
    5. Establish brand-aligned content standards optimized for Business Chassis Prospects multiplication
    6. Document measurement frameworks focused on customer success metrics and Lead Conversion optimization
    
    MANDATORY DELIVERABLES:
    1. Marketing Bible document with customer-success philosophy
    2. Update /memories/strategies/marketing.xml with new strategic framework
    3. Document brand insights in /memories/business/customers.xml
    4. Progress tracking with strategic decision rationale
    
    SELF-VERIFICATION CHECKLIST:
    - [ ] Marketing strategy aligns with business vision and customer success
    - [ ] Business Chassis Prospects + Lead Conversion multiplication considered
    - [ ] Customer journey fully mapped with success enablement focus
    - [ ] Brand consistency maintained across all recommendations
    - [ ] Memory files updated with marketing intelligence
    - [ ] Strategic decisions documented with business rationale
    
    Update handoff-notes.md with marketing strategy findings for campaign-execution agent.
    '''
)
```

**Context Management**: After Phase 1 completion, strategic /clear recommended due to high cognitive load content.

### Phase 2: Tactical Campaign Planning (90 minutes)

**Lead Agent**: campaign-execution | **Thinking Mode**: think hard  
**Support Agents**: brand-strategy | **Tool Permissions**: Controlled ([Read, Edit])  
**Objective**: Create Marketing Plan translating strategy into customer-success focused campaigns

[Rest of mission continues with same enhanced pattern...]
```

This template ensures all missions incorporate:
1. Memory integration requirements and protocols
2. Extended thinking mode assignments
3. Proper Task tool delegation syntax
4. Context management strategies
5. Security and compliance requirements
6. Self-verification protocols
7. Business Chassis multiplication focus
8. Customer success philosophy integration