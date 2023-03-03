# Email client - SSL/TLS 

The `email:ImapClient` can be configured to communicate through SSL/TLS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the client configuration. In addition to the certificate configuration, an optional `security` configuration is available to define the underlying transport protocol which needs to be used. The Ballerina `email` module supports both `STARTTLS` and `SSL` as the transport protocol. Use this to interact with email servers based on SSL/TLS encrypted secured connection.

>**Note:** The Ballerina `email` module also provides an `email:PopClient` which can be used likewise.

::: code email_client_ssl_tls.bal :::

## Prerequisites
- The email server should be up and running.

Run the sample code by executing the following command.

::: out email_client_ssl_tls.out :::

## Related links
- [`email:SecureSocket` - API documentation](https://lib.ballerina.io/ballerina/email/latest#SecureSocket)
- [`email:Security` enum - API documentation](https://lib.ballerina.io/ballerina/email/latest#Security)
