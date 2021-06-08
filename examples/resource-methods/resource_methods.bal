import ballerina/http;

// Service declaration specifies base path for the resource names. The base path is `/` in this example.
service / on new http:Listener(8080) {
    // Resource method is associated with combination of accessor (`get`) and resource name (`hello`). 
    // Accessors are determined by the network protocol.
    // In HTTP resources, function parameters come from query parameters.
    resource function get hello(string name) returns string {
        return "Hello, " + name;
    }

}
