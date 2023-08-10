# HTTP service - File upload

The input streaming is handled through the Ballerina `stream` type. The resource can access the byte stream of the payload using the `getByteStream` method of the `http:Request`. This is useful when handling continuous payload, file uploads, etc.

::: code http_service_file_upload.bal :::

Run the service as follows.

::: out http_service_file_upload.server.out :::

>**Tip:** You can invoke the service via the [Client file upload](/learn/by-example/http-client-file-upload) example.

## Related links
- [`getByteStream()` - API documentation](https://lib.ballerina.io/ballerina/http/latest#Request#getByteStream)
- [`http` module - Specification](/spec/http/#41-service-configuration)
