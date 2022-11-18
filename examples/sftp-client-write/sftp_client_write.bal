import ballerina/ftp;
import ballerina/io;
import ballerina/lang.'string as strings;

public function main() returns error? {
    // Creates the client with the connection parameters, host, username, and
    // password. An error is returned in a failure. The default port number
    // `22` for SSH is used with these configurations.
    ftp:ClientConfiguration config = {
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
    };
    ftp:Client clientEp = check new (config);

    // Add a new file to the given file location. In error cases, 
    // an error is returned. The local file is provided as a stream of
    // `io:Block` in which 1024 is the block size.
    stream<io:Block, io:Error?> bStream
        = check io:fileReadBlocksAsStream("/local/logFile.txt", 1024);
    check clientEp->put("/server", bStream);
}
