# GraphQL output object - Service

A GraphQL resource function can return service objects. The returning service objects are mapped to an `OBJECT` type in the GraphQL schema. Each resource function in the returned service object becomes a field in the created `OBJECT` type.

This example shows a GraphQL endpoint, which has a field `profile` of type `Person!` in the root `Query` type. A GraphQL client can query on this service to retrieve specific fields or subfields of the `Person` object.

>**Note:** Although both the record and service types can be used to represent an Object type, using a record type as an Object has limitations. For example, a field represented as a record field can not have an input argument, as opposed to a field represented using a resource method in a service class.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_returning_service_objects.bal :::

Run the service by executing the following command.

::: out graphql_returning_service_objects.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_returning_service_objects.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_returning_service_objects.client.out :::
