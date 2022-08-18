import ballerina/io;

type IoError distinct error;

type FileErrorDetail record {
    string filename;
};

// The `FileIoError` type is defined as an intersection type using the `&` notation.
// It is the intersection of two error types: `IoError` and `error<FileErrorDetail>`.
// An error value belongs to this type if and only if it belongs to both `IoError` 
// and `error<FileErrorDetail>`.
type FileIoError IoError & error<FileErrorDetail>;

public function main() {
    // In order to create an error value that belongs to `FileIoError` the `filename`
    // detail field must be provided.
    FileIoError fileIoError = error("file not found", filename = "test.txt");

    // `fileIoError` belongs to both `IoError` and `error<FileErrorDetail>`.
    io:println(fileIoError is IoError);
    io:println(fileIoError is error<FileErrorDetail>);

    // An `IoError` value will not belong to `FileIoError` if it doesn't belong to
    // `error<FileErrorDetail>`.
    IoError ioError = error("invalid input");
    io:println(ioError is FileIoError);

    // Similarly an error value belonging to `error<FileErrorDetail>` will not belong
    // to `FileIoError` if it doesn't also belong to `IoError`.
    error<FileErrorDetail> fileError = error("cannot remove file", filename = "test.txt");
    io:println(fileError is FileIoError);
}
