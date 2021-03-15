import ballerina/email;

public function main() returns error? {
    // Creates an SMTP client with the connection parameters, host, username,
    // and password. The default port number `465` is used over SSL with these
    // configurations. `SmtpConfig` can be configured and passed to this
    // client if the port or security is to be customized.
    email:SmtpClient smtpClient = check new ("smtp.email.com",
        "sender@email.com" , "pass123");

    // Define the email that is required to be sent.
    email:Message email = {
        // "TO", "CC", and "BCC" address lists are added as follows.
        // Only the "TO" address list is mandatory out of these three.
        to: ["receiver1@email.com", "receiver2@email.com"],
        cc: ["receiver3@email.com", "receiver4@email.com"],
        bcc: ["receiver5@email.com"],
        // Subject of the email is added as follows. This field is mandatory.
        subject: "Sample Email",
        // Body content (text) of the email is added as follows.
        // This field is optional.
        body: "This is a sample email.",
        // Email author's address is added as follows. This field is mandatory.
        'from: "author@email.com",
        // Email sender service address is added as follows.
        // This field is optional. `Sender` is same as the `'from` when the
        // email author himself sends the email.
        sender: "sender@email.com",
        // List of recipients when replying to the email is added as follows.
        // This field is optional. These addresses are required when the emails
        // are to be replied to some other address(es) other than the sender or
        // the author.
        replyTo: ["replyTo1@email.com", "replyTo2@email.com"]
    };

    // Send the email message with the client. The `send` method can be used
    // instead, if the email is required to be sent with mandatory and optional
    // parameters instead of configuring an `email:Message` record.
    check smtpClient->sendMessage(email);

}
