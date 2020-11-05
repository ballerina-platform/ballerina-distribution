import ballerina/email;
import ballerina/http;
import ballerina/io;

// main bal

http:Client clientEndpoint = new ("http://postman-echo.com");
email:SmtpClient smtpClient = new ("localhost", "admin", "admin");

function doGet() returns @tainted http:Response {
    http:Request req = new;
    req.addHeader("Sample-Name", "http-client-connector");

    var result = clientEndpoint->get("/get?test=123", req);
    http:Response response = <http:Response>result;
    io:println(response.statusCode);
    return response;
}

function doGetBasic() returns @tainted http:Response {

    var result = clientEndpoint->get("/get?test=1234");
    http:Response response = <http:Response>result;
    io:println(response.statusCode);
    return response;
}

function doGetRepeat() returns @tainted http:Response {
    var result = clientEndpoint->get("/healthz");
    http:Response response = <http:Response>result;
    if (response.statusCode == 200) {
        result = clientEndpoint->get("/get?test=1234");
        response = <http:Response>result;
        io:println(response.statusCode);
    }
    return response;
}


function sendNotification(string[] emailIds) returns error? {
    email:Email msg = {
        'from: "builder@abc.com",
        subject: "Error Alert ...",
        to: emailIds,
        body: ""
    };
    email:Error? response = smtpClient->send(msg);

    if (response is error) {
        string errMsg = <string>response.detail()["message"];
        io:println("error while sending the email: " + errMsg);
        return response;
    }
}

function getClientUrl() returns string {
    return clientEndpoint.url;
}
