import ballerina/log;
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

// One or many services can listen to the SMB listener. Each service watches the
// directory given in `path`, which is relative to the share.
@smb:ServiceConfig {
    path: "/sales/new"
}
service "salesProcessor" on fileListener {

    // The listener picks the handler by file extension and binds the file
    // content to the first parameter, so the handler never reads the file
    // itself. `onFileJson` handles every `.json` file, and the content is bound
    // to `SalesReport`. The other handlers are `onFileText`, `onFileXml`,
    // `onFileCsv`, and `onFile` for any remaining extension.
    // The file is moved to `/sales/processed` once the handler returns.
    @smb:FunctionConfig {
        afterProcess: {
            moveTo: "/sales/processed"
        }
    }
    remote function onFileJson(SalesReport report, smb:FileInfo fileInfo) returns error? {
        log:printInfo("Processed a sales report", file = fileInfo.name,
                storeId = report.storeId, total = report.total);
    }

    // `onError` is called when a file cannot be read, cannot be bound to the
    // handler parameter, or the handler itself fails.
    remote function onError(error err) returns error? {
        log:printError("Failed to process the file", err);
    }
}
