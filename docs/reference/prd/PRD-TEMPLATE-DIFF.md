# PRD Template Comparison: v1 vs v3.1

> **Purpose**: Quick reference showing what changed between PRD v1 and v3.1 templates
> **Audience**: Teams transitioning from v1 to v3.1 format

---

## Quick Visual Overview

| Aspect | v1 | v3.1 | Impact |
|--------|-----|------|--------|
| **Total Sections** | 8 | 9 + 3 Appendices | More structured |
| **Feature IDs** | No | Yes (F-001) | Traceability |
| **Business Rules** | Scattered in prose | Dedicated inventory (BR-001) | Clarity |
| **Data Model** | Implicit | Explicit ERD-style | Developer handoff |
| **Acceptance Criteria** | Freeform | GWT format required | Testability |
| **Handoff Checklist** | None | Required section | Quality gate |
| **Glossary** | Appendix | Section 2.1 | Consistency |
| **State Machines** | None | Section 2.4 | Workflow clarity |

---

## Section-by-Section Mapping

### NEW Sections in v3.1 (Not in v1)

| v3.1 Section | Purpose | Why Added |
|--------------|---------|----------|
| **0. PRD At-a-Glance** | Executive summary table | Enables quick context loading |
| **2.1 Glossary** | Term definitions (promoted from appendix) | Ensures consistent understanding |
| **2.2 Conceptual Data Model** | Entity definitions, relationships | Bridges business/technical gap |
| **2.3 UI Structure (Sitemap)** | Route map with access levels | Clarifies navigation architecture |
| **2.4 Business Rules & State Machines** | Dedicated rules with BR-IDs | Prevents rules lost in prose |
| **2.5 External API Dependencies** | Integration specs with rate limits | Enables architecture planning |
| **2.6 Data Privacy & Compliance** | Data classification, GDPR checklist | Regulatory readiness |
| **7. Handoff Readiness Checklist** | Validation gate before AGENT-11 | Prevents incomplete handoffs |
| **Appendix A: Preference Profile** | JSON-structured tech preferences | Automated AGENT-11 setup |

---

### ENHANCED Sections (Changed Significantly)

| v1 Section | v3.1 Section | What Changed |
|------------|--------------|--------------|
| **Product Overview** | **Section 1: Product Overview** | Added Business Chassis Impact table, gap analysis |
| **Features & Requirements** | **Section 3: Features & Requirements** | Now requires F-IDs, Feature Types, Touched Entities, GWT Acceptance Criteria |
| **Testing Strategy** | **Section 4: Testing Requirements** | Now requires T-IDs linked to F-IDs, GWT format, coverage matrix |
| **Technical Considerations** | **Section 6: Technical Considerations** | Added preference vs requirement distinction, measurable NFRs |
| **Open Questions** | **Section 0: Open Questions** | Added [BLOCKING] vs [NON-BLOCKING] tags with owners |
| **Appendix (Glossary)** | **Section 2.1** | Promoted to main body, now includes examples and related terms |

---

### RENAMED Sections (Minor Changes)

| v1 Section | v3.1 Section | Notes |
|------------|--------------|-------|
| **User Flows** | **Section 5: User Flows** | Added structured notation with step tables |
| **Success Metrics** | **Section 8: Success Metrics** | Added Business Chassis tracking |

---

### CONSOLIDATED or REMOVED

| v1 Element | What Happened in v3.1 |
|------------|----------------------|
| **Timeline & Resources** | Kept as Section 9 but now optional (may be separate doc) |
| **Appendix: Research Notes** | Moved to Appendix B: Reference Documents |
| **Appendix: References** | Moved to Appendix B: Reference Documents |

---

## Side-by-Side Structure Comparison

```
v1 TEMPLATE                           v3.1 TEMPLATE
────────────────────────────────────  ────────────────────────────────────
                                      0. PRD At-a-Glance [NEW]
                                         - Executive summary table
                                         - Open Questions with tags
1. Product Overview                   1. Product Overview [ENHANCED]
   - Vision                              - Vision + Problem Gap Analysis
   - Problem Statement                   - Business Chassis Impact
   - Target Users                        - Target Users with personas

                                      2. System Skeleton [NEW SECTION]
                                         2.1 Glossary
                                         2.2 Conceptual Data Model
                                         2.3 UI Structure (Sitemap)
                                         2.4 Business Rules & State Machines
                                         2.5 External API Dependencies
                                         2.6 Data Privacy & Compliance

2. Features & Requirements            3. Features & Requirements [ENHANCED]
   - Feature descriptions                - F-IDs (F-001, F-002)
   - Acceptance criteria                 - Feature Types
                                         - Touched Entities
                                         - GWT Acceptance Criteria
                                         - MVP Feature Set
                                         - Post-MVP Roadmap

3. Testing Strategy                   4. Testing Requirements [ENHANCED]
   - Test approach                       - T-IDs linked to F-IDs
                                         - GWT format test cases
                                         - Test coverage matrix

4. User Flows                         5. User Flows [ENHANCED]
   - Journey diagrams                    - Step tables with success criteria

5. Technical Considerations           6. Technical Considerations [ENHANCED]
   - Technical requirements              - Preferences vs Requirements table
                                         - Measurable NFRs
                                         - Integration requirements

6. Success Metrics                    8. Success Metrics [ENHANCED]
   - KPIs                                - Business Chassis tracking
                                         - User experience metrics

7. Team & Timeline                    9. Timeline & Resources

8. Appendix                           7. Handoff Readiness Checklist [NEW]
   - Glossary                            - Content completeness
   - Research notes                      - Quality gates
   - References                          - Stakeholder sign-off

                                      Appendix A: Preference Profile [NEW]
                                         - JSON configuration

                                      Appendix B: Reference Documents

                                      Appendix C: Change Log

                                      AGENT-11 Handoff Notes [NEW]
```

---

## Key Structural Improvements

### 1. Traceability Chain

v3.1 creates an explicit chain:
```
Feature (F-001) → Touched Entities → Business Rule (BR-001) → Acceptance Criteria (GWT) → Test Case (T-001)
```

v1 had no such chain; features and rules were not explicitly linked.

### 2. Testable Specifications

| Aspect | v1 Approach | v3.1 Approach |
|--------|-------------|---------------|
| Acceptance | "User can log in" | "GIVEN a user on login page, WHEN valid credentials submitted, THEN redirected to dashboard" |
| NFRs | "Fast performance" | "API Response (p50) < 200ms" |
| Rules | "Premium users get priority" | "BR-005: IF user.tier = Premium THEN queue.priority = HIGH" |

### 3. Developer Handoff Readiness

v3.1 adds sections specifically to reduce ambiguity during implementation:
- **Conceptual Data Model**: Developers know entities before coding
- **State Machines**: Valid transitions are explicit
- **Business Rules Inventory**: Rules are not buried in paragraphs
- **Glossary**: Terms have agreed definitions
- **Handoff Checklist**: Validation gate ensures completeness

---

## Migration Checklist

When converting a v1 PRD to v3.1:

### Section 0: At-a-Glance
- [ ] Create executive summary table
- [ ] Extract open questions with [BLOCKING]/[NON-BLOCKING] tags

### Section 2: System Skeleton (NEW)
- [ ] Promote glossary from appendix
- [ ] Create conceptual data model with entities
- [ ] Map UI routes with access levels
- [ ] Extract business rules from prose into BR-ID table
- [ ] Document external API dependencies
- [ ] Complete data privacy classification

### Section 3: Features (ENHANCE)
- [ ] Assign F-IDs to all features (F-001, F-002, etc.)
- [ ] Add feature types (CRUD/AUTH/INTEGRATION/etc.)
- [ ] Identify touched entities for each feature
- [ ] Convert acceptance criteria to GWT format

### Section 4: Testing (ENHANCE)
- [ ] Create T-IDs linked to F-IDs
- [ ] Convert test cases to GWT format
- [ ] Create test coverage matrix

### Section 7: Handoff Checklist (NEW)
- [ ] Complete content completeness checks
- [ ] Verify quality gates
- [ ] Obtain stakeholder sign-off

### Appendix A: Preference Profile (NEW)
- [ ] Create JSON configuration

---

## When to Use Each Template

| Scenario | Recommended Template |
|----------|---------------------|
| Quick internal feature spec | v1 (simpler) |
| AGENT-11 handoff | v3.1 (required) |
| Complex multi-entity system | v3.1 (required) |
| Regulatory/compliance project | v3.1 (audit trail) |
| Prototype/MVP exploration | v1 (faster) |
| Production system with integrations | v3.1 (required) |

---

*Document created as part of PRD Process Improvement Initiative - Phase 1*
