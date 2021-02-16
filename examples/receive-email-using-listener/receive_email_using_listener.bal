import ballerina/email;
import ballerina/io;

// Create the listener with the connection parameters and the protocol-related
// configuration. The polling interval specifies the time duration between each poll
// performed by the listener in milliseconds.
listener email:PopListener emailListener = check new ({
    host: "pop.email.com",
    username: "reader@email.com",
    password: "pass456",
    pollingIntervalInMillis: 2000,
    port: 995
});

// One or many services can listen to the email listener for the periodically-polled
// emails.
service "emailObserver" on emailListener {

    // When an email is successfully received, the `onEmailMessage` method is called.
    remote function onEmailMessage(email:Message emailMessage) {
        io:println("POP Listener received an email.");
        io:println("Email Subject: ", emailMessage.subject);
        io:println("Email Body: ", emailMessage?.body);
    }

    // When an error occurs during the email poll operations, the `onError` method is called.
    remote function onError(email:Error emailError) {
        io:println("Error while polling for the emails: "
            + emailError.message());
    }

}
