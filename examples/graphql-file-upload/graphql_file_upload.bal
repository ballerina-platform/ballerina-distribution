import ballerina/graphql;
import ballerina/io;

service /fileUpload on new graphql:Listener(4000) {

    // Remote functions can use the `graphql:Upload` type as an input
    // parameter type.
    remote function singleFileUpload(graphql:Upload file)
        returns string|error {

        // Access the `file name` from `graphql:Upload` type parameter.
        // Similarly, it can access the mime type as `file.mimeType`
        // and encoding as `file.encoding`. Except the `byteStream` field, all
        // other fields in the `graphql:Upload` are `string` values.
        string fileName = file.fileName;
        string path = string`./uploads/${fileName}`;

        // Access the `byte stream` of the file from `graphql:Upload` type
        // parameter. `byteStream` field includes `stream<byte[], io:Error?>`
        // type value.
        stream<byte[], io:Error?> byteStream = file.byteStream;

        // Store the received file using ballerina `io` package. If any `error`
        // occurred during the file write, It can be returned as the resolver
        // function output.
        check io:fileWriteBlocksFromStream(path, byteStream);

        // Return the message if uploading process is successful.
        return "Successfully Uploaded";
    }

    string[] uploadedFiles = [];

    // Remote functions in GraphQL services can use the `graphql:Upload[]` as
    // an input parameter type. Therefore remote functions can accept an array
    // of `graphql:Upload` values. This can be used to store multiple files via
    // single request.
    remote function multipleFileUpload(graphql:Upload[] files)
        returns string[]|error {

        // Iterate the `graphql:Upload` type array to store the files.
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
