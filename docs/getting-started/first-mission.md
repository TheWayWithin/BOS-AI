# Your First Mission with BOS-AI

> A hands-on walkthrough of running your first BOS-AI mission. By the end, you'll have analyzed your business and identified your highest-impact opportunity.

**Time Required**: 20-30 minutes

---

## Before You Start

### 1. Verify Installation

Open your terminal and navigate to your project:
```bash
cd ~/my-business-project
```

Check that BOS-AI is installed:
```bash
ls .claude/agents/
```

You should see agent files like `chassis-intelligence.md`, `multiplication-engine.md`, etc.

### 2. Open Claude Code

Launch Claude Code in your project directory:
```bash
claude code .
```

Or if already in VS Code with Claude Code extension, open your project folder.

### 3. Understanding What Will Happen

When you run `/coord optimize`, BOS-AI will:

1. **Analyze** your current business state
2. **Calculate** your Business Chassis metrics
3. **Identify** your weakest multiplication factor
4. **Recommend** specific actions to improve it
5. **Suggest** your next mission

This is an interactive process - the system will ask you questions about your business.

---

## Running Your First Mission

### Step 1: Start the Mission

In Claude Code's chat interface, type:
```
/coord optimize
```

Press Enter.

### Step 2: Answer the Initial Questions

The Chassis Intelligence agent will ask you about your business. Be honest and specific. Example questions:

**"What does your business do?"**
> Example answer: "We sell productivity software to small business owners. Monthly subscription model at $29-99/month."

**"What are your current metrics?"**
> Share what you know. It's okay if you don't have exact numbers:
> - "About 5,000 website visitors per month"
> - "Maybe 2% convert to free trial"
> - "About 20% of trials become paying customers"

**"What's your biggest challenge right now?"**
> Be specific:
> - "We're getting traffic but not enough signups"
> - "Customers churn after 3 months"
> - "We can't seem to raise prices"

### Step 3: Wait for Analysis

The system will process your answers and calculate your Business Chassis:

```
Business Chassis Analysis
=========================
Prospects:           5,000/month    [Score: 6/10]
Lead Conversion:     2%             [Score: 3/10]  <-- WEAKEST
Client Conversion:   20%            [Score: 5/10]
Average Spend:       $49/month      [Score: 5/10]
Transaction Freq:    Monthly        [Score: 7/10]
Margin:              80%            [Score: 8/10]

Priority Opportunity: Lead Conversion
Potential Impact: +50% leads = +50% revenue
```

### Step 4: Review Recommendations

The agent will provide specific recommendations:

```
Recommended Next Steps:
=======================
1. IMMEDIATE: Review landing page messaging
   - Current conversion is below industry average (5-10%)
   - Focus on clear value proposition

2. QUICK WIN: Add social proof
   - Customer testimonials
   - Usage statistics
   - Trust badges

3. STRATEGIC: Run /coord marketing-bible-creation
   - Build complete marketing foundation
   - Align messaging across all channels
```

---

## Interpreting Your Results

### Understanding the Business Chassis Score

Each factor is rated 1-10 based on:
- **1-3**: Critical issue, significant growth blocker
- **4-6**: Room for improvement, moderate impact
- **7-10**: Performing well, maintain and optimize

### The Multiplication Effect

Remember: Profit = Prospects x Lead% x Client% x Spend x Frequency x Margin

This means:
- **10% improvement in ONE factor** = 10% more profit
- **10% improvement in ALL SIX** = 77% more profit
- **20% improvement in ALL SIX** = 299% more profit

Focus on your weakest factor first for maximum impact.

### What Each Factor Means

| Factor | Low Score Symptoms | Improvement Focus |
|--------|-------------------|-------------------|
| Prospects | "No one knows we exist" | Marketing reach, content, ads |
| Lead Conversion | "Traffic but no signups" | Landing pages, offers, messaging |
| Client Conversion | "Leads but no sales" | Sales process, objection handling |
| Average Spend | "Customers don't buy much" | Upsells, premium tiers, bundles |
| Transaction Freq | "One-time buyers only" | Retention, subscriptions, loyalty |
| Margin | "Revenue but no profit" | Costs, pricing, efficiency |

---

## Taking Action

### Option A: Follow the Recommended Mission

If the analysis recommends a specific mission, run it:
```
/coord marketing-bible-creation
```

This will create a complete marketing foundation document tailored to your business.

### Option B: Consult a Specific Agent

For focused advice on a specific topic:
```
/meeting @conversion-optimization "How can I improve my landing page conversion from 2% to 5%?"
```

### Option C: Get More Context

If you want to understand the analysis better:
```
/meeting @chassis-intelligence "Explain why lead conversion is my biggest opportunity"
```

---

## Common First-Mission Scenarios

### Scenario: "I don't have any metrics yet"

That's okay! The system works with estimates:
```
/coord optimize
```
When asked for metrics, say: "I'm pre-launch" or "Just starting out"

The analysis will focus on:
- Setting up measurement foundations
- Building initial traction strategies
- Prioritizing where to track first

### Scenario: "My business is doing well, I just want to grow"

Great position! Run:
```
/coord optimize
```

The analysis will identify:
- Which factor has the most room for improvement
- Which factor would give you the best ROI on effort
- Advanced optimization strategies

### Scenario: "I'm not sure what kind of business I have"

Start with strategy:
```
/meeting @chassis-intelligence "Help me define my business model"
```

Then run `/coord optimize` once you have clarity.

---

## Troubleshooting

### Mission Doesn't Start

**Symptom**: Nothing happens when you type `/coord optimize`

**Solutions**:
1. Make sure you're in Claude Code's chat, not terminal
2. Check installation: `ls .claude/agents/`
3. Restart Claude Code
4. Reinstall if needed: `bash install.sh starter`

### Agent Asks Questions I Can't Answer

**It's okay to say**:
- "I don't know"
- "About [X], but I'm not sure"
- "I haven't measured that yet"

The system adapts to uncertainty and will provide appropriate guidance.

### Results Don't Match My Expectations

**Consider**:
1. Were your answers accurate? The analysis is only as good as the input.
2. Run the analysis again with more detailed answers.
3. Use `/meeting @chassis-intelligence "I disagree with the analysis because..."` to discuss.

### Want to Start Over

To run a fresh analysis:
```
/coord optimize
```

Each analysis is independent - you can run it as many times as needed.

---

## What You've Accomplished

By completing this walkthrough, you have:

- [x] Verified BOS-AI is installed and working
- [x] Run your first business analysis
- [x] Identified your highest-impact opportunity
- [x] Received specific, actionable recommendations
- [x] Learned how to interpret Business Chassis metrics
- [x] Chosen your next step

---

## Next Steps

### For Business Operators
Continue to: [Business Guide](business-guide.md)
- Learn about Foundation Documents
- Set up Operations Systems
- Build ongoing optimization routines

### For Product Developers
Continue to: [Developer Guide](developer-guide.md)
- Create PRD for your product
- Set up AGENT-11 development project
- Learn the full build cycle

### Quick Reference
See: [Quick Reference Card](../reference/quick-reference.md)
- All commands at a glance
- Mission cheat sheet
- Agent directory

---

## See Also

- [Business Chassis Explained](../concepts/business-chassis.md) - Deep dive into the formula
- [Available Missions](../../missions/README.md) - All available workflows
- [FAQ](../troubleshooting/faq.md) - Common questions answered

---

[Back to Getting Started](README.md) | [Back to README](../../README.md)

---

*Congratulations on completing your first mission! You're now ready to start optimizing your business with BOS-AI.*
