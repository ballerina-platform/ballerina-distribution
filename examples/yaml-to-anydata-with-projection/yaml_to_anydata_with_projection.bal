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
    // Can read from a file as well.
    string yamlString =
        "host: \"localhost\"\n" +
        "port: 8080\n" +
        "remotePorts: [9000, 9001, 9002, 9003]\n" +
        "protocol: \"http\"\n" +
        "database:\n" +
        "  dbName: \"testdb\"\n" +
        "  username: \"dbuser\"\n" +
        "  password: \"dbpassword\"\n";

    // Based on the expected type, it selectively converts the YAML string to the record type.
    ServerConfig serverConfig = check yaml:parseString(yamlString);
    io:println(serverConfig);
}
