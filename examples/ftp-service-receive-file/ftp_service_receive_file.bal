import ballerina/ftp;
import ballerina/io;

// Creates the listener with the connection parameters and the protocol-related
// configuration.
listener ftp:Listener fileListener = check new ({
    host: "ftp.example.com",
    auth: {
        credentials: {
            username: "user1",
            password: "pass456"
        }
    }
});

// One or many services can listen to the FTP listener. Each service watches the
// directory given in `path`, and only the files whose names match
// `fileNamePattern`.
@ftp:ServiceConfig {
    path: "/home/in",
    fileNamePattern: "(.*).txt"
}
service "shipmentNoteArchiver" on fileListener {

    // The listener selects the handler by file extension and binds the file
    // content to the first parameter, so the handler never reads the file
    // itself. `onFileText` receives the file as a string, while `onFileJson`,
    // `onFileXml`, and `onFileCsv` bind the other content types, and `onFile`
    // handles any remaining extension.
    // The file is moved once the handler returns, so the handler is left with
    // no file management to do. `afterProcess` and `afterError` also accept
    // `ftp:DELETE` to remove the file instead of moving it.
    @ftp:FunctionConfig {
        afterProcess: {
            moveTo: "/home/processed"
        },
        afterError: {
            moveTo: "/home/failed"
        }
    }
    remote function onFileText(string note, ftp:FileInfo fileInfo) returns error? {
        // Archives the note on the local file system.
        check io:fileWriteString(string `./archive/${fileInfo.name}`, note);
        io:println(string `Archived ${fileInfo.name} (${fileInfo.size} bytes)`);
    }

    // `onError` is called when a file cannot be read, cannot be bound to the
    // handler parameter, or the handler itself fails.
    remote function onError(error err) returns error? {
        io:println("Failed to archive the shipment note: ", err.message());
    }
}
