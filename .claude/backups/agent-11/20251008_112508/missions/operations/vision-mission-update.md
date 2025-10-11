# Mission: Vision & Mission Update

**Type**: Strategic Document Update  
**Duration**: 2-3 hours  
**Agent**: @strategic-opportunity  
**Trigger**: Annual review, major pivot, or strategic shift

## Mission Objective
Update or create the Vision & Mission document using the latest template and AI-assisted SOP to ensure clear strategic direction and purpose.

## Pre-Mission Checklist
- [ ] Document Library deployed to `.claude/document-library/`
- [ ] `/documents/foundation/` directory exists
- [ ] `/documents/archive/` directory exists
- [ ] Previous vision-mission.md backed up (if exists)

## Execution Steps

### Step 1: Assess Current State (15 min)
```bash
# Check if document exists
if [ -f "/documents/foundation/vision-mission.md" ]; then
    echo "Existing document found - will update"
    # Read and analyze current vision & mission
else
    echo "No existing document - will create new"
fi
```

### Step 2: Load Template & SOP (10 min)
1. **Load Template**: `.claude/document-library/Vision and Mission.md`
2. **Load SOP**: `.claude/document-library/Vision and Mission Development SOP (Rapid AI-Driven).md`
3. **Review Structure**: Understand required sections and format

### Step 3: Archive Existing (if updating) (5 min)
```bash
# Only if updating existing document
cp /documents/foundation/vision-mission.md \
   /documents/archive/$(date +%Y-%m-%d)-vision-mission.md
echo "Previous version archived"
```

### Step 4: Follow AI-Assisted Creation Process (90 min)

#### Prompt 1: Vision Statement Creation
**Input Required**:
- Industry/market position
- 10-year aspiration
- Impact desired
- Values to embody

**Output**: Draft vision statement (1-2 sentences)

#### Prompt 2: Mission Statement Creation
**Input Required**:
- How you'll achieve vision
- Core activities
- Unique approach
- Value delivery method

**Output**: Draft mission statement (1-3 sentences)

#### Prompt 3: Strategic Alignment Check
**Validate**:
- Vision is inspiring and achievable
- Mission is actionable and clear
- Both align with current reality
- They work together coherently

#### Prompt 4: Final Refinement
**Polish**:
- Language clarity
- Emotional resonance
- Memorability
- Actionability

### Step 5: Create/Update Document (20 min)
Using the template structure:

```markdown
# Vision & Mission

## Vision Statement
[Your inspiring 10-year destination]

## Mission Statement  
[How you'll achieve the vision]

## Core Values
- [Value 1]: [Description]
- [Value 2]: [Description]
- [Value 3]: [Description]

## Strategic Implications
- What this means for products/services
- What this means for customers
- What this means for operations
- What this means for growth

## Success Metrics
- [How we'll measure vision progress]
- [Key milestones toward vision]

---
*Last Updated: [Date]*
*Next Review: [Date + 1 year]*
```

### Step 6: Save Document (5 min)
```bash
# Save to standard location with standard name
save_to="/documents/foundation/vision-mission.md"
echo "Document saved to $save_to"
```

### Step 7: Update Related Documents (15 min)
Flag for review/update:
- [ ] `/documents/foundation/positioning-statement.md` - Ensure alignment
- [ ] `/documents/foundation/strategic-roadmap.md` - Check consistency
- [ ] `/documents/foundation/brand-style-guide.md` - Verify voice match

### Step 8: Document Changes (10 min)
Update `/workspace/decision-log.md`:
```markdown
## Vision & Mission Update - [Date]
**Reason**: [Annual review/Pivot/Strategic shift]
**Key Changes**:
- [What changed and why]
**Impact**:
- [Expected impact on business]
**Next Steps**:
- [Required follow-up actions]
```

## Quality Checklist
Before marking complete:
- [ ] Vision is inspiring and achievable
- [ ] Mission clearly states how
- [ ] Both under 3 sentences each
- [ ] Language is clear and memorable
- [ ] Saved with correct filename
- [ ] Previous version archived
- [ ] Related docs flagged for review
- [ ] Changes documented

## Common Pitfalls to Avoid
- ❌ Generic corporate speak
- ❌ Unrealistic aspirations
- ❌ Vague or unclear language
- ❌ Misalignment with reality
- ❌ Too long or complex
- ❌ Missing the "why"

## Success Indicators
- ✅ Team can recite from memory
- ✅ Guides decision-making
- ✅ Inspires stakeholders
- ✅ Differentiates from competitors
- ✅ Achievable yet ambitious

## Post-Mission Actions
1. Share updated vision & mission with team
2. Update website/marketing materials
3. Cascade to operational planning
4. Schedule next annual review
5. Create communication plan

---
*Vision & Mission Update Mission v1.0 | Strategic foundation refresh*