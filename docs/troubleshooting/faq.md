# Frequently Asked Questions

Common questions and answers about using BOS-AI effectively.

---

## Getting Started

### What is BOS-AI?

BOS-AI (Business Operating System - AI) is an AI-powered system for business strategy, operations, and growth. It provides 30 specialized business agents that help you with everything from market research to customer service optimization.

**Key features**:
- Business Chassis optimization framework
- 30 specialized business intelligence agents
- Complete operations systems (Marketing, Sales, Service, Finance)
- Strategic mission orchestration

---

### How is BOS-AI different from ChatGPT?

| Feature | ChatGPT | BOS-AI |
|---------|---------|--------|
| Focus | General purpose | Business operations |
| Agents | One general assistant | 30 business specialists |
| Memory | Limited context | Persistent business memory |
| Workflows | Ad-hoc conversations | Structured missions |
| Framework | None | Business Chassis methodology |

BOS-AI is built specifically for running businesses, with specialized agents, proven frameworks, and systematic workflows.

---

### Do I need technical skills to use BOS-AI?

**No.** BOS-AI is designed for business operators, not developers. You don't need to:
- Write any code
- Understand programming
- Know technical terminology

All you need is:
- Basic computer literacy
- Terminal/command line basics (copy/paste commands)
- Understanding of your business

---

### How long does it take to see results?

| Activity | Time Investment | Expected Results |
|----------|-----------------|------------------|
| First `/coord optimize` | 15 minutes | Identify biggest opportunity |
| Single Bible creation | 90 minutes | Strategic foundation for one area |
| Complete system setup | 3-5 hours | Full operations framework |
| All four systems | 13-17 hours | 77%+ profit improvement potential |

**Quick wins**: 1-2 weeks
**Exponential impact**: 90 days with consistent use

---

## Commands & Usage

### What's the difference between `/coord` and `/meeting`?

| Command | Purpose | Use When |
|---------|---------|----------|
| `/coord` | Mission orchestration | Systematic workflows, multi-agent tasks |
| `/meeting` | Direct consultation | Focused discussions with specific agent |

**Examples**:
- `/coord marketing-system-setup` - Build complete marketing framework
- `/meeting @brand-strategy "positioning for premium market"` - Deep dive with specialist

Use `/coord` for structured missions, `/meeting` for targeted expertise.

---

### How do I know which agent to use?

**Quick guide by topic**:

| If you need help with... | Use this agent |
|-------------------------|----------------|
| Overall business optimization | `@chassis-intelligence` |
| Market research | `@market-intelligence` |
| Marketing strategy | `@brand-strategy` |
| Sales process | `@pipeline-management` |
| Customer retention | `@retention-strategy` |
| Financial planning | `@budget-planning` |
| Pricing | `@revenue-optimization` |

**Pro tip**: Use `/coord optimize` and let BOS-AI recommend the right agent based on your Business Chassis analysis.

---

### Can I pause a mission and resume later?

**Yes.** Missions track their progress and can be resumed across sessions.

- Progress is saved in `/workspace/missions/active/`
- Memory system preserves context
- Resume by running the same command or checking mission status

---

### How do I customize missions for my industry?

Missions adapt to your context automatically. When you provide industry-specific information:
- Agents use your context in their analysis
- Outputs are tailored to your market
- Examples and recommendations reflect your industry

**Best practice**: Provide detailed context when starting missions. The more specific your inputs, the more relevant the outputs.

---

## Business Chassis

### What is the Business Chassis?

The Business Chassis is BOS-AI's core framework for business growth. It's based on the multiplication formula:

```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```

Because these multiply together, small improvements in each create exponential growth.

**See**: [Business Chassis Concept](../concepts/business-chassis.md) for full details.

---

### How do I measure my current metrics?

Run `/coord optimize` and BOS-AI will guide you through:
1. Estimating your current numbers for each component
2. Identifying which is weakest
3. Recommending specific improvements

You don't need perfect data—reasonable estimates work for identifying opportunities.

---

### Which multiplier should I optimize first?

BOS-AI recommends the "Fix the Holes" methodology: **start from margin and work backward**.

**Priority order**:
1. Margin (keep more of what you earn)
2. Transaction Frequency (customers buy more often)
3. Average Spend (each purchase is worth more)
4. Client Conversion (more leads become customers)
5. Lead Conversion (more prospects become leads)
6. Prospects (reach more potential customers)

This ensures improvements compound on each other.

---

### How long until I see profit improvements?

| Improvement Type | Timeline |
|-----------------|----------|
| Immediate optimization (margin, pricing) | Days to weeks |
| Conversion improvements | 2-4 weeks |
| Customer retention | 1-3 months |
| Prospect growth | 2-6 months |

**Full Business Chassis optimization**: 90 days for significant compound effect.

---

## BOS-AI vs AGENT-11

### When do I use BOS-AI vs AGENT-11?

| Use Case | System |
|----------|--------|
| Business strategy | BOS-AI |
| Market research | BOS-AI |
| Marketing/Sales/Service operations | BOS-AI |
| Product requirements (PRD) | BOS-AI |
| Writing code | AGENT-11 |
| Building software | AGENT-11 |
| Technical architecture | AGENT-11 |
| Deployment/DevOps | AGENT-11 |

**Rule of thumb**: BOS-AI defines WHAT to build and WHY. AGENT-11 handles HOW to build it.

---

### Can BOS-AI write code for me?

**No.** BOS-AI is specifically designed for business operations, not software development.

BOS-AI creates:
- Business strategy and requirements
- Product Requirements Documents (PRDs)
- Operational frameworks

For code, use AGENT-11 (a separate project for technical development).

---

### How do I hand off PRDs to developers?

1. **Create PRD in BOS-AI**:
   ```
   /coord solution-design "your product idea"
   ```

2. **Export the PRD** from your BOS-AI project

3. **Hand off** to your development team or AGENT-11 project

4. **Return to BOS-AI** for operations when the product is built

---

### Do I need both systems?

**It depends on your situation**:

| Scenario | What You Need |
|----------|---------------|
| Running a service business (no software) | BOS-AI only |
| Marketing existing products | BOS-AI only |
| Building software products | BOS-AI + AGENT-11 |
| Technical founder building SaaS | Both systems |

Most business operators only need BOS-AI.

---

## Technical Questions

### What data does BOS-AI store?

BOS-AI stores all data locally in your project directory:
- `/memories/` - Business intelligence and learning
- `/workspace/` - Active mission data
- Foundation documents you create

**Nothing is sent to external servers** beyond standard Claude Code operation.

---

### How does the memory system work?

BOS-AI maintains persistent memory across sessions:
- **Business memory**: Vision, markets, customers
- **Strategy memory**: Marketing, sales, growth approaches
- **Lessons memory**: Failures, insights, patterns

Agents read relevant memories before executing tasks, ensuring continuous learning and consistency.

---

### Can I use BOS-AI with my existing tools?

BOS-AI creates strategic frameworks and documents that you implement with your tools:
- Marketing plans → Execute in your marketing platform
- Sales processes → Implement in your CRM
- Financial plans → Track in your accounting software

BOS-AI doesn't directly integrate with other tools—it provides the strategy you execute.

---

## Troubleshooting

### Mission fails to start

**Common causes**:
1. Another mission is active - check `/workspace/missions/active/`
2. Mission name is misspelled (case-sensitive)
3. Required inputs not provided

**Solution**: Use `/coord` interactive mode to see available missions.

---

### Agent doesn't respond properly

**Try**:
1. Be more specific in your request
2. Provide more context about your business
3. Try a different, more specialized agent
4. Use `/pmd` to diagnose the issue

---

### Results seem incorrect

**Consider**:
1. Did you provide accurate context?
2. Are your Business Chassis estimates reasonable?
3. Have you reviewed the underlying assumptions?

Use `/meeting @agent` to discuss and refine results with the specialist.

---

### How do I get help?

1. **In BOS-AI**: `/pmd "describe your issue"`
2. **Documentation**: Check [Installation Troubleshooting](installation.md)
3. **GitHub Issues**: Report bugs at the BOS-AI repository

---

## Related Documentation

- [Business Operations Guide](../getting-started/business-guide.md)
- [Product Developer Guide](../getting-started/developer-guide.md)
- [Installation Troubleshooting](installation.md)
- [Business Chassis Concept](../concepts/business-chassis.md)

---

[Back to README](../../README.md) | [Installation Issues](installation.md)
