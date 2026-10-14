# Durable agent with data events

A durable agent can receive data events while it runs, such as the turns of a conversation. Declare each event channel in `events` with its request and response types. Send an event with `sendData`, which returns a token, and read the reply of that turn with `waitForDataResult`. The agent keeps its state between events and survives restarts.

The model provider in this example is `ballerinax/ai.openai`. Set your OpenAI API key in the `Config.toml` file. To use another model, replace it with any `ai:ModelProvider` implementation, such as `ballerinax/ai.anthropic` or `ballerinax/ai.ollama`.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_durable_agent_data_events.bal :::

To run this example, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the program by executing the following command. The answers of the model may differ.

::: out workflow_durable_agent_data_events.out :::

## Related links
- [Data events](/learn/by-example/workflow-data-events)
- [Durable agent](/learn/by-example/workflow-durable-agent)
- [Durable agent with human task](/learn/by-example/workflow-durable-agent-human-task)
