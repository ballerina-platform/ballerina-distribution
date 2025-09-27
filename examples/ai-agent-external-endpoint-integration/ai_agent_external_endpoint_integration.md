# AI agents with external endpoints as tools

Ballerina enables developers to easily create intelligent AI agents powered by large language models (LLMs) and integrated with tools, including local tools, MCP tools, and external APIs. These AI agents can automate complex workflows, interact with users through natural language, and seamlessly connect with internal and external systems.

This example demonstrates how to create an AI agent that can access Gmail and Google Calendar by integrating with Google APIs as external endpoints. The agent functions as a personal assistant that can read emails, send emails, view calendar events, and create new calendar entries.

> Note: This example uses the default model provider implementation. Log in to the Ballerina Copilot, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your keys to the `Config.toml` file. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation. 

> Note: Follow the [connector setup guide](https://central.ballerina.io/ballerinax/googleapis.gmail/latest#setup-guide) to obtain the connector configuration.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_external_endpoint_integration.bal :::

::: out ai_agent_external_endpoint_integration.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
