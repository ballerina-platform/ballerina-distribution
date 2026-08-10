import ballerina/io;
import ballerina/smb;

type DailySummary record {|
    string date;
    int processed;
|};

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

    // Reads the file as a string. An error is returned when the file is missing
    // or cannot be read.
    string summary = check fileClient->getText("/reports/summary.txt");
    io:println(summary);

    // Reads JSON straight into a record. The client binds the content to the
    // type expected at the call site, so no conversion step is needed.
    // `getXml`, `getCsv`, and `getBytes` read the other content types.
    DailySummary daily = check fileClient->getJson("/reports/summary.json");
    io:println(daily.processed);
}
