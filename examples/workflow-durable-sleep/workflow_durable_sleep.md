# Durable sleep

A workflow can pause for minutes, hours, or days with `ctx.sleep`. Unlike a regular sleep, the timer is recorded by the runtime. If the program restarts, the workflow continues the countdown instead of starting it again. Use it for reminders, follow-ups, and timeouts.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_durable_sleep.bal :::

To run this example, add the following `Config.toml` file next to the source file. In `IN_MEMORY` mode, workflow state lasts only while the program runs. To keep it across restarts, set `mode` to `LOCAL` and run a Temporal server.

::: code Config.toml :::

Run the program by executing the following command. The reminder is sent after five seconds.

::: out workflow_durable_sleep.out :::

## Related links
- [Workflow](/learn/by-example/workflow-function)
- [Activity](/learn/by-example/workflow-activity)
