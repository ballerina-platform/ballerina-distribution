# Agent with persistent memory

By default, an agent keeps the conversation history in memory, so the history is lost when the program stops and cannot be shared across agent instances. To keep it, store the history in a persist store. Persist stores are available for SQLite (`ballerinax/ai.sqlite`), PostgreSQL (`ballerinax/ai.memory.postgresql`), Redis (`ballerinax/ai.memory.redis`), Microsoft SQL Server (`ballerinax/ai.memory.mssql`), and Amazon DynamoDB (`ballerinax/ai.aws.dynamodb`). These stores also keep runs that are paused for human approval, once you create the checkpoint table.

This example stores the history in a SQLite database, so running the program again continues the same conversation.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerinax/ai.sqlite` module](https://central.ballerina.io/ballerinax/ai.sqlite/latest).

::: code ai_agent_persistent_memory.bal :::

::: out ai_agent_persistent_memory.out :::

## Related links
- [The Agent with in-memory short-term memory example](/learn/by-example/ai-agent-memory/)
- [The Memory overflow handling example](/learn/by-example/ai-agent-memory-overflow-handling/)
- [The `ballerinax/ai.sqlite` module](https://central.ballerina.io/ballerinax/ai.sqlite/latest)
- [The `ballerinax/ai.memory.postgresql` module](https://central.ballerina.io/ballerinax/ai.memory.postgresql/latest)
- [The `ballerinax/ai.memory.redis` module](https://central.ballerina.io/ballerinax/ai.memory.redis/latest)
- [The `ballerinax/ai.memory.mssql` module](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest)
- [The `ballerinax/ai.aws.dynamodb` module](https://central.ballerina.io/ballerinax/ai.aws.dynamodb/latest)
