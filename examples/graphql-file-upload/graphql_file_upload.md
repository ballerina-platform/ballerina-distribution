# GraphQL service - File upload

The Ballerina `graphql` module allows uploading files to a GraphQL schema. To enable file uploading in a GraphQL service, add the `graphql:Upload` record as an input parameter of a `remote` method inside a `graphql:Service`. The `graphql:Upload` record includes the details of the file that is being uploaded. The GraphQL file upload follows the _Graphql Multipart Request Spec_ to upload the files. Use this to create a GraphQL API where users can upload files.

::: code graphql_file_upload.bal :::

Run the service by executing the following command.

::: out graphql_file_upload.server.out :::

To upload a file, send an HTTP multipart request to the GraphQL endpoint using the following cURL command.

The first part of the request is `operations` field that includes a `JSON-encoded` map. This field is similar to a standard HTTP POST request that being sent to a GraphQL endpoint, except where the variable values related to the file upload should be `null`.

The second part of the request is the `map` field, which is a `JSON-encoded` map. It contains a mapping between the variables defined in the first part of the request and the files that are mentioned in the next part. The `key` is used to map a file using the key provided in the next part of the request, and the value is mapped to the variable name defined in the previous part. Multiple variables can have the same file, so the value is an array.

Next part contains the unique key for each file and the path for each file. The `key` in this part should be the same key used in the previous part.

Following is a complete cURL request to send a multipart request to upload files to the GraphQL service.

::: out graphql_file_upload.client.out :::

This will create a directory `uploads` where the service is running, and then saves the `file1.png` inside it.

## Related links
- [`graphql:Upload` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#Upload)
- [GraphQL multipart request specification](https://github.com/jaydenseric/graphql-multipart-request-spec)
- [GraphQL file upload - Specification](/spec/graphql/#6-file-upload)
