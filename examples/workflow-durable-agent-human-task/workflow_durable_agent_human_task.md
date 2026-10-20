# Durable agent with human task

A durable agent can involve a person before it acts. Each entry in `humanTasks` becomes a tool. When the model calls it, the agent creates a human task and pauses durably, for hours or days if needed, until a person completes it. The model then continues with the result.

In this example, a manager completes the task through the workflow management REST API. The program API (`workflow:completeHumanTask`) works the same way. Authentication is off for this example, so any caller can set its roles with the `x-user-roles` header. In production, enable JWT or OAuth2 authentication so that the roles come from a verified token.

The model provider in this example is `ballerinax/ai.openai`. Set your OpenAI API key in the `Config.toml` file. To use another model, replace it with any `ai:ModelProvider` implementation, such as `ballerinax/ai.anthropic` or `ballerinax/ai.ollama`.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_durable_agent_human_task.bal :::

To run this example, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the program as follows. The program waits after the agent starts.

::: out workflow_durable_agent_human_task.server.out :::

In a new terminal, list the pending task of the agent and complete it as a manager. Replace the IDs with the ones that you receive. The agent then issues the refund and answers.

::: out workflow_durable_agent_human_task.client.out :::

## Related links
- [Human task](/learn/by-example/workflow-human-task)
- [Human task with REST API](/learn/by-example/workflow-human-task-rest-api)
- [Durable agent](/learn/by-example/workflow-durable-agent)
