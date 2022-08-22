import ballerina/jballerina.java;

public function open(string path) returns handle|error = external;

// This function invoke register function that accept one string parameter and
// located inside the com.project.register.Register Java class
public isolated function register(string name) returns error? = @java:Method {
    'class: "com.project.register.Register"
} external;
