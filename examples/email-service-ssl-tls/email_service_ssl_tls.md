# Email service - SSL/TLS 

The `email:Service` receives messages from an email server via IMAP using the `email:ImapListener`. An `email:ImapListener` secured with SSL/TLS is created by providing the `secureSocket` configuration which requires the certificate of the email server as the `cert`. In addition to the certificate configuration, an optional `security` configuration is available to define the underlying transport protocol which needs to be used. The Ballerina `email` module supports both `STARTTLS` and `SSL` as the transport protocol. Use this to interact with email servers based on SSL/TLS encrypted secured connection.  

>**Note:** The Ballerina `email` module also provides an `email:PopListener` which can be used likewise.

::: code email_service_ssl_tls.bal :::

## Prerequisites
- Email server should be up and running.

Run the service by executing the command below.

::: out email_service_ssl_tls.out :::

## Related links
- [`email:SecureSocket` - API documentation](https://lib.ballerina.io/ballerina/email/latest#SecureSocket)
- [`email:Security` enum - API documentation](https://lib.ballerina.io/ballerina/email/latest#Security)
