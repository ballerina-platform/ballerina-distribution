# Agent as a tool

A multi-agent system splits a task across several cooperating agents, each with its own instructions, tools, model, and optionally its own memory. In the orchestrator pattern, one agent owns the request, delegates subtasks to specialist agents, and composes their results into the final answer. A specialist is attached to the orchestrator as a tool: a function annotated with `@ai:AgentTool` that runs the specialist with the query composed by the orchestrator and returns its response.

The orchestrator decides when to call the tool from its description, so write the description around the situations that should trigger a hand-off. The specialist does not see the conversation of the orchestrator, so the description also states what the query must include. The return type of the tool binds the response of the specialist: a structured type gives the orchestrator a result that needs no further interpretation. A specialist configured with `memory: ()` is stateless, so it keeps no history between delegations.

This example demonstrates a customer support agent that delegates order lookups to an order specialist and return decisions to a returns policy specialist.

> Note: Each delegation is a full agent run, so it adds latency and token usage, and each agent enforces its own maximum number of iterations. Delegate only the subtasks that need their own reasoning, and use a tool for a single action.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_as_tool.bal :::

::: out ai_agent_as_tool.out :::

## Related links
- [The Agent definitions example](/learn/by-example/ai-agent-definitions/)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent with typed input and output example](/learn/by-example/ai-agent-typed-input-output/)
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
