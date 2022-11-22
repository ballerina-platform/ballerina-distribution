import ballerina/http;
import ballerina/io;

service / on new http:Listener(9090) {

    resource function post receiver(http:Request request) returns string|error {
        // Retrieve the byte stream.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Request#getByteStream.
        stream<byte[], io:Error?> streamer = check request.getByteStream();

        // Writes the incoming stream to a file using the `io:fileWriteBlocksFromStream` API
        // by providing the file location to which the content should be written.
        check io:fileWriteBlocksFromStream("./files/ReceivedFile.pdf", streamer);
        check streamer.close();
        return "File Received!";
    }
}
