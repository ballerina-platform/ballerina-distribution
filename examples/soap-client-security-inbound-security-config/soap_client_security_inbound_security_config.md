# SOAP client security - Inbound security configuration

The `soap` client can be configured to apply inbound security settings when a request is made. These configurations include various web service security policies such as `Username Token`, `Timestamp Token`, `X509 Token`, `Symmetric Binding`, `Asymmetric Binding`, and `Transport Binding`. These configurations can be implemented individually or in combination with one another. After applying the security configuration, the required security tags will be included under the `<soap:Header>` tag within the SOAP envelope.

::: code soap_client_security_inbound_security_config.bal :::

Run the program by executing the following command.

::: out soap_client_security_inbound_security_config.out :::

## Related links

- [`soap` module - API documentation](https://central.ballerina.io/ballerina/soap/)
- [SOAP client security inbound security configuration - Specification](/spec/soap/#321-inbound-security-configurations)
