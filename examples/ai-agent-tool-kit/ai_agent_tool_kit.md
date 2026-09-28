# AI agents with tool kits

Ballerina enables developers to easily create intelligent AI agents powered by large language models (LLMs) and integrated with tools, including local tools, MCP tools, and external APIs. These AI agents can automate complex workflows, interact with users through natural language, and seamlessly connect with internal and external systems.

This example demonstrates how to create an AI agent that can manage a to-do list by using a toolkit that encapsulates a set of related tools for a task management REST API. Toolkits allow for better encapsulation and reusability compared to using standalone functions, especially when building complex agents with multiple related capabilities.

A toolkit is a class that includes the `ai:BaseToolKit` type and returns its tools from the `getTools` method. Since the class defines its own `init` method, it controls how the tools are created. In this example, the toolkit takes the URL and the bearer token configuration of the API and keeps the HTTP client to itself, so the credentials never reach the LLM. The `permittedTools` parameter selects the tools that the agent gets, and the `readOnly` parameter leaves out the tools that change the tasks. The agent in this example can list and add tasks, but it does not get the tool that completes tasks.

> Note: The example starts a mock task management API on port 9095, so that it is self-contained.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tool_kit.bal :::

::: out ai_agent_tool_kit.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration)
- [The Agent with advanced MCP integration example](/learn/by-example/ai-agent-mcp-integration-advanced)
- [The Agent with external endpoint integration example](/learn/by-example/ai-agent-external-endpoint-integration)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
