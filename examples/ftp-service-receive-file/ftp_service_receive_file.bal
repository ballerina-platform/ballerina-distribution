import ballerina/ftp;
import ballerina/io;

// Creates the listener with the connection parameters and the protocol-related
// configuration.
listener ftp:Listener fileListener = new ({
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
service on fileListener {

    // The listener selects the handler by file extension and binds the file
    // content to the first parameter, so the handler never reads the file
    // itself. `onFileText` receives the file as a string, while `onFileJson`,
    // `onFileXml`, and `onFileCsv` bind the other content types, and `onFile`
    // handles any remaining extension.
    remote function onFileText(string content, ftp:FileInfo fileInfo) returns error? {
        // Write the content to a file.
        check io:fileWriteString(string `./local/${fileInfo.name}`, content);
    }
}
