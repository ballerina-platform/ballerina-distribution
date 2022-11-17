# Documentation

A GraphQL schema can include documentation for the schema. These documentation can help you to understand the schema. In Ballerina, the Ballerina doc comments can be used to add documentation to various schema members.

This example shows how to add doc comments to the GraphQL service so that the generated schema will include them as the documentation.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_documentation.bal :::

Run the service by executing the following command.

::: out graphql_documentation.server.out :::

Send the following document with an introspection query to test how the documentation is added to the schema.

```graphql
 {
    __schema {
        queryType {
            fields {
                name
                description
                type {
                    name
                    description
                    fields {
                        name
                        description
                    }
                }
                args {
                    name
                    description
                }
            }
        }
    }
}
```

To send the document, use the following cURL command in a separate terminal.

::: out graphql_documentation.client.out :::
