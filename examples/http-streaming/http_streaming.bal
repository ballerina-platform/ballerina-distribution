import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;

// Creates an endpoint for the [client](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/http/latest/http/clients/Client).
http:Client clientEndpoint = check new ("http://localhost:9090");

service /'stream on new http:Listener(9090) {

    resource function get fileupload(http:Caller caller,
                                         http:Request clientRequest) {
        http:Request request = new;

        //[Sets the file](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Request#setFileAsPayload) as the request payload.
        request.setFileAsPayload("./files/BallerinaLang.pdf",
            contentType = mime:APPLICATION_PDF);

        //Sends the request to the client with the file content.
        var clientResponse = clientEndpoint->post("/stream/receiver", request);

        http:Response res = new;
        if (clientResponse is http:Response) {
            res = clientResponse;
        } else {
            log:printError("Error occurred while sending data to the client ",
                            err = <error>clientResponse);
            setError(res, <error>clientResponse);
        }
        var result = caller->respond(res);
        if (result is error) {
            log:printError("Error while while sending response to the caller",
                            err = result);
        }
    }

    resource function post receiver(http:Caller caller,
                                        http:Request request) {
        http:Response res = new;
        //[Retrieve the byte stream](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Request#getByteStream).
        stream<byte[], io:Error>|error streamer = request.getByteStream();

        if (streamer is stream<byte[], io:Error>) {
            //Writes the incoming stream to a file using `io:fileWriteBlocksFromStream` API by providing the file location to which the content should be written to.
            io:Error? result = io:fileWriteBlocksFromStream(
                                    "./files/ReceivedFile.pdf", streamer);

            if (result is error) {
                log:printError("error occurred while writing ", err = result);
                setError(res, result);
            } else {
                res.setPayload("File Received!");
            }
            close(streamer);
        } else {
            setError(res, streamer);
        }
        var result = caller->respond(res);
        if (result is error) {
           log:printError("Error occurred while sending response",
                           err = result);
        }
    }
}

//Sets the error to the response.
function setError(http:Response res, error err) {
    res.statusCode = 500;
    res.setPayload(<@untainted>err.message());
}

//Closes the byte stream.
function close(stream<byte[], io:Error> byteStream) {
    var cr = byteStream.close();
    if (cr is error) {
        log:printError("Error occurred while closing the stream: ", err = cr);
    }
}
