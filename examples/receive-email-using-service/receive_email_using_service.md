# Email service - Receive email

An email server supports either POP3 or IMAP as mail access protocol. The `email:Service` allows reading data from an email server that supports either protocol. Configure either an `email:PopListener` or an `email:ImapListener` and attach the `email:Service` to retrieve data from the server. 

::: code receive_email_using_service.bal :::

## Prerequisites
- Email server should be up and running.

Run the email service by executing the following command.

::: out receive_email_using_service.out :::

## Related links
- [`email:PopListener` listener object - API documentation](https://lib.ballerina.io/ballerina/email/latest/classes/PopListener)
- [`email:ImapListener` listener object - API documentation](https://lib.ballerina.io/ballerina/email/latest/classes/ImapListener)
- [Email service - Specification](https://ballerina.io/spec/email/#4-service)
