# Agent with in-memory short-term memory

An AI agent remembers the conversation of each session separately. By default, the agent keeps the most recent messages of each session in memory. To keep the history after the program stops, see the [Agent with persistent memory](/learn/by-example/ai-agent-persistent-memory/) example. To create an agent that does not remember anything, set the `memory` field to `()`.

This example keeps a history per session, and then inspects and clears the stored messages.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_memory.bal :::

::: out ai_agent_memory.out :::

## Related links
- [The Agent with persistent memory example](/learn/by-example/ai-agent-persistent-memory/)
- [The Memory overflow handling example](/learn/by-example/ai-agent-memory-overflow-handling/)
- [The Chat agents example](/learn/by-example/chat-agents/)
- [The `ballerinax/ai.memory.postgresql` module](https://central.ballerina.io/ballerinax/ai.memory.postgresql/latest)
- [The `ballerinax/ai.memory.redis` module](https://central.ballerina.io/ballerinax/ai.memory.redis/latest)
- [The `ballerinax/ai.memory.mssql` module](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest)
- [The `ballerinax/ai.sqlite` module](https://central.ballerina.io/ballerinax/ai.sqlite/latest)
- [The `ballerinax/ai.aws.dynamodb` module](https://central.ballerina.io/ballerinax/ai.aws.dynamodb/latest)
