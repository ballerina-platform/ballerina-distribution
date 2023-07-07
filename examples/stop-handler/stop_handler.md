# `StopHandler`

A `StopHandler` is a function called during graceful shutdown, registered at runtime with a module.
This example demonstrates how to register a `StopHandler` that will be executed at the end of the program.

::: code stop_handler.bal :::

Navigate to the directory that contains the 'stop_handler.bal' file, and run the 'bal run' command.

::: out stop_handler.server.out :::

Invoke the service by executing the following cURL command in a new terminal to add a fruit item.

::: out stop_handler.client.out :::
