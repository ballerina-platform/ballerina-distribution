# Human task with REST API

The workflow module has a built-in management REST API. Applications such as a task inbox use it to list and complete human tasks without any extra code. Import `ballerina/workflow.management.rest` and set `enableManagementApi` to `true` in the `Config.toml` file. The API is served at `http://localhost:8234/workflow`.

The API lists and completes a task only for a caller who is allowed to act on it. With authentication off, as in this example, any caller can set its roles with the `x-user-roles` header. In production, enable JWT or OAuth2 authentication so that the roles come from a verified token.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_human_task_rest_api.bal :::

To run this example, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the service as follows.

::: out workflow_human_task_rest_api.server.out :::

In a new terminal, start a workflow. Then, list its pending tasks and complete one as a manager through the management REST API. Replace the IDs with the ones that you receive.

::: out workflow_human_task_rest_api.client.out :::

## Related links
- [Human task](/learn/by-example/workflow-human-task)
- [Durable agent with human task](/learn/by-example/workflow-durable-agent-human-task)
