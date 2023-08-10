import ballerina/io;

type UserInfo record {|
   readonly string username;
   string password;
|};

type UserTable table<UserInfo> key(username);

enum HttpVersion {
   HTTP_1_0 = "1.0",
   HTTP_1_1 = "1.1",
   HTTP_2_0 = "2.0"
}

// The configurable variables of `float`, `string[]`, enum, `record`, and `table` types are initialized.
configurable float maxPayload = 1.0;
configurable string[] acceptTypes = ["text/plain"];
configurable HttpVersion httpVersion = HTTP_1_0;
configurable UserInfo & readonly admin = ?;
configurable UserTable & readonly users = ?;

public function main() {
   io:println("maximum payload (in MB): ", maxPayload);
   io:println("accepted content types: ", acceptTypes);
   io:println("HTTP version: ", httpVersion);
   io:println("admin details: ", admin);
   io:println("users: ", users);
}
