# HTTP service - Response with multiparts

The multipart payload is one or more different sets of data combined in a single body. HTTP service supports multipart content setting and retrieval in the `http:Response` along with the nested parts through support functions. An array of `mime:Entity` is returned when retrieving parts through the `getBodyParts` method of the `http:Response`. If the received parts contain nested parts, you can loop through the parent parts and get the child parts. When sending out multipart content, `setBodyParts` is used to set the array of `mime:Entity`. This is useful to handle different content typed messages as a single payload and large payloads.

::: code http_response_with_multiparts.bal :::

Run the service as follows.

::: out http_response_with_multiparts.server.out :::

## Prerequisites
In the directory, which contains the `.bal` file, create a directory named `files`, and add an XML file named `test.xml` in it.

Invoke the service by executing the following cURL command in a new terminal.

::: out http_response_with_multiparts.1.client.out :::

To decode the inbound response with multiparts, execute the following cURL command.

::: out http_response_with_multiparts.2.client.out :::

## Related links
- [`setBodyParts()` - API documentation](https://lib.ballerina.io/ballerina/mime/latest/classes/Entity#setBodyParts)
- [HTTP service supported-multipart-types - Specification](/spec/mime/#3-supported-multipart-types)
