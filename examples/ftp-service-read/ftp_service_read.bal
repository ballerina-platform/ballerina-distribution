import ballerina/ftp;
import ballerina/io;
import ballerina/log;

// Creates the listener with the connection parameters and the protocol-related
// configuration. The listener listens to the files
// with the given file name pattern located in the specified path.
listener ftp:Listener fileListener = check new ({
    host: "ftp.example.com",
    auth: {
        credentials: {
            username: "user1",
            password: "pass456"
        }
    },
    path: "/home/in",
    fileNamePattern: "(.*).txt"
});

// One or many services can listen to the FTP listener for the periodically-polled
// file related events.
service on fileListener {

    // When a file event is successfully received, the `onFileChange` method is called.
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        // `addedFiles` contains the paths of the newly-added files/directories
        // after the last polling was called.
        foreach ftp:FileInfo addedFile in event.addedFiles {
            // Reads a file from an FTP server for a given file path.
            stream<byte[] & readonly, io:Error?> fileStream = check caller->get(addedFile.path);

            // Write the content to a file.
            check io:fileWriteBlocksFromStream("./local/newLogFile.txt", fileStream);
            check fileStream.close();
        }

        // `deletedFiles` contains the paths of the deleted files/directories
        // after the last polling was called.
        foreach string deletedFile in event.deletedFiles {
            log:printInfo("Deleted file path: " + deletedFile);
        }
    }
}
