# Agent as a tool

In the orchestrator pattern, one agent delegates subtasks to specialist agents and combines their results. You attach a specialist as a tool: a function annotated with `@ai:AgentTool` that runs the specialist and returns its response. A specialist can be an inline `ai:Agent` or an agent created from a definition that includes the `ai:FixedTypedAgent` type.

This example runs a support agent that delegates order lookups to an inline specialist and return decisions to a specialist created from an agent definition.

> Note:<br />• Each delegation is a full agent run, so it adds latency and token usage, and each agent enforces its own maximum number of iterations. Delegate only the subtasks that need their own reasoning, and use a tool for a single action.<br />• This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_as_tool.bal :::

::: out ai_agent_as_tool.out :::

## Related links
- [The Agent definitions example](/learn/by-example/ai-agent-definitions/)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent with typed input and output example](/learn/by-example/ai-agent-typed-input-output/)
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
