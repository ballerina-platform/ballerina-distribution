import ballerina/email;
import ballerina/log;

// Creates the listener with the connection parameters and the protocol-related configuration. 
listener email:ImapListener emailListener = new ({
    host: "imap.email.com",
    username: "reader@email.com",
    password: "pass456"
});

// One or many services can listen to the email listener for the periodically-polled emails.
service "observer" on emailListener {

    // When an email is successfully received, the `onMessage` method is called.
    remote function onMessage(email:Message email) {
        log:printInfo("Received an email", subject = email.subject, content = email?.body);
    }

    // When an error occurs during the email poll operations, the `onError` method is called.
    remote function onError(email:Error emailError) {
        log:printError(emailError.message(), stackTrace = emailError.stackTrace());
    }

    // When the listener is closed, the `onClose` method is called.
    remote function onClose(email:Error? closeError) {
        if closeError is email:Error {
            log:printInfo(closeError.message(), stackTrace = closeError.stackTrace());
        }
    }
}
