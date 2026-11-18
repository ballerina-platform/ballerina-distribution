# Human-in-the-loop tool approval

Some tools, such as issuing a refund, should not run without a person's approval. Mark such a tool with `@ai:AgentTool {requiresApproval: true}` to require approval for every call. To decide for each call, set `requiresApproval` to an `isolated` function that takes the same parameters as the tool and returns `true` when the call needs approval.

When the agent wants to call the tool, `run` stops and returns an `ai:ApprovalRequiredError` with the proposed calls. After a person approves or rejects each call, call `run` again with an `ai:Resume` value holding the decisions and the same session ID, and the agent continues. With a persistent memory store, the paused run can be resumed even after a restart.

In this example, a refund always needs approval, and a discount needs approval only when it is above 10%. So the 5% discount is applied directly, and the refund waits for the approval entered on the console.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_human_in_the_loop.bal :::

::: out ai_agent_human_in_the_loop.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent with persistent memory example](/learn/by-example/ai-agent-persistent-memory/)
- [The Chat client example](/learn/by-example/ai-chat-client/)
