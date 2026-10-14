# Workflow

A workflow is a durable function that orchestrates the steps of a process. The runtime records the progress of each workflow instance, so the instance survives crashes and restarts and continues from where it stopped. Mark a function with `@workflow:Workflow`, start an instance with `workflow:run`, and read its result with `workflow:waitForResult`.

Workflow code must be deterministic. Do I/O and other side effects in activities.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_function.bal :::

This example runs the workflow engine inside the program. To run it, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the program by executing the following command.

::: out workflow_function.out :::

## Related links
- [Activity](/learn/by-example/workflow-activity)
- [Data events](/learn/by-example/workflow-data-events)
- [Durable sleep](/learn/by-example/workflow-durable-sleep)
