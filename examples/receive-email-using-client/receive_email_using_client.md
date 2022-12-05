# Email client - Receive email

The email client is used to receive (with POP3 or IMAP4) emails using the SSL or STARTTLS protocols. This sample includes receiving emails with default configurations over SSL using the default ports via POP3. Since, IMAP4 has similar syntax we could replace `POP3 client` with `IMAP client`.

::: code receive_email_using_client.bal :::

## Prerequisites
- Email server should be up and running.

Run the sample code by executing the following command.

::: out receive_email_using_client.out :::

## Related links
- [`email:PopClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/PopClient)
- [`email:ImapClient` client object - API documentation](https://lib.ballerina.io/ballerina/email/latest/clients/ImapClient)
- [`email:PopClient` functions - Specification](https://ballerina.io/spec/email/#32-pop3-client)
- [`email:ImapClient` functions - Specification](https://ballerina.io/spec/email/#33-imap-client)
