# Agent with human-in-the-loop approval

AI agents become far more useful when they can act on the user's behalf, but some actions are too sensitive to run unsupervised, such as issuing a refund, sending an email, or deleting a record. Ballerina's `ballerina/ai` module supports a human-in-the-loop (HITL) workflow: a tool can be gated so the agent pauses and asks a human to approve or reject the proposed call before it runs.

This example demonstrates a banking agent with two tools. The read-only `checkBalance` tool runs freely, while the sensitive `transfer` tool, which actually debits one account and credits another, is marked with `requiresApproval`, so the agent pauses before invoking it. When a gated tool is proposed, `run` returns an `ai:ApprovalRequiredError` carrying the pending `ai:ApprovalRequest`s instead of executing the tool. The application collects a human decision for each request and resumes the run by passing an `ai:Resume` (a map of `ai:HumanResponse` decisions keyed by request ID) back to the same `run` method. Approving lets the transfer proceed and the balances change; rejecting skips it, leaving balances untouched, and lets the agent replan, optionally guided by the supplied reason. Because the pause is checkpointed against the session ID, the same `run` entry point resumes exactly where it left off.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_human_in_the_loop.bal :::

::: out ai_agent_human_in_the_loop.out :::

## Related links
- [The Agent with conditional approval example](/learn/by-example/ai-agent-conditional-approval)
- [The Agent with approval for programmatic tools example](/learn/by-example/ai-agent-tool-config-approval)
- [The Chat agent with human-in-the-loop approval example](/learn/by-example/ai-agent-human-in-the-loop-chat)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
