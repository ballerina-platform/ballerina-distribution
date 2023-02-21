# HTTP client - File upload

The output streaming is generally handled through the Ballerina `stream` type. Additionally, the `setFileAsPayload` of the `http:Request` is the support function dedicated to file uploads. This is useful when handling continuous payload, file uploads, etc.

::: code http_client_file_upload.bal :::

## Prerequisites
- Run the HTTP service given in the [Service file upload](/learn/by-example/http-service-file-upload/) example.

Run the client program by executing the following command.

::: out http_client_file_upload.out :::

## Related links
- [`setFileAsPayload()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Request#setFileAsPayload)
- [`http` module - Specification](/spec/http/#2423-resource-methods)
