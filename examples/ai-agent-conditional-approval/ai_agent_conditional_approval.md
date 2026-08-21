# Agent with conditional approval

Gating a sensitive tool unconditionally works, but it can create needless friction: a tool that is only risky past some threshold, such as a money transfer, would force a human to rubber-stamp every small call. That trains reviewers to click "approve" on autopilot, the exact habit an approval gate exists to prevent.

Ballerina's `ballerina/ai` module lets `requiresApproval` take a function as well as a plain boolean, so a tool can pause only for the specific calls that actually carry risk. This example gates the `transfer` tool with the `largeTransfer` rule, which is written with the same parameter signature as the tool itself. The agent binds each proposed call's arguments to the rule by name and invokes it before running the tool: small transfers go straight through, while a transfer above the threshold pauses and returns an `ai:ApprovalRequiredError` for a human to approve or reject. The rule must be `isolated` and deterministic given its arguments, keeping the guarantee that what can pause is always something a developer wrote and can read, not a runtime heuristic. A rule that panics fails safe by pausing for approval rather than running the call unreviewed.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_conditional_approval.bal :::

::: out ai_agent_conditional_approval.out :::

## Related links
- [The Agent with human-in-the-loop approval example](/learn/by-example/ai-agent-human-in-the-loop)
- [The Agent with approval for programmatic tools example](/learn/by-example/ai-agent-tool-config-approval)
- [The Chat agent with human-in-the-loop approval example](/learn/by-example/ai-agent-human-in-the-loop-chat)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
