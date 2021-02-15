import ballerina/io;

public function main() returns @tainted error? {
    // Initialize the image paths.
    string imagePath = "./files/ballerina.jpg";
    string imageCopyPath1 = "./files/ballerinaCopy1.jpg";
    string imageCopyPath2 = "./files/ballerinaCopy2.jpg";

    // Read the file content as a byte array using the given file path.
    byte[] bytes = check io:fileReadBytes(imagePath);
    // Write the already-read content to the given destination file.
    check io:fileWriteBytes(imageCopyPath1, bytes);
    io:println("Successfully copied the image as a byte array.");

    // Read the file as a stream of blocks. The default block size is 4KB.
    // Here, the default size is overridden by the value 2KB.
    stream<io:Block, io:Error> blockStream = check
    io:fileReadBlocksAsStream(imagePath, 2048);
    // If the file reading was successful, then,
    // the content will be written to the given destination file using the given stream.
    check io:fileWriteBlocksFromStream(imageCopyPath2, blockStream);
    io:println("Successfully copied the image as a stream.");
}
