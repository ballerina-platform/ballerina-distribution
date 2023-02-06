# Email client - Receive email

The `email:ImapClient` can receive emails from an email server via IMAP protocol. An `email:ImapClient` can be created by providing the hostname, username, and password. Once connected, `receiveMessage` method is used to receive emails from the server. It is a blocking method with a timeout. When the email server supports both POP3 and IMAP, it is recommended to use the IMAP as it provides the ability to manage emails using multiple devices or email clients, while allowing access to emails that are already read. 

>**Note:** The Ballerina `email` module also provides an `email:PopClient` which can be used likewise. The only difference is that the `email:PopClient` uses POP3 protocol for communication. 

::: code receive_email_using_client.bal :::

## Prerequisites
- The email server should be up and running.

Run the sample code by executing the following command.

::: out receive_email_using_client.out :::

## Related links
- [`email:ImapClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/ImapClient)
- [`email:PopClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/PopClient)
- [IMAP client - Specification](https://ballerina.io/spec/email/#33-imap-client)
- [POP3 client - Specification](https://ballerina.io/spec/email/#32-pop3-client)
