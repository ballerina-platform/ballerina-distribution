import ballerina/http;

service / on new http:Listener(9095) {

    resource function get hello() returns string {
        return "Successful";
    }
}
