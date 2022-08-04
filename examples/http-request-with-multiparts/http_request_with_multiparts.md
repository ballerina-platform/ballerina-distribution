# Request With multiparts

Ballerina supports encoding and decoding multipart content in http requests along with nested parts.
When you request multiparts from the HTTP inbound request, you get an array of body parts (an array of entities).
You can loop through this array and handle the received body parts according to your requirement.<br/><br/>
For more information on the underlying module, 
see the [Mime module](https://lib.ballerina.io/ballerina/mime/latest/).

::: code http_request_with_multiparts.bal :::

::: out http_request_with_multiparts.client.out :::

::: out http_request_with_multiparts.server.out :::