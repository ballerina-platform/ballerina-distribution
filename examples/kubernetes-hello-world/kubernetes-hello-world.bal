import ballerina/http;

<<<<<<< HEAD
// This code is completely focused on the business logic and it does not depend on the deployment.

=======
// This code is completely focused on the business logic and it does not specify anything related to the operations.
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae
listener http:Listener helloEP = new(9090);

service http:Service /helloWorld on helloEP {
    resource function get sayHello() returns string {
        return "Hello from Kubernetes!";
    }
}
