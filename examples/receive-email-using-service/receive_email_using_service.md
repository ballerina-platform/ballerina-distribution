# Email service - Receive email

The `email:Service` received messages from an email server via IMAP4 using the `email:ImapListener`.

An `email:Service` which is attached to an `email:ImapListener` can receive emails from an email server via IMAP protocol. An `email:ImapListener` can be initialized by providing the hostname, username, and password. Once connected, `onMessage` method will be invoked whenever an email is read from the email server. If there is an error while reading the data from the server, `onError` method will be invoked with relevant error details. If the email server supports both POP3 and IMAP, it is recommended to use the IMAP as it provides the ability to manage emails using multiple devices or email clients, while allowing access to emails that are already read. 

>**Note:** The Ballerina `email` module also provides an `email:PopListener` which can be used likewise. The only difference is that the `email:PopListener` uses POP3 protocol for communication. 

::: code receive_email_using_service.bal :::

## Prerequisites
- Email server should be up and running.

Run the email service by executing the following command.

::: out receive_email_using_service.out :::

## Related links
- [`email:ImapListener` listener object - API documentation](https://lib.ballerina.io/ballerina/email/latest/classes/ImapListener)
- [`email:PopListener` listener object - API documentation](https://lib.ballerina.io/ballerina/email/latest/classes/PopListener)
- [Email service - Specification](https://ballerina.io/spec/email/#4-service)
