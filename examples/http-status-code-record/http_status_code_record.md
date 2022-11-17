# Status code response records

The resource method can return `StatusCodeResponse` records that contains response headers and payload. Ballerina 
provides build in records for each HTTP status codes. In addition to that, record constants are also available in
any modification is not needed for the default data.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [specification](https://ballerina.io/spec/http/#2351-status-code-response).

::: code http_status_code_record.bal :::

Run the service as follows.

::: out http_status_code_record.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_status_code_record.client.out :::
