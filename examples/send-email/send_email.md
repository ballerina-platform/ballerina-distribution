# Email client - Send email

The `email:SmtpClient` connects to a given SMTP server, and then sends emails to the server. An `email:SmtpClient` is created by providing host-name and required credentials.  Once connected, `sendMessage` or `send` methods are used to send emails to the server. An `email:Message` record, which contains the required information about the email can be passed to the `sendMessage` method. If additional information is not required, the `send` method can be used only with mandatory parameters such as `to`, `from`, `subject`, and `body`. 

::: code send_email.bal :::

## Prerequisites
- SMTP server should be up and running.

Run the SMTP client by executing the following command.

::: out send_email.out :::

## Related links
- [`email:SmtpClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/SmtpClient)
- [`email:Message` record - API documentation](https://lib.ballerina.io/ballerina/email/latest/records/Message)
- [SMTP client - Specification](https://ballerina.io/spec/email/#31-smtp-client)
