import ballerina/email;
import ballerina/log;

// Creates the listener with the connection parameters and the protocol-related configuration. 
// The `pollingInterval` specifies the duration between each poll in seconds.
listener email:PopListener emailListener = check new ({
    host: "pop.email.com",
    username: "reader@email.com",
    password: "pass456",
    pollingInterval: 2,
    port: 995
});

// One or many services can listen to the email listener for the periodically-polled emails.
service "emailObserver" on emailListener {

    // When an email is successfully received, the `onMessage` method is called.
    remote function onMessage(email:Message emailMessage) {
        log:printInfo("POP Listener received an email", subject = emailMessage.subject,
            content = emailMessage?.body);
    }

    // When an error occurs during the email poll operations, the `onError` method is called.
    remote function onError(email:Error emailError) {
        log:printError("Error while polling for the emails", 'error = emailError);
    }

    // When the listener is closed, the `onClose` method is called.
    remote function onClose(email:Error? closeError) {
        log:printInfo("Closed the listener");
    }
}
