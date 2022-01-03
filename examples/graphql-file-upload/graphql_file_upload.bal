import ballerina/graphql;
import ballerina/io;

service /fileUpload on new graphql:Listener(4000) {

    // Store the file information that need to be shared between the remote and
    // resource functions.
    string[] uploadedFiles = [];

    // Remote functions can use the `graphql:Upload` type as an input
    // parameter type.
    remote function singleFileUpload(graphql:Upload file)
        returns string|error {

        // Access the file name from the `graphql:Upload` type parameter.
        // Similarly, it can access the mime type as `file.mimeType`
        // and encoding as `file.encoding`. Except the `byteStream` field, all
        // other fields in the `graphql:Upload` are `string` values.
        string fileName = file.fileName;
        string path = string`./uploads/${fileName}`;

        // Access the byte stream of the file from the `graphql:Upload` type
        // parameter. The type of the `byteStream` field is
        // `stream<byte[], io:Error?>`
        stream<byte[], io:Error?> byteStream = file.byteStream;

        // Store the received file using the ballerina `io` package. If any
        // `error` occurred during the file write, it can be returned as the
        // resolver function output.
        check io:fileWriteBlocksFromStream(path, byteStream);

        // Returns the message if the uploading process is successful.
        return "Successfully Uploaded";
    }

    // Remote functions in GraphQL services can use the `graphql:Upload[]` as
    // an input parameter type. Therefore, remote functions can accept an array
    // of `graphql:Upload` values. This can be used to store multiple files via
    // a single request.
    remote function multipleFileUpload(graphql:Upload[] files)
        returns string[]|error {

        // Iterates the `graphql:Upload` type array to store the files.
        foreach int i in 0..< files.length() {
            graphql:Upload file = files[i];
            stream<byte[], io:Error?> byteStream = file.byteStream;
            string fileName = file.fileName;
            string path = string`./uploads/${fileName}`;
            check io:fileWriteBlocksFromStream(path, byteStream);
            self.uploadedFiles.push(file.fileName);
        }
        return self.uploadedFiles;
    }

    resource function get getUploadedFileNames() returns string[] {
        return self.uploadedFiles;
    }
}
