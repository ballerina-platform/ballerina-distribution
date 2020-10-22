import ballerina/email;
import ballerina/test;

@test:Config {}
function testEmail() {
    email:SmtpClient smtpClient = new ("smtp.email.com", "sender@email.com"
        , "pass123");
    email:Email email = {
        to: ["receiver1@email.com", "receiver2@email.com"],
        cc: ["receiver3@email.com", "receiver4@email.com"],
        bcc: ["receiver5@email.com"],
        subject: "Sample Email",
        body: "This is a sample email.",
        'from: "author@email.com",
        sender: "sender@email.com",
        replyTo: ["replyTo1@email.com", "replyTo2@email.com"]
    };
    test:assertEquals(email.subject, "Sample Email");
}
