import ballerina/http;

// This code is completely focused on the business logic and it does not depend on the deployment.

listener http:Listener helloEP = new(9090);

service http:Service /helloWorld on helloEP {
    resource function get sayHello() returns string {
        return "Hello from Docker!";
    }
}
