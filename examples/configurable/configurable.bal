import ballerina/io;

// Initialize the required `configurable` variables with the `?`.
// A value must be supplied for these variables in a `configuration.toml` file.
configurable string hostName = ?;
configurable int port = ?;

// Initialize the optional `configurable` variables with their default values.
// The value provided here will be overridden by the value specified in a `configuration.toml` file.
// The values of the `enableRemote` and `maxPayload` variables are overridden.
configurable boolean enableRemote = true;
configurable float maxPayload = 1.0;

// The value `http` is used to initialize the `protocol` variable as it is not provided in the
// `configuration.toml` file.
configurable string protocol = "http";

public function main() {
    string serviceMsg = "Service created successfully with the configuration,";
    io:println(serviceMsg);
    io:println("host : " + hostName);
    io:println("port : " + port.toString());
    io:println("protocol : " + protocol);
    io:println("maximum payload (in MB) : " + maxPayLoad.toString());
    io:println("Remote enabled : " + enableRemote.toString());
}
