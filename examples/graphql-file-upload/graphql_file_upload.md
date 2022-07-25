# File upload

GraphQL package provides a way to upload files through the GraphQL endpoints with GraphQL mutations. To define
an endpoint with the file upload capability, the `graphql:Upload` type can be used as the input parameter of
resolver functions. The `graphql:Upload` type can represent the details of the file that needs to be uploaded and
that can be used only with the remote functions. The value of `graphql:Upload` type is extracted from the HTTP
multipart request, which will be received by the GraphQL endpoints. This example shows how to implement a GraphQL endpoint that
can be used to upload files.
<br/><br/>
For more information on the underlying package, see the
[GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_file_upload.bal :::

::: out graphql_file_upload.client.out :::

::: out graphql_file_upload.server.out :::