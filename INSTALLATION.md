# BOS-AI Installation Guide

## Quick Install (Recommended)

### Step 1: Clone BOS-AI Repository
```bash
git clone https://github.com/TheWayWithin/BOS-AI.git
```

### Step 2: Navigate to YOUR Project
```bash
cd /path/to/your/project
```

### Step 3: Run Installation Script
```bash
/path/to/BOS-AI/install-to-project.sh
```

That's it! BOS-AI is now installed in your project.

## What Gets Installed

```
your-project/
├── .claude/
│   ├── document-library/    # 17 templates and SOPs
│   ├── agents/              # 29+ business agents
│   ├── missions/            # Business missions
│   ├── commands/            # /coord and other commands
│   ├── CLAUDE.md           # System instructions
│   └── BOUNDARIES.md       # Separation guidelines
├── documents/
│   ├── foundation/         # Your business documents go here
│   │   └── prds/          # Product requirements
│   ├── operations/        # Operational bibles
│   ├── archive/          # Version history
│   └── assets/          # Supporting materials
└── workspace/           # Mission context files
```

## Verification

After installation, verify BOS-AI is properly deployed:

### In Claude:
1. Open your project in Claude
2. Type: `/coord verify`
3. Should see all components confirmed

### Check Files:
```bash
# Should see templates
ls .claude/document-library/

# Should see agents
ls .claude/agents/

# Should see directory structure
ls documents/
```

## Creating Your First Document

### Example: Create Vision & Mission
```
/coord vision-mission-update
```

This will:
1. Load the Vision & Mission template
2. Use the AI-assisted SOP
3. Create your document at `documents/foundation/vision-mission.md`

## Updating Existing Documents

If you have existing documents, BOS-AI can update them:

1. **Review and Update All**: `/coord foundation-review`
2. **Update Specific Document**: `/meeting @strategic-opportunity "update vision"`

## Directory Structure Explained

### `.claude/document-library/`
- **Purpose**: Templates and SOPs (READ-ONLY reference)
- **Contents**: 17 templates, SOPs, filing standards
- **Usage**: Agents read these to create your documents

### `documents/foundation/`
- **Purpose**: YOUR actual business documents
- **Contents**: vision-mission.md, market-research.md, etc.
- **Usage**: Created from templates, updated quarterly

### `documents/archive/`
- **Purpose**: Version history
- **Format**: YYYY-MM-DD-[document-name].md
- **Usage**: Automatic archiving when updating

### `workspace/`
- **Purpose**: Temporary mission context
- **Contents**: business-plan.md, chassis-metrics.md, etc.
- **Usage**: Preserves context between agent handoffs

## Common Issues

### "Templates not found"
- Ensure you ran install script from YOUR project directory
- Check `.claude/document-library/` exists
- Verify templates were copied

### "Agents can't find documents"
- Check `documents/foundation/` directory exists
- Ensure using standard names (see FILING-STANDARDS.md)
- Verify permissions on directories

### "Command not recognized"
- Check `.claude/commands/coord.md` exists
- Restart Claude if needed
- Verify installation completed successfully

## Mission Commands

### Business Operations
- `/coord optimize` - Optimize Business Chassis
- `/coord launch [product]` - Launch new product/service
- `/coord acquire [segment]` - Customer acquisition
- `/coord scale` - Scaling strategy

### Document Management
- `/coord foundation-review` - Review all documents
- `/coord vision-mission-update` - Update vision/mission
- `/meeting @[agent] "[task]"` - Direct agent consultation

## Best Practices

1. **Always Archive**: Let agents archive old versions automatically
2. **Use Standard Names**: Follow FILING-STANDARDS.md exactly
3. **Regular Reviews**: Run quarterly foundation reviews
4. **Context Files**: Don't delete workspace/ during active missions
5. **Template Updates**: Pull latest BOS-AI for template improvements

## Support

- **Issues**: https://github.com/TheWayWithin/BOS-AI/issues
- **Documentation**: See `.claude/document-library/business_foundation_library_guide.md`
- **Filing Standards**: See `.claude/document-library/FILING-STANDARDS.md`

---

*BOS-AI Installation Guide v1.0*