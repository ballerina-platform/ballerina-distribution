import ballerina/email;
import ballerina/io;

// Defines the protocol specific configuration for the email listener. It can
// either be `email:PopConfig` for POP or `email:ImapConfig` for IMAP.
email:PopConfig popConfig = {
     port: 995,
     enableSsl: true
};

// Create the listener with the connection parameters and protocol related 
// configuration. Polling interval specifies the time duration between each poll
// performed by the listener.
listener email:Listener emailListener = new ({
    host: "pop.email.com",
    username: "reader@email.com",
    password: "pass456",
    protocol: "POP",
    protocolConfig: popConfig,
    pollingInterval: 2000
});

// One or many services can listen to the email listener for the periodically
// polled emails.
service emailObserver on emailListener {

    // When an email is successfully received `onMessage` method is called
    resource function onMessage(email:Email emailMessage) {
        io:println("Email Subject: ", emailMessage.subject);
        io:println("Email Body: ", emailMessage.body);
    }

    // When an error occurs during the email poll operations `onError` is called
    resource function onError(email:Error emailError) {
        io:println("Error while polling for the emails: "
            + emailError.message());
    }

}
