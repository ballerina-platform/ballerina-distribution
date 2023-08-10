# Email client - Send email

The `email:SmtpClient` connects to a given SMTP server to send emails. An `email:SmtpClient` is created by providing the hostname and required credentials.  Once connected, the `sendMessage` or the `send` methods are used to send emails. An `email:Message` record, which contains the required information about the email can be passed to the `sendMessage` method. If additional information is not required, the `send` method can be used only with mandatory parameters such as `to`, `from`, `subject`, and `body`.

::: code send_email.bal :::

## Prerequisites
- SMTP server should be up and running.

Run the SMTP client by executing the following command.

::: out send_email.out :::

## Related links
- [`email:SmtpClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest#SmtpClient)
- [`email:Message` record - API documentation](https://lib.ballerina.io/ballerina/email/latest#Message)
- [SMTP client - Specification](https://ballerina.io/spec/email/#31-smtp-client)
