# SOAP client security - Outbound security configuration

The `soap` client can be configured to apply outbound security configurations for decrypting the data in the SOAP response, and verifying the digital signature for security validation. The configurations can be set by passing `soap:OutboundSecurityConfig` to the `outboundSecurity` field of the client.

::: code soap_client_security_outbound_security_config.bal :::

Run the program by executing the following command.

::: out soap_client_security_outbound_security_config.out :::

## Related links

- [`soap` module - API documentation](https://central.ballerina.io/ballerina/soap/)
- [SOAP client security outbound security configuration - Specification](/spec/soap/#322-outbound-security-configurations)
