import ballerina/graphql;
import ballerina/io;

service /fileUpload on new graphql:Listener(9090) {

    // Remote methods can use the `graphql:Upload` type as an input parameter type.
    remote function fileUpload(graphql:Upload file) returns string|error {

        // The uploaded file information can be accessed using the `graphql:Upload` type.
        string fileName = file.fileName;
        string path = string `./uploads/${fileName}`;

        // Access the byte stream of the file from the `graphql:Upload` type. The type of the
        // `byteStream` field is `stream<byte[], io:Error?>`.
        stream<byte[], io:Error?> byteStream = file.byteStream;

        // Store the received file using the ballerina `io` package. If any `error` occurred during
        // the file write, it can be returned as the resolver function output.
        check io:fileWriteBlocksFromStream(path, byteStream);

        // Returns the message if the uploading process is successful.
        return string `File ${fileName} successfully uploaded`;
    }

    resource function get getUploadedFileNames() returns string[] {
        return ["image1.png", "image2.png"];
    }
}
