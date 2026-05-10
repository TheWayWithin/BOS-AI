# BOS-AI v2.1 Blueprint: The Lean Business Operating System

**Date**: 2026-05-10
**Supersedes**: `BOS-AI v2 Blueprint_ The Lean Business Operating System.md` (2026-04-17, Manus AI)
**Status**: Empirically grounded — folds in lessons from shipping Agent-11 v6.0/6.1 sprints 4a-4h, plus a current-state audit of the BOS-AI library.

---

## Why this revision exists

Blueprint v1 was written before Agent-11 v6 actually shipped, and before BOS-AI was checked out for inspection. It got the diagnosis broadly right (context-tax, XML dead weight, Karpathy constitution, Routines) but missed five things that only became obvious by doing the work, and got one prescription frankly wrong.

This v2.1 keeps the v1 spirit, replaces the half-blind prescriptions with empirical ones, and grounds every claim in evidence pulled from the live BOS-AI repo.

---

## Section 0: The seven empirical lessons (from Agent-11 v6 sprints)

These come from sprints 4a-4h. Each one changes how we should approach BOS-AI v2.

1. **Pre-execution platform check.** Sprint 4f built dynamic-mcp.json against Claude API's per-tool `defer_loading` — which doesn't apply to Claude Code's `.mcp.json`. Caught mid-sprint by audit. **Rule for BOS-AI:** before building any infra against an Anthropic primitive, verify the surface exists where you think it does.

2. **Universal Router pattern.** Sprint 4c's biggest win was deterministic mission dispatch (`/coord vision`, not NLP intent matching). Blueprint v1 missed this entirely. **For BOS-AI:** `/coord` should route by literal mission name to a deterministic handler, not soft-match user intent.

3. **"Single-agent deep-thinking task" is wrong.** Blueprint v1 line 49 said rewrite vision/PRD missions as single-agent. v6 kept role-specialised agents and killed the *ceremony* instead. Strategist→Documenter handoff is fine if the handoff is structured. **For BOS-AI:** keep specialist agents for foundation pipelines; what dies is the boilerplate, not the roles.

4. **`/blog` is not a Routine.** Blueprint v1 conflated `/dailyreport` (scheduled — yes, Routine candidate) with `/blog` (event-driven on a topic — no, just a slash command). **For BOS-AI:** classify each command per-cadence, not in bulk.

5. **Quality-gate hooks under-leveraged.** v6 ships hooks for tsc/ruff. **For BOS-AI:** the equivalent is hooks that *deterministically* block Write/Edit if "we" / "our team" / "ecosystem" / em-dashes appear in generated content — instead of leaving voice rules to prompt instruction the model can ignore.

6. **Phase Handoff blocks.** Sprint 4e's structured 5-field schema (Findings / Decisions / Warnings / Open / Evidence) is exactly the primitive a foundation-doc pipeline (vision → PRD → marketing bible) needs to pass decisions cleanly between stages.

7. **Direct-spawn pattern.** Top-level Claude spawning specialists via Task tool works; coordinator-as-subagent breaks (verified empirically). Blueprint v1 silent. **For BOS-AI:** `/coord` runs at top-level only; specialist agents are spawned by `/coord`, not by another agent.

---

## Section 1: Current-state audit (what BOS-AI actually looks like, 2026-05-10)

Not theoretical. Numbers pulled from the repo this session.

### Surface area

| Area | Count | Lines / Size | Notes |
|---|---|---|---|
| Agents | 30 | ~3,930 lines (avg 131, max 228) | All 30 carry "MANDATORY CONTEXT PROTOCOL" boilerplate |
| Commands | 6 | 2,098 lines (`dailyreport` 585, `coord` 463, `blog` 461) | |
| Missions | 103 .md files | — | 8 in `foundation/`, rest split across 11 subdirs |
| Memory XML | 12 files | ~48KB total | All dated Oct 11 2025 — never modified |
| Workspace | 19 .md files | ~558KB total | Mostly Sept-Oct 2025 leftovers |
| Deployable library | 1 file | `library/CLAUDE.md` (241 lines) | Single deployment target |

### Confirmed v1 claims

- **30 agents** — exact.
- **12 XML memory files** — exact (`memories/business/{vision,markets,operations,customers}.xml`, `memories/strategies/{growth,marketing,sales,failures}.xml`, `memories/lessons/{decisions,insights,patterns}.xml`, `memories/technical/integrations.xml`).
- **4 ASCII box gates** in `coord.md` — exact (`grep -c "╔══"` returns 4).
- **30/30 agents** carry the `MANDATORY CONTEXT PROTOCOL` header, but only **11/30** actually reference `memories/`. The boilerplate is wider than the dependency.

### What v1 didn't catch

- **`/memories/` is purely placeholder.** Every file is full of `PLACEHOLDER_DATE`, `PLACEHOLDER_MISSION`, `PLACEHOLDER_VISION` — no real business state has ever been written into them. Deletion risk: zero.
- **No checkpoint files exist.** v1 assumed a checkpoint generator was running. `find` returns 0 files matching `checkpoint-*.md`. Either pruned or never enforced. This means part of v1's "delete the checkpoint system" prescription is moot — it's already not producing output.
- **Workspace is a graveyard, not a workspace.** Standout offenders:
  - `workspace/handoff-notes.md` — **200KB**, never archived, just grew.
  - `workspace/claude-md-improvement-strategy.md` — 106KB.
  - `workspace/README-NEW.md` — 71KB.
  - `workspace/CLAUDE-NEW.md` — 37KB.
  - 5 `mcp-*.md` files (~36KB) from a long-finished migration.
  - 4 huge "assessment" docs (~280KB combined) that should have been folded back into the source and deleted months ago.
- **`/library/` deploys exactly one file.** `library/CLAUDE.md`. Whatever we strip from BOS-AI's internal structure, this single file is what users actually get — modernisation must end here.
- **Hooks: none for voice.** `.claude/settings.json` does not block corporate-speak today. This is open territory for empirical lesson #5.

---

## Section 2: Revised prescriptions

Mapped against v1 and corrected against the seven lessons.

### 2.1 Kill the ceremony, keep the roles (corrects v1 §3)

**v1 said:** Rewrite vision/PRD missions as single-agent deep-thinking tasks.
**v2.1 says:** Keep the specialist agents. Strip the ceremony.

What that means concretely:

- **Remove from all 30 agents:** the `## MANDATORY CONTEXT PROTOCOL` block, `### Required Document Access` lists, "MEMORY INTEGRATION PROTOCOL: **MANDATORY**" sections.
- **Replace with:** a single line — "Read foundation documents in `/documents/foundation/` before strategic recommendations" — only on agents that actually need it. The 19 agents that don't reference `memories/` get nothing.
- **Foundation pipeline (vision → PRD → marketing) keeps its specialist roles** but uses Phase Handoff blocks (lesson 6) for clean stage transitions, not ad-hoc workspace files.

**Estimated reduction:** ~30-50 lines per agent × 30 agents = ~900-1,500 lines deleted. Median agent drops from 131 to ~85 lines.

### 2.2 Delete the XML memory system (extends v1 §2)

v1 was right. Audit confirms zero state has ever been written. Delete:

- `memories/` directory entirely (12 files, ~48KB)
- All `memories/*.xml` references in the 11 agents that mention them
- Any installer/setup logic that creates `memories/` on deployment

Migration note for users on v1.x: a `migrate-from-v1.md` is needed because some users *might* have populated their local copy. Recommend a "fold any real content into `/documents/foundation/`, then delete `memories/`" instruction.

### 2.3 Slim coord.md (extends v1 §1)

Current: 463 lines, 4 ASCII box gates, mandatory planning phase block, mission state check block.

Target: ~150 lines. Apply:

- Universal Router (lesson 2): deterministic dispatch table, `/coord <mission>` → handler. No NLP intent matching.
- Drop all 4 ASCII box gates. Replace with a 6-line constitution reference.
- Direct-spawn discipline (lesson 7): `/coord` runs top-level, spawns specialists via Task tool, never delegates coordination to a subagent.

### 2.4 Workspace consolidation (extends v1 §1)

v1 said "shrink to 2 workspace files." Reality is messier: most workspace files are abandoned.

**v2.1 plan:**

1. **Archive everything in `workspace/` to `archive/workspace-2025/` once.** Don't delete — there might be real research buried in `marketing-framework-analysis-report.md` etc.
2. **Re-create empty `workspace/` with two files only:** `business-plan.md` (active checklist), `agent-context.md` (active findings). Both rotate via `/planarchive` when stale.
3. **Add `.gitignore` for `workspace/checkpoint-*.md`** in case checkpoint generation comes back; we don't want it in git history.

### 2.5 Karpathy Business Constitution (extends v1 §4)

v1's five rules are good. Add three from empirical experience:

6. **Read foundation docs before strategy.** Not memory/XML — the markdown in `/documents/foundation/`.
7. **Phase Handoffs use the 5-field schema.** Findings / Decisions / Warnings / Open / Evidence. No free-form prose handoffs.
8. **Coordinator runs top-level only.** Never spawn `/coord` from inside a subagent.

Land in `library/CLAUDE.md` (the deployable file) AND in `.claude/CLAUDE.md` (dev workflow).

### 2.6 Per-command cadence classification (corrects v1 §3)

v1 lumped `/dailyreport` and `/blog` together as "automate as Routines." Wrong.

| Command | Cadence | v2.1 disposition |
|---|---|---|
| `/dailyreport` | Scheduled (end of day) | Routine candidate. Convert. |
| `/blog` | On-demand topic | Stays a slash command. No Routine. |
| `/coord` | On-demand | Slash command. |
| `/meeting` | On-demand | Slash command. |
| `/report` | Stakeholder-triggered | Slash command (could be Routine if user asks). |
| `/pmd` | On-incident | Slash command. |

Extract shared voice-guide chain into `library/voice/` so both `/dailyreport` and `/blog` use it without duplication.

### 2.7 Voice-enforcement hooks (NEW, from lesson 5)

Add to `.claude/settings.json` and to the deployed library equivalent:

```jsonc
"PostToolUse": [
  {
    "matcher": "Edit|Write",
    "hooks": [
      {
        "command": "scripts/check-voice.sh",
        "blocking": true
      }
    ]
  }
]
```

`scripts/check-voice.sh` greps the changed file for: `\bwe\b`, `\bour team\b`, `\becosystem\b`, `\bleverage\b`, `\bunlock\b`, `\bempower\b`, `—` (em-dash). Exits 2 if any found in `*.md` outside `archive/`. Deterministic. No prompt instruction needed.

### 2.8 Phase Handoff blocks for foundation pipeline (NEW, from lesson 6)

Vision → PRD → Marketing Bible → Pricing currently relies on prose handoff in `agent-context.md`. Replace with structured blocks:

```markdown
## Phase Handoff: Vision → PRD
**Findings:** [bullet list]
**Decisions:** [bullet list with rationale]
**Warnings:** [bullet list of risks/constraints for next stage]
**Open:** [bullet list of unresolved questions]
**Evidence:** [links to source docs / sections]
```

Same primitive Agent-11 v6 uses. Add to `templates/` and reference from foundation mission files.

---

## Section 3: Action plan

Sequenced sprints. Each sprint is shippable on its own; user decides which to start.

### Sprint A — Workspace cleanup (LOW RISK, FAST)
- Archive `workspace/*` to `archive/workspace-2025/`
- Re-create `workspace/` with 2 active files
- Add `.gitignore` rules
- Time: ~30 min. Reversible: full archive preserved.

### Sprint B — Memory XML deletion (LOW RISK)
- Delete `/memories/` directory (verify backup first)
- Strip XML references from 11 agents
- Add `/migrate-from-v1.md` user note
- Time: ~1 hour.

### Sprint C — Agent boilerplate strip (MEDIUM RISK)
- Remove `MANDATORY CONTEXT PROTOCOL` blocks from all 30 agents
- Replace with one-line foundation-doc reference (only where needed)
- Validate sample agents still work via `/meeting @agent`
- Time: ~2 hours. Reversible via git.

### Sprint D — coord.md rewrite (MEDIUM RISK)
- Rewrite as Universal Router (~150 lines)
- Drop 4 ASCII box gates
- Document direct-spawn pattern
- Time: ~2 hours. Test with one mission end-to-end.

### Sprint E — Karpathy Business Constitution (LOW RISK)
- Update `library/CLAUDE.md` (deployable) and `.claude/CLAUDE.md` (dev)
- 8 rules per §2.5
- Time: ~30 min.

### Sprint F — Voice hooks (MEDIUM RISK)
- Verify Claude Code hook surface (lesson 1: pre-execution platform check)
- Write `scripts/check-voice.sh`
- Wire into `.claude/settings.json`
- Add deployed equivalent for user installs
- Time: ~1.5 hours. Pause point: confirm hook blocks correctly on test file before merging.

### Sprint G — Phase Handoff schema (LOW RISK)
- Add template to `templates/`
- Update foundation mission files to reference it
- Time: ~1 hour.

### Sprint H — Per-command cadence + Routine setup (MEDIUM RISK)
- Convert `/dailyreport` to Routine
- Leave `/blog` as slash command
- Extract shared voice-guide infra to `library/voice/`
- Time: ~2-3 hours.

### Sprint I — `/library/CLAUDE.md` modernisation (LOW RISK)
- Bring deployable in line with v2.1 prescriptions
- Reference Karpathy Business Constitution
- Update install-side migration note
- Time: ~1 hour.

**Total estimated time:** 12-14 hours of focused work, splittable across multiple sessions.

**Critical-path order if doing all:** A → B → E → I (foundation), then C → D in parallel, then G → F → H.

---

## Section 4: What does NOT change

Important to be explicit:

- **The Business Chassis formula** stays. It's the conceptual core of BOS-AI and unrelated to the bloat.
- **The 30 agent roles** stay. We're stripping the ceremony, not the specialists.
- **Foundation document templates** (PRD v3.1, Vision template, etc.) stay. They're the crown jewels.
- **The 8 foundation missions** stay. Roles preserved per lesson 3.
- **`/dailyreport` voice-guide system** stays. Just gets extracted for shared use.
- **The "Auto vs Engaged" mode selection** for foundation missions stays. v1 was right about this.

---

## Section 5: Risks and open questions

### Risks

1. **User has populated `/memories/` files locally.** Mitigation: migration note (Sprint B) + user-side script that copies non-placeholder content into `/documents/foundation/` before deletion.
2. **Voice hook false-positives.** "We" appears legitimately in some contexts (reported speech, quotations). Mitigation: hook only blocks in generated content paths (`/blog/`, `/progress/`), not in `archive/` or quoted material.
3. **Routine for `/dailyreport` requires Anthropic Routines surface.** Lesson 1 applies — verify the surface exists for BOS-AI's deployment context before building against it.
4. **Sprint C touches all 30 agents at once.** Mitigation: do one agent first, validate via `/meeting`, then batch the rest.

### Open questions for the user

1. Has anyone run BOS-AI v1.x against a real business (i.e., `/memories/*.xml` populated with non-placeholder content)? Affects Sprint B migration design.
2. Should `/library/` grow to include hooks and voice scripts, or stay as a single CLAUDE.md? Affects Sprint F and I.
3. Is the foundation mission Auto/Engaged toggle being used in practice, or is one mode dominant? Could simplify Section 4 promise.
4. Any third-party integrations (Slack notifications, etc.) currently relying on `workspace/` files? Affects Sprint A.

---

## Summary table: v1 vs v2.1

| Topic | v1 (theoretical) | v2.1 (empirical) |
|---|---|---|
| XML memory | Delete | Delete (confirmed: zero real content) |
| Mandatory protocol | Remove from 30 agents | Remove from 30, narrow to 1-line on relevant 11 |
| Workspace | Shrink to 2 files | Archive existing, re-create with 2 |
| Foundation missions | Single-agent rewrite | **Keep roles, kill ceremony** (corrected) |
| `/blog` + `/dailyreport` | Both → Routines | **Only `/dailyreport` → Routine** (corrected) |
| Karpathy constitution | 5 rules | **8 rules** (added: foundation read, handoff schema, top-level coord) |
| Voice rules | Prompt instruction | **Deterministic hooks** (new) |
| Coord pattern | Slim it | **Universal Router + direct-spawn** (new) |
| Phase handoffs | Not addressed | **5-field structured blocks** (new) |
| Platform check | Not addressed | **Verify before building** (new) |

---

## Decision point

This document is the plan. No code or content has been touched in the BOS-AI library yet. Next decision is yours:

- **Greenlight all sprints** → start at Sprint A.
- **Greenlight a subset** → pick which.
- **Pause for more research** → answer the four open questions in §5 first.
- **Reject** → fold useful elements into a v2.2 or shelve.
