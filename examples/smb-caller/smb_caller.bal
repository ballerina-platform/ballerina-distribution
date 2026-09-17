import ballerina/io;
import ballerina/smb;

// Creates the listener with the connection parameters, the share to watch, and
// the polling interval in seconds.
listener smb:Listener fileListener = check new ({
    host: "smb.example.com",
    share: "reports",
    auth: {
        credentials: {
            username: "user1",
            password: "pass456",
            domain: "WORKGROUP"
        }
    },
    pollingInterval: 10
});

// The type the JSON content of each file is bound to.
type SalesReport record {|
    string storeId;
    string saleDate;
    decimal total;
|};

@smb:ServiceConfig {
    path: "/sales/new"
}
service "salesAcknowledger" on fileListener {

    // Declaring an `smb:Caller` parameter hands the handler the share
    // connection the listener already holds, so it can act on the share while
    // processing a file without opening a second connection. The `smb:Caller`
    // writes with `putText`, `putJson`, `putXml`, `putCsv`, and `putBytes`,
    // reads with the matching `get` methods, and also moves, copies, and
    // deletes files.
    remote function onFileJson(SalesReport report, smb:FileInfo fileInfo, smb:Caller caller) returns error? {
        string receipt = string `Store ${report.storeId} reported ${report.total} on ${report.saleDate}`;

        // Writes an acknowledgement back to the share.
        check caller->putText(string `/sales/ack/${fileInfo.name}.txt`, receipt);
        io:println(string `Acknowledged ${fileInfo.name}`);
    }

    // `onError` is called when a file cannot be read, cannot be bound to the
    // handler parameter, or the handler itself fails.
    remote function onError(error err) returns error? {
        io:println("Failed to acknowledge the sales report: ", err.message());
    }
}
