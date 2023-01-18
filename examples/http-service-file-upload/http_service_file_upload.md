# HTTP service - File upload

Ballerina supports HTTP input and output streaming capability based on the Ballerina `stream` type. The example depicts a file upload through streaming.

::: code http_service_file_upload.bal :::

Run the service as follows.

::: out http_service_file_upload.server.out :::

Invoke the service via the [Client file upload](/learn/by-example/http-client-file-upload).

## Related links
- [`getByteStream()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/classes/Request#getByteStream)
- [`http` package - Specification](/spec/http/#41-service-configuration)
