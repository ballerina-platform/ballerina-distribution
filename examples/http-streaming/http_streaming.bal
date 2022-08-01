import ballerina/http;
import ballerina/io;
import ballerina/mime;

// Creates an endpoint for the [client](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client).
http:Client clientEndpoint = check new ("http://localhost:9090");

service /'stream on new http:Listener(9090) {

    resource function get fileupload() returns string|error {
        http:Request request = new;

        //[Sets the file](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#setFileAsPayload) as the request payload.
        request.setFileAsPayload("./files/BallerinaLang.pdf", contentType = mime:APPLICATION_PDF);

        //Sends the request to the receiver service with the file content.
        string clientResponse = check clientEndpoint->post("/stream/receiver", request);

        // forward the received payload to the caller.
        return clientResponse;
    }

    resource function post receiver(http:Request request) returns string|error {
        //[Retrieve the byte stream](https://docs.central.ballerina.io/ballerina/http/latest/classes/Request#getByteStream).
        stream<byte[], io:Error?> streamer = check request.getByteStream();

        //Writes the incoming stream to a file using the `io:fileWriteBlocksFromStream` API by providing the file location to which the content should be written.
        check io:fileWriteBlocksFromStream("./files/ReceivedFile.pdf", streamer);
        check streamer.close();
        return "File Received!";
    }
}
