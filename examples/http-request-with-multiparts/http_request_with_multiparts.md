# HTTP client - Request with multiparts

The multipart payload is one or more different sets of data combined in a single body. The `http:Client` supports multipart content setting and retrieving in the `http:Request` along with the nested parts through support functions. An array of `mime:Entity` is returned when retrieving parts through `getBodyParts` method of the `http:Request`. If the received parts contain nested parts, you can loop through the parent parts and get the child parts. When sending out multipart content, `setBodyParts` is used to set the array of `mime:Entity`. This is useful to handle different content-typed messages as a single payload and large payloads.

::: code http_request_with_multiparts.bal :::

Run the service as follows.

::: out http_request_with_multiparts.server.out :::

## Prerequisites
In the directory, which contains the `.bal` file, create a directory named `files`, and add an XML file named `test.xml` in it.

Invoke the service by executing the following cURL command in a new terminal.

::: out http_request_with_multiparts.1.client.out :::

Execute the following cURL command to encode the parts of the body and send a multipart request via the Ballerina service.

::: out http_request_with_multiparts.2.client.out :::

## Related links
- [`setBodyParts()` - API documentation](https://lib.ballerina.io/ballerina/http/latest#Request#setBodyParts)
- [HTTP client supported-multipart-types - Specification](/spec/mime/#3-supported-multipart-types)
