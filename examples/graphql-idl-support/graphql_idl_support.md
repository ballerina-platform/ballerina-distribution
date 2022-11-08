# IDL client declaration

The IDL client declaration support can be used to import the GraphQL config files into your Ballerina code and generate the counterpart client declaration based on it. The client declaration(s) should be declared at the module level.
>**Note:** The client declaration support can be used only within a Ballerina package and it is not supported within standalone Ballerina files. The `graphql.config.yaml` file should be located inside the root directory of the Ballerina package.

::: graphql_idl_support.bal :::

Specify the query and SDL in the `graphql.config.yaml` file. For more information on the GraphQL document file, queries, and schema(SDL) with examples, see the [GraphQL client tool](https://ballerina.io/learn/graphql-client-tool/).

Further, to get the available methods and data types suggested, it is recommended to build the project just after declaring the client and that will extract the methods and data types resources from the GraphQL schema. Then, it would be convenient to continue the development of your application.

Run the Ballerina project by executing the following command.

::: graphql_idl_support.out :::

