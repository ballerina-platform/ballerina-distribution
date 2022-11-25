# Email client - Receive email

The email client is used to receive (with POP3 or IMAP4) emails using the SSL or STARTTLS protocols. This sample includes receiving emails with default configurations over SSL using the default ports via POP3. Since, IMAP4 has similar syntax we could replace `POP3 client` with [`IMAP client`](https://lib.ballerina.io/ballerina/email/latest/clients/ImapClient).

::: code receive_email_using_client.bal :::

Run the sample code by executing the following command.

::: out receive_email_using_client.out :::

## Related links
- [`email` - API documentation](https://lib.ballerina.io/ballerina/email/latest/)
- [`email` client - specification](https://ballerina.io/spec/email/#3-client)
