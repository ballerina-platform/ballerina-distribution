import ballerina/java;

// Interop functions
public function getString() returns handle = @java:Method {
    'class:"org.wso2.test.StaticMethods"
} external;

public function main() {
}
