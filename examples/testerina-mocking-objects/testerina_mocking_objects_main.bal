import ballerina/http;
import ballerina/io;
import ballerina/email;

// Sample client that you can use for member access.
public client class ExampleClient {
    public string id;

    public function init(string id) {
        self.id = id;
    }
}

// Client objects are defined globally to be able to replace in the test files.
http:Client clientEndpoint = check new("http://postman-echo.com");
email:SmtpClient smtpClient = check new("localhost", "admin", "admin");
ExampleClient exampleClient = new("originalId");

// Performs two `GET` requests to the specified
// endpoint and returns the response.
function performGet() returns @tainted http:Response {
    io:println("Executing the 1st GET request");
    http:Response response = <http:Response> 
    checkpanic clientEndpoint -> get("/headers");
    io:println("Status code: ", response.statusCode.toString());

    if (response.statusCode == 200) {
        io:println("Executing the 2nd GET request");
        response = <http:Response> checkpanic
        clientEndpoint -> get("/get?test=123",
            {"Sample-Name": "http-client-connector"});
        io:println("Status code: ", response.statusCode.toString());
    }
    return response;
}

// Sends an email to the specified email addresses
// and returns an error if found.
function sendNotification(string[] emailIds) returns error? {
    email:Message msg = {
        'from: "builder@abc.com",
        subject: "Error Alert ...",
        to: emailIds,
        body: ""
    };
    return smtpClient -> sendMessage(msg);
}
