import ballerinax/azure_functions as af;

// This function gets triggered by an HTTP call with the name query parameter and 
// returns a processed HTTP output to the caller.
service / on new af:HttpListener() {
    resource function get hello(string name) returns string {
        return "Hello, " + name + "!";
    }
}
