# Data events

A running workflow can wait for data from outside, such as a payment confirmation or a user decision. Declare each data event as a `future` field of a record in the third parameter of the workflow, and wait for it with `wait`. The workflow pauses durably until the data arrives.

Send data to an instance with `workflow:sendData` from any part of the program, such as a service or a message listener. The workflow management REST API can also send it with `POST /workflow/workflows/{id}/data/{dataName}`.

For more information on the underlying module, see the [`ballerina/workflow` module](https://lib.ballerina.io/ballerina/workflow/latest/).

::: code workflow_data_events.bal :::

To run this example, add the following `Config.toml` file next to the source file.

::: code Config.toml :::

Run the program by executing the following command.

::: out workflow_data_events.out :::

## Related links
- [Workflow](/learn/by-example/workflow-function)
- [Human task](/learn/by-example/workflow-human-task)
- [Durable agent with data events](/learn/by-example/workflow-durable-agent-data-events)
