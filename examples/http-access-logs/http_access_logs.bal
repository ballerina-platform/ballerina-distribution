import ballerina/http;

service /hello on new http:Listener(9095) {

    resource function get .() returns string {
        // Respond with the message "Successful" for each request.
        return "Successful";
    }
}
