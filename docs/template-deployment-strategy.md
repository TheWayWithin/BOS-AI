# BOS-AI Template Deployment Strategy

## Directory Structure & Purpose

### 1. `/docs/Document Library/` - Template Repository
**Purpose**: Master templates and SOPs for creating foundation documents  
**Contents**: 
- Templates (blank starting points)
- SOPs (step-by-step creation guides)
- PDFs (printable versions)
- Business Foundation Library Guide

**Usage**: READ-ONLY reference source
- Agents read templates when creating new documents
- Never modify templates directly
- Single source of truth for templates

### 2. `/documents/foundation/` - Completed Business Documents
**Purpose**: Active business foundation documents (filled-out templates)  
**Contents**:
- `vision-mission.md` - Your actual vision/mission
- `market-research.md` - Your market analysis
- `client-success-blueprint.md` - Your customer profiles
- `positioning-statement.md` - Your positioning
- `strategic-roadmap.md` - Your roadmap
- `brand-style-guide.md` - Your brand guide
- `prds/` - Your product requirements documents

**Usage**: ACTIVE business documents
- Created by filling out templates
- Updated as business evolves
- Referenced by all agents for business context

### 3. `/workspace/` - Mission Context & Orchestration
**Purpose**: Temporary working files for active missions  
**Contents**:
- `business-plan.md` - Current mission tracking
- `chassis-metrics.md` - Live metrics dashboard
- `agent-context.md` - Shared mission knowledge
- `handoff-notes.md` - Agent-to-agent communication
- `decision-log.md` - Decision audit trail

**Usage**: TEMPORARY mission state
- Created/updated during missions
- Preserves context between agents
- Can be cleared after mission completion

## Deployment Requirements

### What SHOULD be deployed to `.claude/`:
```
.claude/
├── agents/          # BOS-AI agent definitions
├── commands/        # Command definitions (coord, etc.)
├── missions/        # Mission sequences and workflows
└── CLAUDE.md       # System instructions
```

### What should NOT be deployed to `.claude/`:
- ❌ Document Library templates (stay in `/docs/Document Library/`)
- ❌ Completed foundation documents (stay in `/documents/foundation/`)
- ❌ Workspace files (stay in `/workspace/`)

## Template Usage Flow

```mermaid
graph LR
    A[Template in /docs/Document Library/] -->|Agent reads| B[Agent creates document]
    B -->|Saves to| C[/documents/foundation/]
    C -->|Referenced by| D[All future missions]
    
    E[Mission starts] -->|Creates| F[/workspace/ context files]
    F -->|Updated by| G[Each agent in sequence]
    G -->|Mission ends| H[Context preserved or cleared]
```

## Example: Creating Vision & Mission

1. **Agent reads template**: `/docs/Document Library/Vision and Mission.md`
2. **Agent reads SOP**: `/docs/Document Library/Vision and Mission Development SOP.md`
3. **Agent creates document**: Fills out template with business specifics
4. **Agent saves to**: `/documents/foundation/vision-mission.md`
5. **Future agents reference**: The completed document at `/documents/foundation/`

## Key Principles

1. **Templates are blueprints**: Never modify originals
2. **Documents are instances**: Created from templates, specific to business
3. **Workspace is ephemeral**: Mission-specific, can be reset
4. **Separation of concerns**: Each directory has clear purpose
5. **No duplication**: One source of truth for each type

## Deployment Script Actions

The deployment script should:
- ✅ Verify `/docs/Document Library/` exists and report contents
- ✅ Create `/documents/foundation/` directory (empty, for user's documents)
- ✅ Create `/workspace/` directory with context templates
- ✅ Deploy agents, commands, missions to `.claude/`
- ❌ Do NOT copy templates to `.claude/`
- ❌ Do NOT duplicate Document Library

## Benefits of This Approach

1. **Clear separation**: Templates vs Documents vs Working files
2. **Single source of truth**: No confusion about which version to use
3. **Easy updates**: Update templates in one place
4. **User ownership**: User's documents separate from system files
5. **Clean missions**: Workspace can be cleared between missions
6. **Scalable**: Can add more templates without deployment changes

---

This strategy ensures templates are available for reference while keeping user documents and working files properly separated.