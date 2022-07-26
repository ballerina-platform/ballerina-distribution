# Resource methods

Service objects use `remote` methods to expose services in a procedural style. Remote methods are named by verbs.
Service objects use `resource` methods to expose services in a RESTful style. Resources are named by nouns. Resources are motivated by HTTP but are general enough to work for GraphQL. `resource` methods are a network-oriented generalization of the OO `getter/setter` concept.

::: code resource_methods.bal :::

Run the service using the `bal run` command.

::: out resource_methods.server.out :::

Run this cURL command to invoke the resource.

::: out resource_methods.client.out :::