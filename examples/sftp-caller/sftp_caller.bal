import ballerina/ftp;
import ballerina/log;

// Creates the listener with the connection parameters and the protocol-related
// configuration.
listener ftp:Listener fileListener = check new ({
    protocol: ftp:SFTP,
    host: "sftp.example.com",
    auth: {
        credentials: {
            username: "user1",
            password: "pass456"
        },
        privateKey: {
            path: "../resource/path/to/private.key",
            password: "keyPass123"
        }
    },
    port: 22
});

// One or many services can listen to the SFTP listener. Each service watches
// the directory given in `path`, and only the files whose names match
// `fileNamePattern`.
@ftp:ServiceConfig {
    path: "/home/in",
    fileNamePattern: "(.*).txt"
}
service "shipmentNoteAcknowledger" on fileListener {

    // Declaring an `ftp:Caller` parameter hands the handler the connection the
    // listener already holds, so it can write to the server while processing a
    // file. The `ftp:Caller` writes with `putText`, `putJson`, `putXml`,
    // `putCsv`, and `putBytes`, and also deletes and renames files.
    remote function onFileText(string note, ftp:FileInfo fileInfo,
            ftp:Caller caller) returns error? {
        // Stamps the note as received by appending to it on the server.
        string receipt = string `${"\n"}Received ${fileInfo.name} (${fileInfo.size} bytes)`;
        check caller->putText(fileInfo.path, receipt, ftp:APPEND);
        log:printInfo("Acknowledged a shipment note", file = fileInfo.name);
    }

    // `onError` is called when a file cannot be read, cannot be bound to the
    // handler parameter, or the handler itself fails.
    remote function onError(error err) returns error? {
        log:printError("Failed to acknowledge the shipment note", err);
    }
}
