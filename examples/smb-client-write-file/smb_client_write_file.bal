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

    // Writes a string to the given location on the share. Every path is
    // relative to that share. Passing `smb:APPEND` as the last argument adds to
    // the existing content instead of replacing it.
    check fileClient->putText("/reports/summary.txt", "All systems nominal");

    // Writes a record as JSON. The client serializes the value, so the content
    // does not have to be converted first. `putXml`, `putCsv`, and `putBytes`
    // write the other content types.
    DailySummary summary = {date: "2026-08-10", processed: 42};
    check fileClient->putJson("/reports/summary.json", summary);
}
