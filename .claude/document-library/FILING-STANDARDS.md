# Document Filing Standards & Naming Conventions

## Core Principle
**One name, one location, version controlled through archiving**

## Foundation Documents Directory Structure

```
/documents/
├── foundation/               # Core strategic documents
│   ├── vision-mission.md
│   ├── market-research.md
│   ├── client-success-blueprint.md
│   ├── positioning-statement.md
│   ├── strategic-roadmap.md
│   ├── brand-style-guide.md
│   └── prds/                # Product requirements
│       ├── [product-name]-prd.md
│       └── ...
├── operations/              # Operational bibles
│   ├── marketing-bible.md
│   ├── sales-bible.md
│   ├── customer-bible.md
│   ├── operations-bible.md
│   ├── finance-bible.md
│   └── legal-bible.md
├── archive/                 # Version history
│   ├── 2025-01-15-vision-mission.md
│   ├── 2024-12-01-strategic-roadmap.md
│   └── ...
└── assets/                  # Supporting materials
    ├── templates/
    ├── graphics/
    └── scripts/
```

## Template → Document Mapping

**ALWAYS use these exact filenames when saving:**

| Template in `.claude/document-library/` | Save As in `/documents/foundation/` |
|------------------------------------------|--------------------------------------|
| Vision and Mission.md | vision-mission.md |
| Market and Client Research Template.md | market-research.md |
| Client Success Blueprint.md | client-success-blueprint.md |
| Positioning Statement Template.md | positioning-statement.md |
| Strategic Roadmap_ Vision to Great.md | strategic-roadmap.md |
| Brand Style Guide.md | brand-style-guide.md |
| Product Requirements Document (PRD).md | prds/[product-name]-prd.md |

## Archiving Protocol

### When Updating Existing Documents:

```bash
# 1. Archive current version FIRST
cp /documents/foundation/vision-mission.md \
   /documents/archive/$(date +%Y-%m-%d)-vision-mission.md

# 2. Update the document in place
# Edit /documents/foundation/vision-mission.md

# 3. Maintain archive hygiene
# Keep only last 3 versions per document
# Delete older archives if > 3 versions exist
```

### Archive Naming Convention:
- Format: `YYYY-MM-DD-[document-name].md`
- Example: `2025-01-15-vision-mission.md`
- Sort naturally by date for easy browsing

## Document Creation Workflow

### For NEW Documents:
1. **Find Template**: `.claude/document-library/[Template Name].md`
2. **Read SOP**: `.claude/document-library/[Corresponding SOP].md`
3. **Create Document**: Fill template with business-specific content
4. **Save with Standard Name**: `/documents/foundation/[standard-name].md`
5. **Update Tracking**: Note in `/workspace/business-plan.md`

### For UPDATING Documents:
1. **Archive Current**: Copy to `/documents/archive/YYYY-MM-DD-[name].md`
2. **Check Template**: Compare with latest in `.claude/document-library/`
3. **Update Content**: Preserve valid content, update format if needed
4. **Save in Place**: Overwrite `/documents/foundation/[name].md`
5. **Log Change**: Note update in `/workspace/decision-log.md`

## Naming Rules

### DO:
- ✅ Use lowercase with hyphens: `vision-mission.md`
- ✅ Keep names short but descriptive
- ✅ Use standard names ALWAYS
- ✅ Include date in archive names
- ✅ Use `.md` extension for all documents

### DON'T:
- ❌ Use spaces: `Vision Mission.md`
- ❌ Use underscores: `vision_mission.md`
- ❌ Add version numbers to active docs: `vision-mission-v2.md`
- ❌ Create variations: `vision-and-mission-final.md`
- ❌ Change standard names: `our-vision.md`

## Quick Reference for Agents

```markdown
# When creating/updating documents, ALWAYS:

1. Templates are in: `.claude/document-library/`
2. Save documents to: `/documents/foundation/`
3. Archive old versions to: `/documents/archive/YYYY-MM-DD-[name].md`
4. Use EXACT standard names (see mapping table above)
5. Never change the standard naming convention
```

## Foundation Document Review Schedule

| Document | Review Frequency | Owner Agent |
|----------|-----------------|-------------|
| vision-mission.md | Annually | @strategic-opportunity |
| market-research.md | Quarterly | @market-intelligence |
| client-success-blueprint.md | Quarterly | @client-success-intelligence |
| positioning-statement.md | Semi-annually | @strategic-opportunity |
| strategic-roadmap.md | Quarterly | @chassis-intelligence |
| brand-style-guide.md | Annually | @brand-strategy |
| PRDs | Per release | @solution-design |

## Compliance Check

Before marking any document task complete, verify:
- [ ] Correct filename used (see mapping table)
- [ ] Saved in correct directory
- [ ] Old version archived (if updating)
- [ ] Archive named with date prefix
- [ ] No duplicate names or variations
- [ ] Template structure followed
- [ ] SOP guidance incorporated

---

*Filing Standards v1.0 | Ensures consistent document management across all BOS-AI deployments*