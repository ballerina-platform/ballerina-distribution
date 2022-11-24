# NATS service - Basic authentication

NATS client connections can be authenticated in many ways. One of them is using username and password credentials. In this example, the underlying connection of the listener is secured with basic authentication.

::: code nats-service-basic-auth.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

::: out nats-service-basic-auth.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [`nats:Listener` - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
