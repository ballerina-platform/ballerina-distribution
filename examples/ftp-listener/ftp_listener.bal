import ballerina/ftp;
import ballerina/io;

// Creates the listener with the connection parameters and the protocol-related
// configuration. The polling interval specifies the time duration between each
// poll performed by the listener in seconds. The listener listens to the files
// with the given file name pattern located in the specified path.
listener ftp:Listener remoteServer = check new({
    protocol: ftp:FTP,
    host: "ftp.example.com",
    auth: {
        credentials: {
            username: "user1",
            password: "pass456"
        }
    },
    port: 21,
    path: "/home/in",
    pollingInterval: 2,
    fileNamePattern: "(.*).txt"
});

// One or many services can listen to the FTP listener for the
// periodically-polled file related events.
service on remoteServer {

    // When a file event is successfully received, the `onFileChange` method is
    // called.
    remote function onFileChange(ftp:WatchEvent event) {

        // `addedFiles` contains the paths of the newly-added files/directories
        // after the last polling was called.
        foreach ftp:FileInfo addedFile in event.addedFiles {
            io:println("Added file path: " + addedFile.path);
        }

        // `deletedFiles` contains the paths of the deleted files/directories
        // after the last polling was called.
        foreach string deletedFile in event.deletedFiles {
            io:println("Deleted file path: " + deletedFile);
        }
    }
}
