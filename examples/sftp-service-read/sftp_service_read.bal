import ballerina/ftp;
import ballerina/log;

// Creates the listener with the connection parameters and the protocol-related
// configuration. The listener listens to the files
// with the given file name pattern located in the specified path.
listener ftp:Listener remoteServer = check new ({
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
    port: 22,
    path: "/home/in",
    fileNamePattern: "(.*).txt"
});

// One or many services can listen to the SFTP listener for the
// periodically-polled file related events.
service on remoteServer {
    // When a file event is successfully received, the `onFileChange` method is called.
    remote function onFileChange(ftp:WatchEvent event) {
        // `addedFiles` contains the paths of the newly-added files/directories
        // after the last polling was called.
        foreach ftp:FileInfo addedFile in event.addedFiles {
            log:printInfo("Added file path: " + addedFile.path);
        }

        // `deletedFiles` contains the paths of the deleted files/directories
        // after the last polling was called.
        foreach string deletedFile in event.deletedFiles {
            log:printInfo("Deleted file path: " + deletedFile);
        }
    }
}
