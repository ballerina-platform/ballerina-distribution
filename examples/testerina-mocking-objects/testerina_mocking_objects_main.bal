// This demonstrates different ways to mock a client object.
import ballerina/http;
import ballerina/io;
import ballerina/email;

// Clients objects are defined globally to be able to replace in test files.
http:Client clientEndpoint = new("http://postman-echo.com");
email:SmtpClient smtpClient = new("localhost", "admin", "admin");

// This function performs two `GET` requests to the specified
// endpoint and returns the response.
function performGet() returns @tainted http:Response {
    io:println("Executing the 1st GET request");
    http:Response response = <http:Response> 
    checkpanic clientEndpoint -> get("/headers");
    io:println("Status code: ", response.statusCode.toString());

    if (response.statusCode == 200) {
        io:println("Executing the 2nd GET request");
        http:Request req = new;
        req.addHeader("Sample-Name", "http-client-connector");
        response = <http:Response> checkpanic 
        clientEndpoint -> get("/get?test=123", req);
        io:println("Status code: ", response.statusCode.toString());
    }
    return response;
}

// This function sends out an email to the specified email addresses
// and returns an error if found.
function sendNotification(string[] emailIds) returns error? {
    email:Message msg = {
        'from: "builder@abc.com",
        subject: "Error Alert ...",
        to: emailIds,
        body: ""
    };
    email:Error? response = smtpClient -> sendEmailMessage(msg);
    if (response is error) {
        io:println("error while sending the email: ", response.message());
        return response;
    }
}
