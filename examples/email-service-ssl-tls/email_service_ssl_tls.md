# Email service - SSL/TLS 

The `email:Service` receives messages from an email server via IMAP using the `email:ImapListener`. An `email:ImapListener` secured with SSL/TLC is created by providing the `secureSocket` configuration which requires the certificate of the email server as the `cert`. Use this to interact with email servers based on SSL/TLS encrypted secured connection.  

>**Note:** The Ballerina `email` module also provides an `email:PopListener` which can be used likewise.

::: code email_service_ssl_tls.bal :::

## Prerequisites
- Email server should be up and running.

Run the service by executing the command below.

::: out email_service_ssl_tls.out :::

## Related links
- [`email:SecureSocket` - API documentation](https://lib.ballerina.io/ballerina/email/latest/records/SecureSocket)
- [`tcp` module - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [TCP SSL/TLS - Specification](/spec/tcp/#511-configuring-tls-in-server-side)
