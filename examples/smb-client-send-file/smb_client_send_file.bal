import ballerina/io;
import ballerina/smb;

public function main() returns error? {
    // Creates the client with the connection parameters: the host, the share to
    // work on, and the required credentials. An error is returned in a failure.
    // The default port number `445` is used with these configurations.
    smb:Client fileClient = check new ({
        host: "smb.example.com",
        share: "reports",
        auth: {
            credentials: {
                username: "user1",
                password: "pass456",
                domain: "WORKGROUP"
            }
        }
    });

    // Reads the local file that is sent to the share.
    byte[] content = check io:fileReadBytes("./local/logFile.txt");

    // Writes the content to the given location, replacing the file when it
    // already exists. Every path is relative to the configured share. Pass
    // `smb:APPEND` as the last argument to add to the existing content instead.
    check fileClient->putBytes("/server/logFile.txt", content);
}
