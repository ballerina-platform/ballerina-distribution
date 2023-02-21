import ballerina/io;

public function main() returns error? {
    HelloWorldClient securedEP = check new("https://localhost:9090",
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    string result = check securedEP->hello("WSO2");
    io:println(result);
}
