import ballerina/ftp;
import ballerina/io;

public function main() returns error? {
    // Creates the client with the connection parameters, host, username, and
    // password. An error is returned in a failure. The default port number
    // `21` is used with these configurations.
    ftp:Client fileClient = check new ({
        protocol: ftp:FTP,
        host: "ftp.example.com",
        auth: {credentials: {username: "user1", password: "pass456"}}
    });

    // Reads a file from an FTP server for a given file path. In error cases,
    // an error is returned.
    stream<byte[] & readonly, io:Error?> fileStream = check fileClient->get("/server/logFile.txt");

    // Write the content to a file.
    check io:fileWriteBlocksFromStream("./local/newLogFile.txt", fileStream);

    // Closes the file stream to finish the `get` operation.
    check fileStream.close();
}
