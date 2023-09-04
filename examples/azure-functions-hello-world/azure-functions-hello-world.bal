import ballerinax/azure.functions;

// This function gets triggered by an HTTP call with the name query parameter and 
// returns a processed HTTP output to the caller.
service / on new functions:HttpListener() {
    resource function get hello(string name) returns string {
        return string `Hello,  ${name}!`;
    }
}
