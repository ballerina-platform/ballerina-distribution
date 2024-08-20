import ballerina/data.yaml;
import ballerina/io;

type ServerConfig record {|
    string host;
    int port;
    int[2] remotePorts;
    DatabaseConfig database;
|};

type DatabaseConfig record {|
    string dbName;
    string username;
|};

public function main() returns error? {
    // Similar to content read from a YAML file.
    string yamlString = string `
        host: "localhost"
        port: 8080
        remotePorts: [9000, 9001, 9002, 9003]
        protocol: "http"
        database:
          dbName: "testdb"
          username: "dbuser"
          password: "dbpassword"`;

    // Based on the expected type, this function selectively constructs the record type from the YAML string.
    ServerConfig serverConfig = check yaml:parseString(yamlString);
    // The `password` field is excluded in the created record value.
    // Only the first two elements from the source are used to create the `remotePorts` array.
    io:println(serverConfig);
}
