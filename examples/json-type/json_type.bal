import ballerina/io;
import ballerina/lang.value;

json j = {"x": 1, "y": 2};

// Returns the `string` that represents `j` in JSON format.
string s = j.toJsonString();

// Parses a `string` in the JSON format and returns the value that it represents.
json j2 = check value:fromJsonString(s);

// Allows `null` for JSON compatibility.
json j3 = null;

public function main() {
    io:println(s);
    io:println(j2);
}
