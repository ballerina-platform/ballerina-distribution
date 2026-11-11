# Passing context to agent tools

Some values a tool needs, such as the ID of the signed-in customer, must come from your application, not from the LLM. Pass them in an `ai:Context`: set the values with `set`, pass the context to `run`, and read them in the tool with `getWithType`. A tool receives the context by declaring an `ai:Context` as its first parameter. This parameter is not part of the tool schema, so the LLM can neither see nor change these values.

This example uses the customer ID from the context in its tools, and runs the same agent for two customers with two different contexts.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tool_context.bal :::

::: out ai_agent_tool_context.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
- [The Human-in-the-loop tool approval example](/learn/by-example/ai-agent-human-in-the-loop/)
