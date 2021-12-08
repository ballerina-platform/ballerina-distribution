import ballerina/email;
import ballerina/io;

public function main() returns error? {
    // Creates the client with the connection parameters, host, username, and
    // password. An error is returned in a failure. The default port number
    // `995` is used over SSL with these configurations.
    email:PopClient popClient = check new ("pop.email.com", "reader@email.com",
        "pass456");

    // Reads the first unseen email received by the POP3 server. `()` is
    // returned when there are no new unseen emails. In error cases, an
    // error is returned.
    email:Message? emailResponse = check popClient->receiveMessage();

    if (emailResponse is email:Message) {
        io:println("POP client received an email.");
        io:println("Email Subject: ", emailResponse.subject);
        io:println("Email Body: ", emailResponse?.body);
    // When no emails are available in the server, `()` is returned.
    } else {
        io:println("There are no emails in the INBOX.");
    }

    // Closes the POP3 store, which would close the TCP connection.
    check popClient->close();

    // Creates the client with the connection parameters, host, username, and
    // password. An error is received in a failure. The default port number
    // `993` is used over SSL with these configurations.
    email:ImapClient imapClient = check new ("imap.email.com",
        "reader@email.com", "pass456");

    // Reads the first unseen email received by the IMAP4 server. `()` is
    // returned when there are no new unseen emails. In error cases, an
    // error is returned.
    emailResponse = check imapClient->receiveMessage();

    if (emailResponse is email:Message) {
        io:println("IMAP client received an email.");
        io:println("Email Subject: ", emailResponse.subject);
        io:println("Email Body: ", emailResponse?.body);
    // When no emails are available in the server, `()` is returned.
    } else {
        io:println("There are no emails in the INBOX.");
    }

    // Closes the IMAP store which would close the TCP connection.
    check imapClient->close();

}
