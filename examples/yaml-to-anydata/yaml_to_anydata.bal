import ballerina/data.yaml;
import ballerina/io;

type ServerConfig record {|
    string host;
    int port;
    string protocol;
|};

final string yamlString = string
        `
        host: "localhost"
        port: 8080
        protocol: "http"`;

public function main() returns error? {
    // Parse the YAML string as a record.
    ServerConfig serverConfig1 = check yaml:parseString(yamlString);
    io:println(serverConfig1);

    byte[] yamlByteArr = yamlString.toBytes();
    // Parse the YAML byte array as a record.
    ServerConfig serverConfig2 = check yaml:parseBytes(yamlByteArr);
    io:println(serverConfig2);

    stream<byte[], error?> byteBlockStream = new (new ByteBlockGenerator(yamlString));
    // Parse the YAML byte block stream as a record.
    ServerConfig serverConfig3 = check yaml:parseStream(byteBlockStream);
    io:println(serverConfig3);
}

// Defines a class called `ByteBlockGenerator`, which is stream implementor with a `next()` method.
// This `next()` method is called when iterating over a stream created with a `ByteBlockGenerator` value.
class ByteBlockGenerator {
    private int index = 0;
    private final byte[] byteArr;
    private final int arraySize;

    public function init(string data) {
        self.byteArr = data.toBytes();
        self.arraySize = self.byteArr.length();
    }

    public isolated function next() returns record {|byte[] value;|}|error? {
        if self.index >= self.arraySize {
            return;
        }
        int startIndex = self.index;
        self.index = startIndex + 4 > self.arraySize ? self.arraySize : startIndex + 3;
        return {value: self.byteArr.slice(startIndex, self.index)};
    }
}
