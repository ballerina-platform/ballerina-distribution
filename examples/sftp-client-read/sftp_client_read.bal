import ballerina/ftp;
import ballerina/io;

public function main() returns error? {
    // Creates the client with the connection parameters, host, username, and
    // password. An error is returned in a failure. The default port number
    // `22` for SSH is used with these configurations.
    ftp:Client clientEp = check new ({
        protocol: ftp:SFTP,
        host: "sftp.example.com",
        port: 22,
        auth: {
            credentials: {username: "user1", password: "pass456"},
            // Private key file location and its password (if encrypted) is
            // given corresponding to the SSH key file used in the SFTP client.
            privateKey: {
                path: "../resource/path/to/private.key",
                password: "keyPass123"
            }
        }
    });

    // Reads a file from a FTP server for a given file path. In error cases,
    // an error is returned.
    stream<byte[] & readonly, io:Error?> fileStream = check clientEp->get("/server/book.txt");

    // Write the content to a file.
    check io:fileWriteBlocksFromStream("./local/book.txt", fileStream);

    // Closes the file stream to finish the `get` operation.
    check fileStream.close();
}
