import ballerina/io;

//Initialize required configurable variables with `?` expression.
//A value must be supplied for these variables in the configuration toml file
configurable string hostName = ?;
configurable int port = ?;

//Initialize optional configurable variables with default values.
//The value provided here will be overridden by the value specified in the configuration toml file.
//The values of variables `enableRemote` and `maxPayload` are overridden.
configurable boolean enableRemote = true;
configurable float maxPayload = 1.0;

//The value `"http"` is used to initialize variable `protocol` as it is not provided in the configuration toml file..
configurable string protocol = "http";

public function main() {
    string serviceMsg = string `Service created successfully with configuration,
    host : ${hostName}
    port : ${port.toString()}
    protocol : ${protocol}
    maximum payload (in MB) : ${maxPayload.toString()}
    remote enabled : ${enableRemote.toString()}`;
    io:println(serviceMsg);
}
