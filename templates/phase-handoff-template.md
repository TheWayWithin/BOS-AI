# Phase Handoff template

The Phase Handoff is the **only** sanctioned way to pass context between BOS-AI mission phases. No free-form prose handoffs. No memory files. No `handoff-notes.md` (deprecated).

When a specialist closes a phase, they append a Phase Handoff block to `/workspace/agent-context.md` using the 5-field schema below. The coordinator verifies the block exists before marking the phase complete.

This is the same primitive AGENT-11 v6 uses for cross-stage handoffs. Constitution rule §6 makes it mandatory.

---

## Schema (copy-paste this)

```markdown
## Phase Handoff — [Phase Name]

**Closed**: [YYYY-MM-DD HH:MM]
**By**: @[specialist or coordinator]

### Findings
- [What was discovered, what worked, what didn't]
- [Domain context the next phase needs]

### Decisions
- [Decision]: [rationale]
- [Decision]: [rationale]

### Warnings
- [Risks, constraints, hidden gotchas the next phase must know about]

### Open
- [Unresolved questions or work that carries to the next phase]

### Evidence
- [Pointer to source doc, mission output, or `evidence-repository.md` entry]
- [Or: "None" if no evidence captured]
```

---

## Example (foundation pipeline)

```markdown
## Phase Handoff — Vision/Mission → Market Research

**Closed**: 2026-05-10 14:30
**By**: @brand-strategy

### Findings
- Customer segment is solopreneur consultants (50K target market)
- Core value: time-to-value < 60 minutes for first business document
- Founder identifies as "frustrated by bloated SaaS but pragmatic about AI assistance"

### Decisions
- Vision: "The lean business operating system for solopreneurs"
- Positioning anchor: "BOS-AI runs your business. AGENT-11 builds your software."
- Primary success metric: time from install to first foundation doc complete

### Warnings
- Avoid positioning against legacy BPM tools — wrong frame
- Pricing model not yet decided; flag for pricing-strategy-creation phase
- Voice rules (rule §3) apply to all generated content in this mission

### Open
- Decision needed: does BOS-AI support multi-business solopreneurs (portfolio mode)?
- Need market research validation of "60-minute time-to-value" claim

### Evidence
- /documents/foundation/vision-mission.md (committed this phase)
- evidence-repository.md → vision-mission/segment-interviews.md
```

---

## When to append

| Trigger | Append? |
|---|---|
| Closing a major mission phase | Yes |
| Passing baton between specialists | Yes |
| Mission complete, deliverable shipped | Yes (final block) |
| Mid-phase status update | No — use TodoWrite |
| Internal specialist thinking | No — that's task scratch, not handoff |

---

## Rules

- **Append, don't overwrite.** New blocks at the bottom (chronological).
- **Most recent block is canonical context.** Older blocks remain for audit and pause/resume.
- **All 5 fields required.** If a field is genuinely empty, write "None" — never delete the header.
- **No prose handoffs alongside.** If you find yourself writing a paragraph in `agent-context.md` outside a Phase Handoff block, stop. Put it in Findings or Warnings.
- **No `handoff-notes.md`.** That file is deprecated. Phase Handoffs live inside `agent-context.md`.

The coordinator checks for the Phase Handoff block before closing a phase. Missing block = phase not done.
