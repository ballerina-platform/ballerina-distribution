# HTTP service - Response With multiparts

Ballerina supports encoding and decoding multipart content in HTTP responses along with the nested parts. When you request multiparts from an HTTP inbound response, you get an array of the parts of the body (an array of entities). If the received parts contain nested parts, you can loop through the parent parts and get the child parts.

For more information on the underlying module, see the [`mime` module](https://lib.ballerina.io/ballerina/mime/latest/).

::: code http_response_with_multiparts.bal :::

Run the service as follows.

::: out http_response_with_multiparts.server.out :::

Invoke the service by executing the following cURL command in a new terminal.
In the directory, which contains the `.bal` file, create a directory named `files`, and add an XML file named `test.xml` in it.

::: out http_response_with_multiparts.client.out :::
