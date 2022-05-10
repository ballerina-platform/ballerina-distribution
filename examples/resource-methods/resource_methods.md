# Resource methods

Service objects use `remote` methods to expose services in procedural style: remote methods are named by verbs. <br/><br/>
Service objects use `resource` methods to expose services in an RESTful style: resources are named by nouns. <br/><br/>
Resources are motivated by HTTP, but are general enough also to work for GraphQL. 
`resource` methods are a network-oriented generalization of OO getter/setter concept.

::: code ./examples/resource-methods/resource_methods.bal :::

::: out ./examples/resource-methods/resource_methods.client.out :::

::: out ./examples/resource-methods/resource_methods.server.out :::