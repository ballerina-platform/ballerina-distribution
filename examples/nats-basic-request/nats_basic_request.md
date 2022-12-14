# NATS client - Send request message

The NATS client allows sending request messages to a given subject. A NATS client is created by passing the URL of the NATS broker. The `requestMessage` method can be used to send requests to the NATS server by providing a target subject, an optional reply subject, the message content, and an optional duration for the timeout. After the request is sent, the application waits on the response with the given timeout. Use it when you want to send request messages, which expect a reply back.

::: code nats_basic_request.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).
- Run the NATS service given in the [NATS service - Send reply to request message](/learn/by-example/nats-basic-reply/) example.

Run the client program by executing the following command.

::: out nats_basic_request.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out nats_basic_request.client.out :::

## Related links
- [`nats:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [NATS publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
