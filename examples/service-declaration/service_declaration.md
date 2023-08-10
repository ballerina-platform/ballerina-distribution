# Service declaration

A service represents a collection of remotely accessible methods attached to a particular listener. A service declaration is syntactic sugar for creating services in Ballerina.  A service declaration gets desugared into several things including creating a listener object, registering it with the module, creating a service object, attaching the service object to the listener object, etc,.

The type of the listener determines required type of remote methods.

::: code service_declaration.bal :::

Run the service using the `bal run` command.

::: out service_declaration.server.out :::

Use the following Netcat (or nc) command to send packets to the service.

::: out service_declaration.client.out :::