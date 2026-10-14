# Activity

An activity is a function that does the real work of a workflow, such as calling an API, querying a database, or sending an email. Mark it with `@workflow:Activity` and call it from a workflow with `ctx->callActivity`. The runtime records the result of each call, so a completed activity does not run again when the workflow recovers.

Activities do not retry by default. Pass a `retryPolicy` to `ctx->callActivity` to retry a failed call.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_activity.bal :::

To run this example, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the program by executing the following command.

::: out workflow_activity.out :::

## Related links
- [Workflow](/learn/by-example/workflow-function)
- [Data events](/learn/by-example/workflow-data-events)
