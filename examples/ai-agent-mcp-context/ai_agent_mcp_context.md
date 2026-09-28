# Passing context to MCP tools

An agent tool that calls an MCP server often needs a value that the application knows and the LLM must not choose, such as the tenant of the signed-in user. The `ai:Context` carries that value from the caller to the tool, and the `_meta` field of the MCP request carries it on to the server. Neither appears in the schema sent to the LLM.

The tool declares an `ai:Context` as its first parameter, reads the value from it, and sets the value on the `_meta` field of `mcp:CallToolParams`. On the server side, an `mcp:StreamableHttpAdvancedService` reads it from `params._meta` in its `onCallTool` method, as demonstrated in the [MCP advanced service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example. To send request metadata from a plain MCP client without an agent, see the [MCP client with request metadata](/learn/by-example/mcp-client-with-request-metadata/) example.

> Prerequisite: Start the MCP server from the [MCP advanced service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example before running this example.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_mcp_context.bal :::

::: out ai_agent_mcp_context.out :::

## Related links
- [The MCP advanced service with request metadata example](/learn/by-example/mcp-service-with-request-metadata/)
- [The MCP client with request metadata example](/learn/by-example/mcp-client-with-request-metadata/)
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
