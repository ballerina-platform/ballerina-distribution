import ballerina/http;

service / on new http:Listener(9095) {

    resource function get accesslog() returns string {
        return "Successful";
    }
}
