import ballerinax/azure.functions;

// This function gets triggered by an HTTP call with the name query parameter and 
// returns a processed HTTP output to the caller.
service / on new functions:HttpListener() {
    resource function get hello(string name) returns string {
<<<<<<< HEAD
        return string `Hello,  ${name}!`;
=======
        return "Hello, " + name + "!";
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae
    }
}
