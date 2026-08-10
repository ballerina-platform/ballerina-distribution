import ballerina/ftp;
import ballerina/io;

// Creates the listener with the connection parameters and the protocol-related
// configuration.
listener ftp:Listener fileListener = new ({
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
service on fileListener {

    // Declaring an `ftp:Caller` parameter hands the handler the connection the
    // listener already holds, so it can write to the server while processing a
    // file. The `ftp:Caller` writes with `putText`, `putJson`, `putXml`,
    // `putCsv`, and `putBytes`, and also deletes and renames files.
    remote function onFileText(string content, ftp:FileInfo fileInfo, ftp:Caller caller) returns error? {
        // Appends the content of a local file to the file that arrived.
        string footer = check io:fileReadString("./local/appendFile.txt");
        check caller->putText(fileInfo.path, footer, ftp:APPEND);
    }
}
