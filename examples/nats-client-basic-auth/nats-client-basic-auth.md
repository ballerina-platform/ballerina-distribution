# NATS client - Basic authentication

NATS client connections can be authenticated in many ways. One of them is by using the username and password credentials. In this example, the underlying connection of the publisher is secured with basic authentication. 

::: code nats-client-basic-auth.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

::: out nats-client-basic-auth.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [`nats:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
