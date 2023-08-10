import ballerina/http;
import ballerina/io;
import ballerina/mime;

public function main() returns error? {
    http:Client httpClient = check new ("localhost:9090");

    http:Request request = new;

    // Sets the file as the request payload.
    request.setFileAsPayload("./files/BallerinaLang.pdf", contentType = mime:APPLICATION_PDF);

    //Sends the request to the receiver service with the file content.
    string content = check httpClient->/receiver.post(request);

    // forward the received payload to the caller.
    io:println(content);
}
