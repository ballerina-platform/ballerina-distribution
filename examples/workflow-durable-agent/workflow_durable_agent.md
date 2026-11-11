# Durable agent

A durable agent is an AI agent that runs as a workflow. The runtime records each model call and tool call, so the agent survives crashes and restarts without repeating completed calls. Declare it with `workflow:DurableAgent`, start it with `run`, and read its answer with `waitForResult`.

Activities given to the agent become tools that the model can call. The doc comment of an activity describes the tool to the model.

The model provider in this example is `ballerinax/ai.openai`. Set your OpenAI API key in the `Config.toml` file. To use another model, replace it with any `ai:ModelProvider` implementation, such as `ballerinax/ai.anthropic` or `ballerinax/ai.ollama`.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_durable_agent.bal :::

To run this example, add the following `Config.toml` file next to the source file. In `IN_MEMORY` mode, workflow state lasts only while the program runs. To keep it across restarts, set `mode` to `LOCAL` and run a Temporal server.

::: code Config.toml :::

Run the program by executing the following command. The answer of the model may differ.

::: out workflow_durable_agent.out :::

## Related links
- [Activity](/learn/by-example/workflow-activity)
- [Durable agent with human task](/learn/by-example/workflow-durable-agent-human-task)
- [Durable agent with data events](/learn/by-example/workflow-durable-agent-data-events)
