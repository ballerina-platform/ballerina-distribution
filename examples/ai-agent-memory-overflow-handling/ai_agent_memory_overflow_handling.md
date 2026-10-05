# Memory overflow handling

Short-term memory keeps a fixed number of recent messages per session. When a session reaches the capacity of the store, the overflow handler of the `ai:ShortTermMemory` decides what happens to the oldest messages. The default trim strategy (`ai:TrimOverflowHandlerConfiguration`) removes them. The model-assisted strategy (`ai:ModelAssistedOverflowHandlerConfiguration`) uses an LLM to summarize them into a single message, so the important context is kept.

This example uses the model-assisted strategy with a small capacity, and prints the memory before and after the overflow to show the summary.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_memory_overflow_handling.bal :::

::: out ai_agent_memory_overflow_handling.out :::

## Related links
- [The Agent with in-memory short-term memory example](/learn/by-example/ai-agent-memory/)
- [The Agent with persistent memory example](/learn/by-example/ai-agent-persistent-memory/)
