import ballerina/email;
import ballerina/log;

listener email:ImapListener emailListener = new ({
    host: "imap.email.com",
    username: "reader@email.com",
    password: "pass456",
    secureSocket: {
        cert: "../resource/path/to/public.crt"
    }
});

service "observer" on emailListener {

    remote function onMessage(email:Message email) {
        log:printInfo("Received an email", subject = email.subject, content = email?.body);
    }

    remote function onError(email:Error emailError) {
        log:printError(emailError.message(), stackTrace = emailError.stackTrace());
    }

    remote function onClose(email:Error? closeError) {
        if closeError is email:Error {
            log:printInfo(closeError.message(), stackTrace = closeError.stackTrace());
        }
    }
}
