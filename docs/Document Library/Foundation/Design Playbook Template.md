# Design Playbook: [Product Name]

**Version:** [1.0]
**Date:** [YYYY-MM-DD]
**Author:** [Name/Team]
**PRD Reference:** [PRD v3.1 - Product Name]
**Last Updated:** [YYYY-MM-DD]

---

## Document Control

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| [1.0] | [YYYY-MM-DD] | [Name] | Initial creation |
| | | | |

---

## 🎯 Purpose & Scope

### What This Document IS

This Design Playbook provides **non-binding technical preferences and architectural hints** to guide implementation of the associated PRD. It captures:

- **Preferred technologies** with rationale for suggestions
- **Architectural patterns** that align with business requirements
- **Integration approaches** based on team experience or constraints
- **Security baselines** that meet minimum standards
- **Performance expectations** that inform technical decisions

**Key Principle:** All content in this document represents **PREFERENCES, NOT REQUIREMENTS**. The PRD defines WHAT must be built and WHY. This playbook suggests HOW we prefer to build it.

### What This Document IS NOT

- ❌ **NOT a replacement for the PRD** - Business requirements live in the PRD
- ❌ **NOT binding technical specifications** - Developer agents may override any preference
- ❌ **NOT a substitute for technical architecture** - AGENT-11 @architect owns final design
- ❌ **NOT a constraint on innovation** - Better solutions should always win
- ❌ **NOT comprehensive technical documentation** - Implementation details emerge during build

### Relationship to PRD

```
PRD (BINDING)                    Design Playbook (NON-BINDING)
├─ Business Requirements    →    Technical Preferences
├─ Success Criteria        →    Performance Targets
├─ User Stories            →    Architecture Patterns
├─ Acceptance Criteria     →    Integration Hints
└─ Constraints             →    Developer Notes

HIERARCHY: PRD > Design Playbook > Developer Judgment
```

**When in Conflict:**
1. PRD requirements ALWAYS take precedence
2. If preference blocks PRD requirement, override preference
3. Document override in Appendix: Preference Override Log
4. Update playbook to reflect new learning

---

## 🔓 Override Protocol

### Developer Rights

**Developer agents (@developer in AGENT-11) have FULL authority to:**
- Override any preference in this document
- Choose different technologies/patterns
- Propose alternative approaches
- Make architectural decisions

**Required: Document justification when overriding preferences**

### Override Process

1. **Identify Conflict**: Preference doesn't serve PRD requirement or business need
2. **Evaluate Alternative**: Better solution exists (performance, maintainability, cost, etc.)
3. **Document Decision**: Record in Appendix: Preference Override Log
4. **Implement**: Proceed with superior approach
5. **Update Playbook** (optional): Share learning for future projects

### Override Documentation Template

```markdown
**Preference Overridden:** [Original preference from playbook]
**Reason:** [Why preference was overridden - technical, business, or practical]
**Alternative Chosen:** [What was implemented instead]
**Rationale:** [Why alternative is superior for this context]
**Impact:** [Any changes to architecture, performance, or cost]
**Date:** [YYYY-MM-DD]
**Decision Maker:** [Agent or human developer]
```

**Example:**
```markdown
**Preference Overridden:** PostgreSQL for database
**Reason:** Real-time collaborative features require WebSocket sync
**Alternative Chosen:** Supabase (PostgreSQL + real-time subscriptions + auth)
**Rationale:** Unified platform reduces complexity, built-in real-time eliminates custom WebSocket server
**Impact:** Faster development, lower ops overhead, $20/month vs $0 hosting cost
**Date:** 2025-01-15
**Decision Maker:** @developer
```

---

## 💻 Technical Preferences (Non-binding)

### Database

**Preference:** [PostgreSQL / MongoDB / MySQL / etc.]

**Rationale:**
- [Why this database aligns with product requirements]
- [Team familiarity or previous success]
- [Specific features needed: JSON support, full-text search, etc.]
- [Scaling characteristics that match expected growth]

**Alternative Considerations:**
- [When a different database might be better]
- [Trade-offs to evaluate during implementation]

**Override Policy:** Developer may override with documented justification if alternative better serves PRD requirements or technical needs.

---

### Authentication & Authorization

**Preference:** [Supabase Auth / Auth0 / Firebase Auth / Custom JWT / etc.]

**Rationale:**
- [Why this auth approach fits security requirements]
- [Integration with existing systems]
- [Features needed: SSO, MFA, social login, etc.]
- [Cost and maintenance considerations]

**Security Requirements from PRD:**
- [Reference specific security requirements from PRD]
- [Compliance needs: GDPR, HIPAA, etc.]

**Alternative Considerations:**
- [When different auth might be needed]
- [Custom vs managed service trade-offs]

**Override Policy:** Developer may override with documented justification. Security requirements in PRD are binding.

---

### Hosting & Deployment

**Preference:** [Railway / Vercel / Netlify / AWS / Custom / etc.]

**Rationale:**
- [Why this platform aligns with product needs]
- [Cost expectations at launch and scale]
- [Developer experience and deployment speed]
- [Geographic distribution needs]

**Deployment Strategy:**
- [CI/CD preferences: GitHub Actions, etc.]
- [Environment structure: dev, staging, prod]
- [Rollback and disaster recovery preferences]

**Alternative Considerations:**
- [When different hosting makes sense]
- [Scaling path if product succeeds beyond expectations]

**Override Policy:** Developer may override with documented justification if better deployment approach exists.

---

### Frontend Framework

**Preference:** [React / Next.js / Vue / Svelte / etc.]

**Rationale:**
- [Why this framework serves UI requirements]
- [Team expertise and productivity]
- [SEO needs and rendering strategy]
- [Component library availability]

**UI Requirements from PRD:**
- [Reference specific UI requirements]
- [Performance expectations]
- [Accessibility standards]

**Alternative Considerations:**
- [When different framework might fit better]
- [Server-side vs client-side rendering trade-offs]

**Override Policy:** Developer may override with documented justification if alternative better serves PRD requirements.

---

### Backend Framework

**Preference:** [Node.js/Express / Python/FastAPI / Go / etc.]

**Rationale:**
- [Why this backend serves API requirements]
- [Performance characteristics needed]
- [Team expertise and development speed]
- [Integration requirements]

**API Requirements from PRD:**
- [Reference specific API needs]
- [Real-time requirements]
- [Third-party integrations]

**Alternative Considerations:**
- [When different backend makes sense]
- [Serverless vs traditional server trade-offs]

**Override Policy:** Developer may override with documented justification if better backend approach exists.

---

### State Management (Frontend)

**Preference:** [React Context / Redux / Zustand / TanStack Query / etc.]

**Rationale:**
- [Why this state approach fits UI complexity]
- [Server state vs client state needs]
- [Caching and data synchronization]

**Alternative Considerations:**
- [When simpler/different approach works better]
- [Trade-offs between simplicity and power]

**Override Policy:** Developer may override based on actual UI complexity discovered during implementation.

---

### Testing Strategy

**Preference:** [Playwright / Cypress / Jest / Vitest / etc.]

**Rationale:**
- [Why these testing tools fit quality requirements]
- [Coverage expectations: unit, integration, e2e]
- [CI/CD integration needs]

**Quality Requirements from PRD:**
- [Reference acceptance criteria and quality standards]
- [Critical user journeys to test]

**Alternative Considerations:**
- [When different testing approach needed]
- [Coverage vs development speed trade-offs]

**Override Policy:** Developer may choose appropriate testing tools. PRD acceptance criteria are binding.

---

## 🏗️ Architecture Patterns (Non-binding)

### Multi-Tenancy Pattern

**Preference:** [Shared Database, Separate Schema / Separate Databases / Hybrid / etc.]

**Rationale:**
- [How this pattern serves business model from PRD]
- [Data isolation requirements]
- [Cost and scaling characteristics]

**PRD Business Requirements:**
- [Reference multi-tenant requirements if applicable]
- [Data privacy and compliance needs]

**Implementation Hints:**
- [Suggested approach for tenant identification]
- [Data access patterns to consider]
- [Performance implications]

**Alternative Considerations:**
- [When different multi-tenancy approach needed]
- [Migration path if business model changes]

**Override Policy:** Developer chooses best multi-tenancy approach. PRD data isolation requirements are binding.

---

### Error Handling Pattern

**Preference:** [Centralized error handling / Error boundaries / Structured logging / etc.]

**Rationale:**
- [Why this error approach improves reliability]
- [Debugging and monitoring needs]
- [User experience during errors]

**Implementation Hints:**
- [Error code structure suggestions]
- [Logging level recommendations]
- [User-facing error message approach]

**Alternative Considerations:**
- [When different error handling needed]
- [Trade-offs between detail and simplicity]

**Override Policy:** Developer designs appropriate error handling. User-facing error requirements from PRD are binding.

---

### Caching Strategy

**Preference:** [Redis / In-memory / CDN / Browser caching / etc.]

**Rationale:**
- [Why this caching serves performance needs]
- [Data freshness requirements]
- [Cost and complexity trade-offs]

**Performance Targets:**
- [Reference performance expectations from PRD]
- [Critical paths needing optimization]

**Implementation Hints:**
- [Cache invalidation approach]
- [TTL recommendations]
- [Cache warming strategies]

**Alternative Considerations:**
- [When different caching needed]
- [No-cache scenarios to respect]

**Override Policy:** Developer chooses appropriate caching. PRD performance requirements are binding where specified.

---

### API Design Pattern

**Preference:** [REST / GraphQL / tRPC / gRPC / etc.]

**Rationale:**
- [Why this API design serves integration needs]
- [Client requirements and use cases]
- [Versioning and evolution strategy]

**Integration Requirements from PRD:**
- [Reference third-party integrations needed]
- [API consumers and use cases]

**Implementation Hints:**
- [Endpoint structure suggestions]
- [Authentication flow preferences]
- [Rate limiting approach]

**Alternative Considerations:**
- [When different API pattern fits better]
- [Mixed approach scenarios]

**Override Policy:** Developer designs appropriate API. PRD integration requirements are binding.

---

### Background Jobs / Workers

**Preference:** [BullMQ / Inngest / Celery / Custom / etc.]

**Rationale:**
- [Why this job queue serves async processing needs]
- [Reliability and retry requirements]
- [Cost and operational complexity]

**Async Requirements from PRD:**
- [Reference background processing needs]
- [SLA for job completion]

**Implementation Hints:**
- [Job prioritization approach]
- [Failure handling and retries]
- [Monitoring and observability]

**Alternative Considerations:**
- [When simpler approach works]
- [Serverless vs dedicated workers]

**Override Policy:** Developer chooses appropriate job system. PRD async requirements are binding.

---

### File Storage

**Preference:** [Supabase Storage / S3 / Cloudflare R2 / etc.]

**Rationale:**
- [Why this storage serves file handling needs]
- [Cost structure and scaling]
- [Access control requirements]

**Storage Requirements from PRD:**
- [Reference file upload/download features]
- [File types and size limits]

**Implementation Hints:**
- [Upload flow preferences]
- [Virus scanning considerations]
- [CDN integration for delivery]

**Alternative Considerations:**
- [When different storage needed]
- [Direct upload vs proxy trade-offs]

**Override Policy:** Developer chooses appropriate storage. PRD file requirements are binding.

---

## 🔌 Integration Preferences (Non-binding)

### Email Service

**Preference:** [SendGrid / Postmark / Resend / etc.]

**Rationale:**
- [Why this email service fits communication needs]
- [Cost structure and volume expectations]
- [Template and tracking features needed]

**Email Requirements from PRD:**
- [Reference transactional email needs]
- [Marketing email if applicable]

**Integration Hints:**
- [Template management approach]
- [Bounce and complaint handling]
- [Unsubscribe flow]

**Alternative Considerations:**
- [When different service fits better]
- [Self-hosted vs managed trade-offs]

**Override Policy:** Developer chooses appropriate email service. PRD communication requirements are binding.

---

### Payment Processing

**Preference:** [Stripe / Paddle / etc.]

**Rationale:**
- [Why this payment processor serves revenue model]
- [Fee structure and business impact]
- [Features needed: subscriptions, invoicing, etc.]

**Payment Requirements from PRD:**
- [Reference monetization model]
- [Supported payment methods]
- [Geographic coverage needed]

**Integration Hints:**
- [Webhook handling approach]
- [Subscription management flow]
- [Invoice generation]

**Alternative Considerations:**
- [When different processor needed]
- [Multiple processor scenarios]

**Override Policy:** Developer chooses appropriate payment processor. PRD revenue requirements are binding.

---

### Analytics & Monitoring

**Preference:** [Plausible / PostHog / Google Analytics / etc.]

**Rationale:**
- [Why this analytics serves product insights]
- [Privacy considerations]
- [Event tracking needs]

**Analytics Requirements from PRD:**
- [Reference metrics and KPIs to track]
- [User behavior insights needed]

**Integration Hints:**
- [Event taxonomy suggestions]
- [Dashboard setup preferences]
- [Privacy-compliant tracking]

**Alternative Considerations:**
- [When different analytics needed]
- [Multiple tools for different purposes]

**Override Policy:** Developer chooses appropriate analytics. PRD metrics requirements are binding.

---

### Error Tracking

**Preference:** [Sentry / Rollbar / LogRocket / etc.]

**Rationale:**
- [Why this error tracking improves reliability]
- [Cost structure and volume]
- [Features needed: session replay, etc.]

**Reliability Requirements from PRD:**
- [Reference uptime and quality expectations]
- [Critical error scenarios]

**Integration Hints:**
- [Error grouping preferences]
- [Alert configuration]
- [Source map handling]

**Alternative Considerations:**
- [When different tracking needed]
- [Self-hosted vs managed]

**Override Policy:** Developer chooses appropriate error tracking. PRD reliability requirements are binding.

---

### [Additional Integration]

**Preference:** [Service/Library Name]

**Rationale:**
- [Why this integration serves PRD requirement]
- [Cost and maintenance considerations]
- [Features needed]

**Requirements from PRD:**
- [Reference specific integration needs]

**Integration Hints:**
- [Implementation approach suggestions]
- [Configuration preferences]

**Alternative Considerations:**
- [When different integration needed]

**Override Policy:** Developer chooses appropriate integration approach. PRD integration requirements are binding.

---

## 🔒 Security Baseline (Non-binding standards)

### Data Encryption

**Standard:** [Encryption at rest and in transit]

**Rationale:**
- [Why this encryption level meets security needs]
- [Compliance requirements: GDPR, HIPAA, etc.]
- [Performance impact acceptable]

**Security Requirements from PRD:**
- [Reference specific security and compliance needs]
- [Data sensitivity classification]

**Implementation Hints:**
- [TLS version preferences]
- [Database encryption approach]
- [Key management suggestions]

**Alternative Considerations:**
- [When additional encryption needed]
- [Performance vs security trade-offs]

**Override Policy:** Developer implements appropriate encryption. PRD security requirements are binding. Compliance requirements are MANDATORY.

---

### Access Control

**Standard:** [Role-Based Access Control (RBAC) / Attribute-Based / etc.]

**Rationale:**
- [Why this access model serves authorization needs]
- [Complexity vs functionality trade-off]
- [Audit trail requirements]

**Authorization Requirements from PRD:**
- [Reference user roles and permissions]
- [Data access restrictions]

**Implementation Hints:**
- [Permission structure suggestions]
- [Role hierarchy approach]
- [Permission checking patterns]

**Alternative Considerations:**
- [When more sophisticated access control needed]
- [Dynamic permission scenarios]

**Override Policy:** Developer designs appropriate access control. PRD authorization requirements are binding.

---

### Authentication Security

**Standard:** [Password requirements / MFA / Session management / etc.]

**Rationale:**
- [Why these auth standards meet security needs]
- [User experience vs security balance]
- [Compliance requirements]

**Auth Requirements from PRD:**
- [Reference authentication requirements]
- [Security level for user types]

**Implementation Hints:**
- [Password complexity rules]
- [Session timeout preferences]
- [MFA enrollment flow]

**Alternative Considerations:**
- [When stronger/different auth needed]
- [Passwordless authentication scenarios]

**Override Policy:** Developer implements appropriate auth security. PRD security requirements are binding.

---

### Data Retention

**Standard:** [Retention periods by data type]

**Rationale:**
- [Why these retention periods serve business and compliance]
- [Storage cost implications]
- [Legal requirements]

**Data Requirements from PRD:**
- [Reference data lifecycle requirements]
- [Deletion and anonymization needs]

**Implementation Hints:**
- [Automated cleanup approach]
- [User data export flow]
- [Backup retention]

**Alternative Considerations:**
- [When different retention needed]
- [GDPR right to erasure implementation]

**Override Policy:** Developer implements appropriate retention. PRD data requirements are binding. Legal requirements are MANDATORY.

---

### API Security

**Standard:** [Rate limiting / Authentication / CORS / etc.]

**Rationale:**
- [Why these API protections serve security needs]
- [DDoS protection approach]
- [Resource usage fairness]

**API Requirements from PRD:**
- [Reference API security needs]
- [Rate limits for different user tiers]

**Implementation Hints:**
- [Rate limit algorithm suggestions]
- [API key management approach]
- [CORS policy recommendations]

**Alternative Considerations:**
- [When different API security needed]
- [Per-endpoint rate limiting]

**Override Policy:** Developer implements appropriate API security. PRD security requirements are binding.

---

### Audit Logging

**Standard:** [Events to log / Retention / Access controls / etc.]

**Rationale:**
- [Why this audit approach serves compliance]
- [Debugging and security investigation needs]
- [Storage and cost implications]

**Audit Requirements from PRD:**
- [Reference audit trail needs]
- [Compliance logging requirements]

**Implementation Hints:**
- [Event structure suggestions]
- [Log storage approach]
- [Access restrictions on logs]

**Alternative Considerations:**
- [When more extensive logging needed]
- [Real-time alerting scenarios]

**Override Policy:** Developer implements appropriate audit logging. PRD audit requirements are binding. Compliance requirements are MANDATORY.

---

## ⚡ Performance Targets (Non-binding expectations)

### Page Load Performance

**Target:** [e.g., First Contentful Paint < 1.5s, Time to Interactive < 3s]

**Rationale:**
- [Why these targets serve user experience goals]
- [Based on PRD user expectations]
- [Industry benchmarks considered]

**Performance Requirements from PRD:**
- [Reference specific performance requirements if stated]
- [Critical user journeys to optimize]

**Optimization Hints:**
- [Code splitting suggestions]
- [Image optimization approach]
- [Critical CSS preferences]

**Alternative Considerations:**
- [When different targets needed]
- [Feature vs performance trade-offs]

**Override Policy:** Developer optimizes appropriately. PRD performance requirements (if specified) are binding. These targets are GUIDANCE, not requirements.

---

### API Response Times

**Target:** [e.g., p95 < 200ms for reads, < 500ms for writes]

**Rationale:**
- [Why these response times serve UX]
- [Based on expected usage patterns]
- [Infrastructure costs considered]

**API Requirements from PRD:**
- [Reference API performance expectations]
- [Real-time vs eventual consistency needs]

**Optimization Hints:**
- [Database indexing suggestions]
- [Caching strategy]
- [N+1 query prevention]

**Alternative Considerations:**
- [When different targets needed]
- [Batch processing scenarios]

**Override Policy:** Developer optimizes appropriately. PRD API requirements are binding. These targets are GUIDANCE.

---

### Scalability Targets

**Target:** [e.g., Support 10K concurrent users, 1M requests/day]

**Rationale:**
- [Why these scale targets align with business projections]
- [Based on PRD growth expectations]
- [Cost implications at scale]

**Scale Requirements from PRD:**
- [Reference expected user growth]
- [Usage pattern expectations]

**Scaling Hints:**
- [Horizontal vs vertical scaling approach]
- [Database sharding considerations]
- [CDN usage for static assets]

**Alternative Considerations:**
- [When different scale needed]
- [Over-engineering vs under-engineering risks]

**Override Policy:** Developer designs for appropriate scale. PRD scale requirements are binding. These targets are GUIDANCE.

---

### Database Performance

**Target:** [e.g., Query response < 100ms, Connection pool size]

**Rationale:**
- [Why these database targets serve overall performance]
- [Based on data access patterns]
- [Cost and resource implications]

**Data Requirements from PRD:**
- [Reference data access patterns]
- [Reporting and analytics needs]

**Optimization Hints:**
- [Index strategy suggestions]
- [Query optimization approach]
- [Read replica usage]

**Alternative Considerations:**
- [When different targets needed]
- [Denormalization trade-offs]

**Override Policy:** Developer optimizes database appropriately. PRD data requirements are binding. These targets are GUIDANCE.

---

## 📝 Developer Notes

### Development Priorities

**Recommended Focus Order:**
1. [Priority 1: Most critical PRD requirements]
2. [Priority 2: Core user journeys]
3. [Priority 3: Nice-to-have features]

**Rationale:**
- [Why this priority order serves business goals]
- [Based on PRD success criteria]
- [MVP vs full feature set trade-offs]

**Note:** Developer may adjust priorities based on technical dependencies and implementation efficiency.

---

### Known Constraints

**Technical Constraints:**
- [Any known technical limitations to consider]
- [Legacy system integration requirements]
- [Browser/platform compatibility needs]

**Business Constraints:**
- [Budget limitations affecting technical choices]
- [Timeline constraints from PRD]
- [Resource availability]

**Organizational Constraints:**
- [Team expertise and learning curve considerations]
- [Deployment approval processes]
- [Security review requirements]

---

### Risk Areas

**High-Risk Technical Areas:**
- [Areas needing extra attention: complex integrations, performance bottlenecks, etc.]
- [Mitigation suggestions]

**High-Risk Business Areas:**
- [Features critical to business success]
- [User experience must-haves]

**Recommended Approach:**
- [How to address high-risk areas]
- [Prototyping or proof-of-concept suggestions]

---

### Success Metrics for Implementation

**Technical Success:**
- [How to measure good implementation]
- [Code quality indicators]
- [Performance benchmarks]

**Business Success (from PRD):**
- [Reference PRD success criteria]
- [Measurable outcomes]

**Team Success:**
- [Developer velocity and satisfaction]
- [Maintainability and documentation quality]

---

### Future Considerations

**Potential Enhancements:**
- [Features not in current PRD but worth architectural consideration]
- [Extensibility points to preserve]

**Scalability Path:**
- [How system might need to scale beyond current requirements]
- [Architecture decisions supporting future growth]

**Technical Debt Management:**
- [Acceptable shortcuts for MVP]
- [Areas requiring refactoring later]
- [Documentation needs for future work]

---

## 📋 Appendix: Preference Override Log

**Purpose:** Track when and why preferences in this playbook were overridden during implementation. This learning improves future playbooks.

### Override Entry Template

```markdown
**Date:** [YYYY-MM-DD]
**Preference Overridden:** [Section and specific preference]
**Original Preference:** [What playbook recommended]
**Decision Maker:** [Agent or human developer name]
**Alternative Chosen:** [What was implemented instead]
**Rationale:** [Why alternative is superior for this context]
**PRD Alignment:** [Confirm alternative still meets PRD requirements]
**Impact Assessment:**
- Technical: [Effect on architecture, performance, maintainability]
- Cost: [Budget impact if any]
- Timeline: [Schedule impact if any]
- Risk: [New risks introduced or mitigated]
**Lessons Learned:** [What this teaches for future playbooks]
```

---

### Override Log Entries

#### Override #1: [Brief Description]

**Date:** [YYYY-MM-DD]
**Preference Overridden:** [Section and preference]
**Original Preference:** [What was recommended]
**Decision Maker:** [Name]
**Alternative Chosen:** [What was used]
**Rationale:** [Why it's better]
**PRD Alignment:** [Confirmed compliance]
**Impact Assessment:**
- Technical: [Details]
- Cost: [Details]
- Timeline: [Details]
- Risk: [Details]
**Lessons Learned:** [Insights]

---

#### Override #2: [Brief Description]

[Repeat template for each override]

---

## 📚 Document History & Maintenance

### Version History

| Version | Date | Author | Summary of Changes |
|---------|------|--------|--------------------|
| 1.0 | [YYYY-MM-DD] | [Name] | Initial Design Playbook creation |
| | | | |

### Review Schedule

**Recommended Reviews:**
- After each sprint/milestone: Review override log, update preferences
- After PRD updates: Ensure playbook aligns with new requirements
- Quarterly: Major review and lessons learned integration

**Next Review Due:** [YYYY-MM-DD]

---

## ✅ Playbook Checklist

Before considering this Design Playbook complete, verify:

- [ ] All sections completed with specific preferences (not generic placeholders)
- [ ] Every preference includes clear rationale
- [ ] Override policy stated for each section
- [ ] PRD requirements referenced where applicable
- [ ] Security and compliance requirements identified
- [ ] Performance targets realistic and measurable
- [ ] Developer notes provide helpful context
- [ ] Override log structure ready for use
- [ ] Document reviewed by stakeholders
- [ ] PRD reference accurate and accessible

---

**Remember: This is a PLAYBOOK, not a RULEBOOK.**

**Developer agents have FULL authority to override any preference with documented justification.**

**The PRD defines WHAT we're building. This playbook suggests HOW we prefer to build it.**

**Better solutions should ALWAYS win over playbook preferences.**

---

*Design Playbook Template v1.0 - Part of BOS-AI Foundation Document Library*
*Companion to PRD v3.1 and PRD Creation SOP v2.1*
