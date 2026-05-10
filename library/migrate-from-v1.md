# Migrating from BOS-AI v1.x to v2

**Status:** v2 modernisation in progress (Sprints A-I per [Blueprint v2.1](../ideation/BOS-AI%20v2.1%20Blueprint%20-%20Lean%20Business%20Operating%20System.md))
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

## What else changed in Sprint A and B

- **`workspace/`** archived to `archive/workspace-2025/` and recreated with two files (`business-plan.md`, `agent-context.md`) — see Blueprint §2.4.
- **`docs/MEMORY-SYSTEM.md`** removed.
- **`templates/memory-integration-template.md`** removed.
- **`templates/mission-template-enhanced.md`** removed (was built around the memory paradigm; new mission template arrives in Sprint G with Phase Handoff schema).
- **`templates/deployment-summary.md`** archived (Oct 2025 deployment artifact, no longer relevant).
- 11 agents had `MEMORY INTEGRATION PROTOCOL` blocks stripped (~17 lines each). Agent functionality unchanged — they just no longer pretend to maintain XML state.

---

## Coming in later sprints

- **Sprint C:** Strip remaining `MANDATORY CONTEXT PROTOCOL` boilerplate from all 30 agents.
- **Sprint D:** Rewrite `coord.md` as Universal Router (deterministic dispatch, no NLP intent matching).
- **Sprint E:** Karpathy Business Constitution in `library/CLAUDE.md`.
- **Sprint F:** Voice-enforcement hooks (block "we"/"our team"/em-dashes deterministically).
- **Sprint G:** Phase Handoff 5-field schema in mission templates.
- **Sprint H:** Convert `/dailyreport` to a Routine; `/blog` stays a slash command.
- **Sprint I:** Modernise the deployable `library/CLAUDE.md`.

See `ideation/BOS-AI v2.1 Blueprint - Lean Business Operating System.md` for the full plan and rationale.
