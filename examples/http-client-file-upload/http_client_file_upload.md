# HTTP client - File upload

Ballerina supports HTTP input and output streaming capability based on the Ballerina `stream` type. The example depicts a file upload through streaming.

::: code http_client_file_upload.bal :::

## Prerequisites
- Run the HTTP service given in the [Service file upload](/learn/by-example/http-service-file-upload/) example.

Run the client program by executing the following command.

::: out http_client_file_upload.out :::

## Related links
- [`setFileAsPayload()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Request#setFileAsPayload)
- [`http` package - Specification](/spec/http/#2423-resource-methods)
