import ballerina/ftp;
import ballerina/io;

public function main() returns error? {
    // Creates the client with the connection parameters, host, username, and
    // password. An error is returned in a failure. The default port number
    // `21` is used with these configurations.
    ftp:Client fileClient = check new ({
        host: "ftp.example.com",
        auth: {
            credentials: {
                username: "user1",
                password: "pass456"
            }
        }
    });

    // Reads the file as a string. In error cases, an error is returned.
    // `getBytes`, `getJson`, `getXml`, and `getCsv` read the other content
    // types, and `getJson`, `getXml`, and `getCsv` bind the content to the type
    // expected at the call site.
    string content = check fileClient->getText("/server/logFile.txt");

    // Write the content to a file.
    check io:fileWriteString("./local/newLogFile.txt", content);
}
