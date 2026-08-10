import ballerina/smb;

// Creates the listener with the connection parameters, the share to watch, and
// the polling interval in seconds. The listener only picks up the files whose
// names match the given pattern.
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
    pollingInterval: 10,
    fileNamePattern: "(.*).txt"
});

// One or many services can listen to the SMB listener. Each service watches the
// directory given in `path`, which is relative to the share.
@smb:ServiceConfig {
    path: "/home/in"
}
service "logAcknowledger" on fileListener {

    // Declaring an `smb:Caller` parameter hands the handler the same share
    // connection the listener uses, so it can write back to the share while
    // processing a file. The `smb:Caller` writes with `putBytes`, `putText`,
    // `putJson`, `putXml`, and `putCsv`, and also moves, copies, and deletes.
    remote function onFileText(string content, smb:FileInfo fileInfo, smb:Caller caller) returns error? {
        string receipt = string `Received ${fileInfo.name} holding ${content.length()} characters`;

        // Writes an acknowledgement file back to the share.
        check caller->putText(string `/home/out/${fileInfo.name}.received`, receipt);
    }
}
