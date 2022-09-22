# Streaming

Ballerina supports HTTP input and output streaming capability based on the Ballerina `stream` type.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_streaming.bal :::

Run the service as follows.

::: out http_streaming.server.out :::

Invoke the service by executing the following cURL command in a new terminal.
In the directory, which contains the `.bal` file, create a directory named `files`,
and add a PDF file named `BallerinaLang.pdf` in it.

::: out http_streaming.client.out :::
