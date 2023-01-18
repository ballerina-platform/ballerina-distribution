# Email service - Receive email

The email service is used to receive (with POP3 or IMAP4) emails using the SSL or STARTTLS protocols. This sample includes receiving emails service attached to a POP3 listener with default configurations over SSL using the default ports. To use IMAP4 the user can use `IMAP listener`.

::: code receive_email_using_service.bal :::

## Prerequisites
- Email server should be up and running.

Run the email service by executing the following command.

::: out receive_email_using_service.out :::

## Related links
- [`email:PopListener` listener object - API documentation](https://lib.ballerina.io/ballerina/email/latest/classes/PopListener)
- [`email:PopListener` listener object - API documentation](https://lib.ballerina.io/ballerina/email/latest/classes/ImapListener)
- [`email` service - Specification](https://ballerina.io/spec/email/#4-service)
