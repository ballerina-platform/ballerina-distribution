# Email client - Receive email

The `email:PopClient` can receive emails from an email server via POP3 protocol. An `email:PopClient` is created by providing the hostname, username, and password. Once connected, `receiveMessage` method is used to receive emails from the server. It is a blocking method with a default timeout. 

>**Note:** The Ballerina `email` module also provides an `email:ImapClient` which can be used likewise. The only difference is that the `email:ImapClient` uses IMAP protocol for communication. 

::: code receive_email_using_client.bal :::

## Prerequisites
- The email server should be up and running.

Run the sample code by executing the following command.

::: out receive_email_using_client.out :::

## Related links
- [`email:PopClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/PopClient)
- [`email:ImapClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/ImapClient)
- [POP3 client - Specification](https://ballerina.io/spec/email/#32-pop3-client)
- [IMAP client - Specification](https://ballerina.io/spec/email/#33-imap-client)
