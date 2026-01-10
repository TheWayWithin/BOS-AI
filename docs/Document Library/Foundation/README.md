# Foundation Document Library

**Strategic Foundation Templates and SOPs for Business Development**

The Foundation Library contains templates and Standard Operating Procedures (SOPs) for building your strategic business foundation—the WHAT and WHY before you implement the HOW.

---

## Quick Start

**New to BOS-AI?** Start with these in order:

1. **Vision & Mission** → Defines your purpose and direction
2. **Market Research** → Understands your market and customers
3. **Client Blueprint** → Defines your ideal customer
4. **Positioning** → Differentiates you from competitors
5. **Strategic Roadmap** → Plans your path to goals
6. **PRD** → Specifies what to build (if applicable)

---

## Document Categories

### 🎯 Strategic Foundation

| Document | Template | SOP | Purpose |
|----------|----------|-----|---------|
| **Vision & Mission** | [Template](Vision%20and%20Mission.md) | [SOP](Vision%20and%20Mission%20Development%20SOP%20(Rapid%20AI-Driven).md) | Define purpose and direction |
| **Market Research** | [Template](Market%20and%20Client%20Research%20Template.md) | [SOP](Market%20and%20Client%20Research%20SOP%20(Rapid%20AI-Driven).md) | Understand market landscape |
| **Client Blueprint** | [Template](Client%20Success%20Blueprint.md) | [SOP](Client%20Success%20Blueprint%20Creation%20SOP%20(Revised).md) | Define ideal customer |
| **Positioning** | [Template](Positioning%20Statement%20Template.md) | [SOP](Positioning%20Statement%20SOP%3A%203-Hour%20Sprint.md) | Differentiate from competitors |
| **Strategic Roadmap** | [Template](Strategic%20Roadmap%3A%20Vision%20to%20Great.md) | [SOP](Strategic%20Roadmap%20Creation%20SOP%20(AI-Driven).md) | Plan path to goals |
| **Brand Style Guide** | [Template](Brand%20Style%20Guide.md) | [SOP](Brand%20Style%20Guide%20Creation%20SOP%20(AI-Driven).md) | Define brand identity |
| **Pricing Strategy** | [Template](Pricing%20Strategy%20Template.md) | [SOP](Pricing%20Strategy%20Creation%20SOP%20(AI-Driven).md) | Set value-based pricing |

---

### 📋 Product Requirements (PRD)

The PRD template (v3.1) adds **"System Skeleton"** sections that enable direct code generation:

| File | Purpose |
|------|---------|
| [Product Requirements Document (PRD).md](Product%20Requirements%20Document%20(PRD).md) | Complete PRD template (v3.1) |
| [PRD Creation SOP.md](PRD%20Creation%20SOP.md) | Creation process (v2.1) with Auto/Engaged modes |

**Key Features:**
- **Section 0: At-a-Glance** - Executive summary table
- **Section 2: System Skeleton** - Data model, UI sitemap, business rules, API dependencies, privacy
- **Feature IDs** - Unique identifiers (F-001, F-002) for traceability
- **GWT Acceptance Criteria** - Given-When-Then format for automation
- **Handoff Readiness Checklist** - Pre-handoff validation gate

**PRD Commands:**
```bash
/coord prd-creation                    # Full creation (Auto or Engaged)
/coord prd-creation --update-skeleton  # Update Section 2 only
/coord prd-creation --update-features  # Update Section 3 only
/coord prd-creation --add-feature      # Add single feature
```

**Reference Materials** (in `/docs/reference/prd/`):
- Migration Guide - For upgrading legacy v1 PRDs
- Template Diff - v1 vs current comparison
- Before/After Examples - Transformation examples

**Archived Versions** (in `archive/`):
- Previous PRD template and SOP versions with date stamps

---

### 🎨 Design Playbook (Technical Preferences)

The Design Playbook is an **optional companion** to the PRD that captures non-binding technical preferences:

| File | Purpose |
|------|---------|
| [Design Playbook Template.md](Design%20Playbook%20Template.md) | Template for technical preferences |
| [Design Playbook Creation SOP.md](Design%20Playbook%20Creation%20SOP.md) | How to create a Design Playbook |

**PRD vs Design Playbook:**
- **PRD** = WHAT and WHY (binding requirements)
- **Design Playbook** = HOW preferences (non-binding hints)

Developers may override any Design Playbook preference with justification. PRD always takes precedence.

---

### ⚙️ Solopreneur Defaults

When using Auto mode in PRD creation, unanswered discovery questions use intelligent defaults:

| File | Purpose |
|------|---------|
| [Solopreneur-Defaults.json](Solopreneur-Defaults.json) | Machine-readable default preferences |

**Default Categories:**
- Business Model (B2C SaaS, freemium pricing)
- Technical Stack (TypeScript, serverless)
- UX Standards (mobile-first, accessibility AA)
- Timeline (6-8 week MVP)
- Compliance (GDPR, standard security)

---

## BOS-AI Mission Commands

Use these commands to create foundation documents:

| Mission | Command | Time |
|---------|---------|------|
| Vision & Mission | `/coord vision-mission-creation` | 90 min |
| Market Research | `/coord market-research-creation` | 2 hours |
| Client Blueprint | `/coord client-blueprint-creation` | 90 min |
| Positioning | `/coord positioning-creation` | 90 min |
| Strategic Roadmap | `/coord roadmap-creation` | 2 hours |
| Brand Style Guide | `/coord brand-guide-creation` | 2 hours |
| Pricing Strategy | `/coord pricing-strategy-creation` | 90 min |
| **PRD (v3.1)** | `/coord prd-creation` | 2-4 hours |
| **Design Playbook** | `/coord design-playbook-creation` | 1-2 hours |
| **Quick Start (All)** | `/coord foundation-quick-start` | 3-4 hours |

---

## Document Library Structure

```
/docs/Document Library/Foundation/
├── README.md                           # This file
│
├── Vision and Mission.md               # Strategic purpose template
├── Vision and Mission Development SOP.md
│
├── Market and Client Research Template.md
├── Market and Client Research SOP.md
│
├── Client Success Blueprint.md         # Ideal customer definition
├── Client Success Blueprint Creation SOP.md
│
├── Positioning Statement Template.md
├── Positioning Statement SOP.md
├── Positioning AI Prompts.md
│
├── Strategic Roadmap_ Vision to Great.md
├── Strategic Roadmap Creation SOP.md
│
├── Brand Style Guide.md
├── Brand Style Guide Creation SOP.md
│
├── Pricing Strategy Template.md        # Value-based pricing
├── Pricing Strategy Creation SOP.md
│
├── Product Requirements Document (PRD).md   # Current template (v3.1)
├── PRD Creation SOP.md                      # Current process (v2.1)
├── Solopreneur-Defaults.json                # Auto mode defaults
│
├── Design Playbook Template.md              # Technical preferences
├── Design Playbook Creation SOP.md
│
└── archive/                                 # Superseded versions
    ├── Product Requirements Document (PRD) [2026-01-02].md
    └── PRD Creation SOP [2026-01-02].md
```

**Reference Materials** (not deployed, for development):
```
/docs/reference/prd/
├── PRD v3.1 Migration Guide.md
├── PRD-TEMPLATE-DIFF.md
├── PRD-TEMPLATE-GUIDE.md
├── PRD-BEFORE-AFTER-EXAMPLES.md
└── CHANGELOG.md
```

---

## Version History

| Date | Version | Changes |
|------|---------|---------|
| 2026-01-10 | v3.1 | Added PRD v3.1 template, SOP v2.1, Design Playbook, Solopreneur Defaults |
| 2026-01-05 | v3.0 | Added Pricing Strategy template and SOP |
| 2025-08-29 | v2.0 | Added Positioning templates and AI prompts |
| 2025-08-28 | v1.0 | Initial foundation library |

---

## Related Resources

- [Operations Library](../Operations/) - Marketing, Sales, Customer Service, Finance frameworks
- [CLAUDE.md](../../../CLAUDE.md) - Complete BOS-AI documentation
- [Missions Library](../../../missions/) - All available BOS-AI missions

---

*Foundation documents define WHAT and WHY. Operations documents define HOW to execute.*
