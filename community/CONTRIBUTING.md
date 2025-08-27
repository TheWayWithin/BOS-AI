# Contributing to BOS-AI

Thank you for your interest in contributing to BOS-AI! This guide helps you get started with contributing to our Business Operating System AI framework.

## How to Contribute

We welcome contributions in several areas:
- 🤖 **New Agents** - Specialized agents for specific business functions
- 🎯 **Missions** - Pre-built workflows for common business tasks
- 📚 **Documentation** - Guides, tutorials, and examples
- 🐛 **Bug Fixes** - Identify and fix issues
- 💡 **Features** - New capabilities and improvements
- 🌍 **Translations** - Help make BOS-AI globally accessible

## Getting Started

### 1. Fork the Repository
```bash
# Fork via GitHub UI, then clone your fork
git clone https://github.com/YOUR-USERNAME/BOS-AI.git
cd BOS-AI
```

### 2. Create a Branch
```bash
# Create descriptive branch name
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
# or
git checkout -b agent/new-agent-name
```

### 3. Make Your Changes
Follow our standards (see below) and test thoroughly.

### 4. Commit Your Changes
```bash
# Use clear, descriptive commit messages
git add .
git commit -m "Add: New pricing optimization agent

- Created pricing-optimization.md agent
- Added success metrics and coordination protocol
- Integrated with revenue-optimization agent"
```

### 5. Push and Create Pull Request
```bash
git push origin your-branch-name
```
Then create a Pull Request via GitHub.

## Contribution Standards

### Agent Development

New agents must follow this structure:
```markdown
# 🎨 [Agent Name] Agent

You are the [Role] specialist for BOS-AI [function]. Your role is to [primary purpose].

## Core Responsibility
[Detailed description of agent's main function]

## Key Functions
1. [Function 1] - [Description]
2. [Function 2] - [Description]
3. [Function 3] - [Description]
4. [Function 4] - [Description]
5. [Function 5] - [Description]

## Success Metrics
- [Metric 1] (>[target])
- [Metric 2] (>[target])
- [Metric 3] (>[target])

## Coordination Protocol
**Hub Integration**: Reports to 🔴 Chassis Intelligence
- [Coordination point 1]
- [Coordination point 2]
- [Coordination point 3]

## Scope Boundaries
✅ [What agent SHOULD do]
✅ [What agent SHOULD do]
✅ [What agent SHOULD do]

❌ [What agent should NOT do]
❌ [What agent should NOT do]
❌ [What agent should NOT do]

## Business Chassis Focus
[How agent contributes to Business Chassis optimization]

---
*BOS-AI v2.0 | Business Optimization System | [Category]*
```

### Mission Development

Missions should include:
```markdown
# Mission: [Name]

## Objective
[Clear, specific goal]

## Duration
[Estimated time]

## Agents Required
- @agent1 - [Role in mission]
- @agent2 - [Role in mission]

## Phases
### Phase 1: [Name]
- [Action 1]
- [Action 2]
- **Deliverable**: [Output]

### Phase 2: [Name]
- [Action 1]
- [Action 2]
- **Deliverable**: [Output]

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Usage
\```
/coord [mission-name] "[parameter]"
\```
```

### Code Style

For scripts and tools:
- Use descriptive variable names
- Include error handling
- Add progress indicators
- Support both verbose and quiet modes
- Include help documentation

### Documentation Style

- **Clear Headers** - Use markdown headers for structure
- **Code Examples** - Include practical examples
- **Visual Aids** - Use tables, lists, and diagrams
- **Concise Writing** - Be specific but brief
- **User Focus** - Write for business users, not just developers

## Testing Requirements

### Agents
- Test in Claude Code environment
- Verify coordination with other agents
- Validate success metrics
- Check scope boundaries

### Missions
- Run complete mission flow
- Verify all phases complete
- Check deliverables generation
- Test with various inputs

### Scripts
- Test on Mac, Linux, and WSL
- Verify error handling
- Check idempotency
- Test upgrade scenarios

## Pull Request Process

### PR Title Format
```
[Type]: Brief description

Types:
- Add: New feature/agent/mission
- Fix: Bug fix
- Update: Improvement to existing feature
- Docs: Documentation only
- Test: Testing improvements
```

### PR Description Template
```markdown
## Summary
[What does this PR do?]

## Type of Change
- [ ] New agent
- [ ] New mission
- [ ] Bug fix
- [ ] Documentation
- [ ] Feature enhancement

## Testing
- [ ] Tested in Claude Code
- [ ] Tested installation script
- [ ] Documentation updated
- [ ] Examples provided

## Checklist
- [ ] Follows BOS-AI standards
- [ ] Includes success metrics
- [ ] Has coordination protocol
- [ ] Documentation complete
```

### Review Process
1. Automated checks run
2. Maintainer review
3. Community feedback period (48 hours)
4. Merge or request changes

## Development Setup

### Prerequisites
- Claude Code installed
- Git configured
- Bash shell access

### Local Testing
```bash
# Test installation
./deployment/scripts/deploy-complete.sh

# Test in Claude Code
claude code .
/coord optimize
```

## Community Guidelines

### Be Respectful
- Welcome newcomers
- Provide constructive feedback
- Respect different perspectives
- Keep discussions professional

### Be Helpful
- Answer questions when you can
- Share your expertise
- Document your learnings
- Help others debug issues

### Be Patient
- Reviews take time
- Not all contributions are accepted
- Feedback helps improvement
- Quality over quantity

## Recognition

Contributors are recognized in:
- README.md contributors section
- Release notes
- Monthly community highlights
- Annual contributor awards

## Getting Help

### Resources
- [Documentation](../docs/)
- [Agent Reference](../docs/agents/README.md)
- [Mission Catalog](../docs/missions/README.md)
- [Getting Started Guide](../docs/getting-started/README.md)

### Communication
- **Issues**: [GitHub Issues](https://github.com/TheWayWithin/BOS-AI/issues)
- **Discussions**: [GitHub Discussions](https://github.com/TheWayWithin/BOS-AI/discussions)
- **Email**: bos-ai@example.com (coming soon)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md) to keep our community welcoming for everyone.

---

*Thank you for helping make BOS-AI better! Your contributions help solopreneurs worldwide build successful businesses.*