# Email service - Receive email

The email service is used to receive (with POP3 or IMAP4) emails using the SSL or STARTTLS protocols. This sample includes receiving emails service attached to a POP3 listener with default configurations over SSL using the default ports. To use IMAP4 refer to [`IMAP listener`](https://lib.ballerina.io/ballerina/email/latest/classes/ImapListener).

::: code receive_email_using_service.bal :::

Run the email service by executing the following command.

>**Tip:** The subject and the content body of the listened emails will be printed for each of the polled emails.

::: out receive_email_using_service.out :::

## Related links
- [`email` - API documentation](https://lib.ballerina.io/ballerina/email/latest/)
- [`email` service - specification](https://ballerina.io/spec/email/#4-service)
