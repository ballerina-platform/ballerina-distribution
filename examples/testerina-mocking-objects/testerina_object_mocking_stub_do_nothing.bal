// This is the example for stubbing a member functions.
import ballerina/io;
import ballerina/test;
import ballerina/email;

// This is a global SMTP client
email:SmtpClient smtpClient = new ("localhost", "admin","admin");

// This function sends out email to specified email addresses.
function sendNotification(string[] emailIds) returns error? {

    email:Email msg = {
        'from: "builder@abc.com",
        subject: "Error Alert ...",
        to: emailIds,
        body: ""
    };

    // This invokes the remote function `send()` in the smtp client object.
    email:Error? response = smtpClient->send(msg);

    if (response is error) {
        // returns an error if email sending fails
        io:println("error while sending the email: " + response.message());
        return response;

    }
}

@test:Config {}
function testSendNotification() {
    // This creates a default mock object which subsequently needs to stubbed.
    email:SmtpClient mockSmtpClient =
        <email:SmtpClient>test:mock(email:SmtpClient);

    // This stubs the `send()` method of the `mockSmtpClient` to do nothing.
    test:prepare(mockSmtpClient).when("send").doNothing();

    // This assigns the mock client to the real.
    smtpClient = mockSmtpClient;

    string[] emailIds = ["user1@test.com", "user2@test.com"];

    // This invokes the `sendNotification()` function.
    error? err = sendNotification(emailIds);

    // This verifies that the `send()` function is not executed.
    test:assertEquals(err, ());

}
