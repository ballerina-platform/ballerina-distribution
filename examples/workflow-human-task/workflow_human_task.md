# Human task

A human task pauses a workflow until a person makes a decision, such as approving an order. Call `ctx->awaitHumanTask` with a task name, the input to show to the person, and who can complete it. The workflow waits durably and resumes with the submitted result, which is checked against the result type.

Applications interact with human tasks in one of two ways.
- **Program API**: Call `management:listPendingHumanTasks` and `workflow:completeHumanTask` from your own code, as this example does from an HTTP service.
- **REST API**: Enable the built-in workflow management REST API. See the [Human task with REST API](/learn/by-example/workflow-human-task-rest-api) example.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_human_task.bal :::

To run this example, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the service as follows.

::: out workflow_human_task.server.out :::

In a new terminal, start a workflow, list its pending task, and complete the task as a manager. Replace the IDs with the ones that you receive.

::: out workflow_human_task.client.out :::

## Related links
- [Human task with REST API](/learn/by-example/workflow-human-task-rest-api)
- [Data events](/learn/by-example/workflow-data-events)
- [Durable agent with human task](/learn/by-example/workflow-durable-agent-human-task)
