import ballerina/ftp;
import ballerina/io;

public function main() returns error? {
    // Creates the client with the connection parameters, host, username, and
    // password. An error is returned in a failure. The default port number
    // `22` for SSH is used with these configurations.
    ftp:Client fileClient = check new ({
        protocol: ftp:SFTP,
        host: "sftp.example.com",
        port: 22,
        auth: {
            credentials: {
                username: "user1",
                password: "pass456"
            },
            // Private key file location and its password (if encrypted) is
            // given corresponding to the SSH key file used in the SFTP client.
            privateKey: {
                path: "../resource/path/to/private.key",
                password: "keyPass123"
            }
        }
    });

    // Reads the local file that is sent to the server.
    string content = check io:fileReadString("./local/logFile.txt");

    // Writes the content to the given file location. In error cases, an error
    // is returned. `putBytes`, `putJson`, `putXml`, and `putCsv` write the
    // other content types, and each takes an `ftp:APPEND` option.
    check fileClient->putText("/server/logFile.txt", content);
}
