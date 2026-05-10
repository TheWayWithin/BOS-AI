# Migrating from BOS-AI v1.x to v2

**Status:** v2 modernisation complete (Sprints A-I shipped per [Blueprint v2.1](../ideation/BOS-AI%20v2.1%20Blueprint%20-%20Lean%20Business%20Operating%20System.md))
**Last updated:** 2026-05-10

This guide is for users who installed BOS-AI before the v2 modernisation. If you're installing fresh, ignore this file.

---

## What's changing

### The XML memory system has been deleted

In v1.x, BOS-AI shipped with a `/memories/` directory holding 12 XML files (`vision.xml`, `customers.xml`, `decisions.xml`, etc.) that agents were instructed to read and update for "institutional memory."

In v2, this is **gone**. The reasons:

- The XML files were almost always placeholder text — agents rarely populated them with real state
- LLMs are unreliable at maintaining structured XML databases through prompt instruction
- The memory boilerplate added ~17 lines per agent (192 lines across the agent fleet) for negligible benefit
- The actual source of truth is your **foundation documents** in `/documents/foundation/` (vision, PRD, marketing bible, etc.) — read those instead

### What replaces it

Agents now read foundation documents directly. Mission-level coordination uses:

- **`workspace/business-plan.md`** — active mission checklist
- **`workspace/agent-context.md`** — accumulated findings + Phase Handoff blocks (5-field schema: Findings / Decisions / Warnings / Open / Evidence)
- **`progress.md`** — append-only changelog and lessons learned
- **`/documents/foundation/`** — source of truth for business state

---

## If you have a populated `/memories/` directory

If your local `/memories/*.xml` files contain **real business state** (not placeholders), preserve it before upgrading:

### One-time migration

1. **Inspect each file.** If the file still contains `PLACEHOLDER_*` text throughout, it has no real content — skip it.

2. **For files with real content:** open the matching foundation document and copy the meaningful fields across.

   | XML file | Likely target |
   |---|---|
   | `memories/business/vision.xml` | `documents/foundation/vision-mission.md` |
   | `memories/business/markets.xml` | `documents/foundation/market-research.md` |
   | `memories/business/customers.xml` | `documents/foundation/client-success-blueprint.md` |
   | `memories/strategies/marketing.xml` | `documents/business-assets/marketing-bible.md` |
   | `memories/strategies/sales.xml` | `documents/business-assets/sales-bible.md` |
   | `memories/lessons/decisions.xml` | `progress.md` (append) |
   | `memories/lessons/insights.xml` | `progress.md` (append) |
   | `memories/lessons/patterns.xml` | `progress.md` (append) |

3. **Delete `/memories/`.** Once content is migrated:
   ```bash
   rm -rf memories/
   ```

4. **Pull the v2 update.** Run the BOS-AI installer to refresh agents, commands, and templates.

### If you don't care

Just delete `/memories/` and pull v2 — everything in there was placeholder anyway.

---

## What else changed (Sprints A through I)

### Sprint A — workspace cleanup

- **`workspace/`** archived to `archive/workspace-2025/` and recreated with two files: `business-plan.md` and `agent-context.md`.
- `.gitignore` now ignores `workspace/checkpoint-*.md`, `.claude/backups/`, generated `blog/`, and `progress/*.md`.

### Sprint B — XML memory deletion

- `/memories/` removed, 12 XML files gone.
- `docs/MEMORY-SYSTEM.md`, `templates/memory-integration-template.md`, `templates/mission-template-enhanced.md`, `templates/deployment-summary.md` removed or archived.
- 11 agents had `MEMORY INTEGRATION PROTOCOL` blocks stripped.

### Sprint C — agent boilerplate strip

- All 30 agents had their `## MANDATORY CONTEXT PROTOCOL` block (and equivalent on `chassis-intelligence`) replaced with a one-paragraph `## Context` section pointing at `/documents/foundation/` and the Phase Handoff 5-field schema.
- Net: 925 lines removed, agent fleet ~21% smaller.
- Agent functionality unchanged — only ceremony removed.

### Sprint D — `coord.md` as Universal Router

- `commands/coord.md` rewritten from 463 lines to 149.
- Deterministic dispatch table: `/coord <mission-name>` → mission file. No NLP intent matching, no fuzzy lookup.
- Direct-spawn rule: `/coord` runs at the top level, never inside a subagent. Specialists do not spawn other specialists.
- All ASCII box gates removed.
- Old mission name aliases that referenced archived workspace files (e.g. `/coord optimize`) are gone — use the canonical names from the router (e.g. `/coord chassis-optimization`).

### Sprint E — Karpathy Business Constitution

- Seven-rule constitution inserted into `library/CLAUDE.md`.
- `.claude/CLAUDE.md` pointer added so editors of BOS-AI runtime files apply the same rules.

### Sprint F — voice-enforcement hook

- `library/hooks/check-voice.sh` + `library/hooks/README.md` added.
- Hook wired into `.claude/settings.json` (`PostToolUse`, blocking on `*.md` Edit/Write/MultiEdit).
- Scope: `blog/`, `progress/`, `documents/business-assets/`, `documents/foundation/` only. All other paths bypass silently.
- Bans: `we`, `our team`, `the team`, `leverage`, `unlock`, `empower`, `seamless`, `robust`, `utilize`, `delve`, `navigate`, `ecosystem`, em-dash.

### Sprint G — Phase Handoff template

- `templates/phase-handoff-template.md` added — canonical 5-field schema (Findings / Decisions / Warnings / Open / Evidence).
- All 8 foundation missions reference the template at phase close.

### Sprint H — voice infra consolidation + `/dailyreport` Routine

- `data/voice-guide-default.md` → `library/voice/voice-guide-default.md`. Empty root `data/` removed.
- `commands/blog.md` and `commands/dailyreport.md` voice resolution chains updated: `library/voice/` precedes the `.claude/data/` fallback.
- New `routines/dailyreport.md` — Routine template for scheduled daily reports. Set up at `claude.ai/code/routines`.
- `/blog` stays a slash command (event-driven, not a Routine candidate).

### Sprint I — `library/CLAUDE.md` modernisation

- Deployable file now references the Constitution, Universal Router, Phase Handoff template, and migration guide as discoverable resources.
- Stale `/coord optimize` references updated to `/coord chassis-optimization`.
- Key Locations table extended with `/routines/`, `library/voice/`, `library/hooks/`.

---

## How to upgrade

If you're on a pre-v2 BOS-AI install and want the v2 changes:

1. **Backup** your current `.claude/`, `workspace/`, and `memories/` directories.
2. **Migrate `memories/` content** (if any non-placeholder data exists) into foundation documents using the table in "If you have a populated `/memories/` directory" above.
3. **Pull the v2 BOS-AI release** (or copy the updated library files).
4. **Reinstall the hook** if you want voice enforcement: `cp library/hooks/check-voice.sh .claude/hooks/` and add the snippet to `.claude/settings.json` from `library/hooks/README.md`.
5. **Set up the Routine** (optional, recommended): copy the prompt from `routines/dailyreport.md` into a new routine at `claude.ai/code/routines`.

If anything in `.claude/` or `workspace/` was customised, diff your backup against the new defaults and re-apply your customisations to the v2 files.

See `ideation/BOS-AI v2.1 Blueprint - Lean Business Operating System.md` for the full plan and rationale.

---

## Known follow-up cleanup (not blocking)

The v2 modernisation is structurally complete. A few mission files (mostly in `missions/sequences/` and `missions/operations/`) still reference archived workspace files like `chassis-metrics.md`, `handoff-notes.md`, `mission-dashboard.md`, and `agent-sequence.md`. These files no longer exist; the mission instructions need updating to use the v2 Phase Handoff pattern (write to `/workspace/agent-context.md` instead).

Affected files at time of writing:
- `missions/bos-ai-mission-library.md`
- `missions/operations/foundation-review.md`
- `missions/sequences/chassis-optimization-sequence.md`
- `missions/sequences/customer-acquisition-sequence.md`
- `missions/sequences/retention-improvement-sequence.md`
- `missions/sequences/weekly-review-sequence.md`
- `missions/sequences/product-launch-sequence.md`
- `docs/bos-ai-orchestration-guide.md`

These mission files will execute and produce outputs, but the workspace-update steps will fail silently (files referenced no longer exist). Specialists should ignore those steps and use the Phase Handoff pattern instead, per the Karpathy Business Constitution rule §6.

Fixing them is a future polish sprint, not a blocker.
