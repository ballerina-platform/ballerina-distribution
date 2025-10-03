# Chat agents

Ballerina enables developers to easily create intelligent chat agents powered by large language models (LLMs) and integrated with tools, including local tools, MCP tools, and external APIs. These chat agents can maintain conversations across multiple sessions, handle concurrent users, and seamlessly integrate with web services and external systems.

This example demonstrates how to create a chat agent service that manages to-do lists while maintaining separate conversation sessions for different users through externally managed session IDs.

Copy the source to a Ballerina project and use the `Try it` CodeLens above the service declaration to use a chat interface within VS Code. 

> Note: This example uses the default model provider implementation. Log in to the Ballerina Copilot, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your keys to the `Config.toml` file. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code chat_agents.bal :::

::: out chat_agents.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration)
- [The Agent with external endpoint integration example](/learn/by-example/ai-agent-external-endpoint-integration)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
