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

    // Reads a file from the share for a given path. An error is returned when
    // the file is missing or cannot be read. Use `getText`, `getJson`,
    // `getXml`, or `getCsv` to read the content as a value instead of bytes.
    byte[] content = check fileClient->getBytes("/server/logFile.txt");

    // Writes the content to a local file.
    check io:fileWriteBytes("./local/newLogFile.txt", content);
}
