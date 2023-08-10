import ballerina/io;

type IOError distinct error;

type FileErrorDetail record {
    string filename;
};

// The `FileIOError` type is defined as an intersection type using the `&` notation.
// It is the intersection of two error types: `IOError` and `error<FileErrorDetail>`.
// An error value belongs to this type if and only if it belongs to both `IOError` 
// and `error<FileErrorDetail>`.
type FileIOError IOError & error<FileErrorDetail>;

public function main() {
    // In order to create an error value that belongs to `FileIOError`, the `filename`
    // detail field must be provided.
    FileIOError fileIOError = error("file not found", filename = "test.txt");

    // `fileIOError` belongs to both `IOError` and `error<FileErrorDetail>`.
    io:println(fileIOError is IOError);
    io:println(fileIOError is error<FileErrorDetail>);

    // An `IOError` value will not belong to `FileIOError` if it doesn't belong to
    // `error<FileErrorDetail>`.
    IOError ioError = error("invalid input");
    io:println(ioError is FileIOError);

    // Similarly, an error value belonging to `error<FileErrorDetail>` will not belong 
    // to `FileIOError` if it doesn't belong to `IOError`.
    error<FileErrorDetail> fileError = error("cannot remove file", filename = "test.txt");
    io:println(fileError is FileIOError);
}
