import ballerina/io;

type UserInfo record {|
    readonly string username;
    string password;
|};

type UserTable table<UserInfo> key(username);

// `configurable` variables can be initialized with the `?` expression.
// A value must be supplied for such variables in a `Config.toml` file.
configurable string hostName = ?;
configurable int port = ?;

// A `configurable` variable can be initialized with an expression that is not `?`.
// The `Config.toml` file does not have to specify a value for such a variable.
// But if specified, the value in the `Config.toml` file overrides the value
// specified as the initializer.
// The values of the `enableRemote` and `maxPayload` variables here are
// overridden by the values specified in the `Config.toml` file.
configurable boolean enableRemote = true;
configurable float maxPayload = 1.0;

// The value `http` is used to initialize the `protocol` variable since a value is not
// provided for it in the `Config.toml` file.
configurable string protocol = "http";

// A `configurable` variable named `admin` of the `UserInfo & readonly` record type is initialized.
configurable UserInfo & readonly admin = ?;
// A `configurable` variable named `users` of the `table<(UserInfo & readonly)> key(username)` table type is initialized.
configurable UserTable & readonly users = ?;

public function main() {
    io:println("host: ", hostName);
    io:println("port: ", port);
    io:println("protocol: ", protocol);
    io:println("maximum payload (in MB): ", maxPayload);
    io:println("remote enabled: ", enableRemote);
    io:println("admin details: ", admin);
    io:println("users: ", users);
}
