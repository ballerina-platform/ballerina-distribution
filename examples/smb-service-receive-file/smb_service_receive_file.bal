import ballerina/io;
import ballerina/smb;

// Creates the listener with the connection parameters, the share to watch, and
// the polling interval in seconds. The listener only picks up the files whose
// names match the given pattern.
listener smb:Listener fileListener = check new ({
    host: "smb.example.com",
    share: "reports",
    auth: {
        credentials: {
            username: "user1",
            password: "pass456",
            domain: "WORKGROUP"
        }
    },
    pollingInterval: 10,
    fileNamePattern: "(.*).txt"
});

// One or many services can listen to the SMB listener. Each service watches the
// directory given in `path`, which is relative to the share.
@smb:ServiceConfig {
    path: "/home/in"
}
service "logCollector" on fileListener {

    // The listener picks the handler by file extension and binds the content to
    // the first parameter, so the handler never reads the file itself.
    // `onFileText` receives `.txt`, `.log`, and `.md` files as a string.
    // The file is moved to `/home/processed` once the handler returns.
    @smb:FunctionConfig {
        afterProcess: {
            moveTo: "/home/processed"
        }
    }
    remote function onFileText(string content, smb:FileInfo fileInfo) returns error? {
        // Writes the received content to a file in the local file system.
        check io:fileWriteString(string `./local/${fileInfo.name}`, content);
    }

    // `onError` is called when a file cannot be read, cannot be bound to the
    // handler parameter, or the handler itself fails.
    remote function onError(error err) returns error? {
        io:println("Failed to process the file: ", err.message());
    }
}
