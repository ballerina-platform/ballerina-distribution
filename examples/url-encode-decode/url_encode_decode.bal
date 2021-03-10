import ballerina/url;
import ballerina/io;

public function main() returns error? {
    string value1 = "data=value";
    // Encoding a URL component into a string.
    string encoded = check url:encode(value1, "UTF-8");
    io:println("URL encoded value: ", encoded);

    string value2 = "data%3Dvalue";
    // Decoding an encoded URL component into a string.
    string decoded = check url:decode(value2, "UTF-8");
    io:println("URL decoded value: ", decoded);
}
