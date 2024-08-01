import ballerina/data.yaml;
import ballerina/io;

type ServerConfig record {|
    string host;
    int port;
    DatabaseConfig database;
|};

type DatabaseConfig record {|
    string dbName;
    string username;
|};

public function main() returns error? {

    ServerConfig serverConfig = {
        database: {dbName: "userDB", username: "testUser"},
        port: 3000,
        host: "localhost"
    };

    // Serialize a ballerina value to a YAML value.
    string serverConfigYamlStr = check yaml:toYamlString(serverConfig);
    io:println(serverConfigYamlStr);
}
