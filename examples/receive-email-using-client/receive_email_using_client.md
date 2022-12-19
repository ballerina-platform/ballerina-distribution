# Email client - Receive email

An email server supports either POP3 or IMAP as mail access protocol. The Ballerina `email` module provides support for POP3 and IMAP mail access clients to read data from an email server. Configure either an `email:PopClient` or an `email:ImapClient` and invoke `receiveMessage` client function to retrieve data from the server. 

::: code receive_email_using_client.bal :::

## Prerequisites
- Email server should be up and running.

Run the sample code by executing the following command.

::: out receive_email_using_client.out :::

## Related links
- [`email:PopClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/PopClient)
- [`email:ImapClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/ImapClient)
- [POP3 client - Specification](https://ballerina.io/spec/email/#32-pop3-client)
- [IMAP client - Specification](https://ballerina.io/spec/email/#33-imap-client)
