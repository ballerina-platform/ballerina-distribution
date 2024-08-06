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
        database: {
            dbName: "userDB",
            username: "testUser"
        },
        port: 3000,
        host: "localhost"
    };

    // Serialize a Ballerina value to a string in YAML format.
    string serverConfigYamlStr = check yaml:toYamlString(serverConfig);
    io:println(serverConfigYamlStr);
}
