import ballerina/file;
import ballerina/io;

public function main() returns error? {

    // Creates a file in the given file path.
    check file:create("bar.txt");
    io:println("The bar.txt file created successfully.");

    // Checks whether the file exists on the provided path.
    boolean fileExists = check file:test("bar.txt", file:EXISTS);
    io:println("Does the bar.txt file exist: ", fileExists.toString());

    // Checks whether the file is readable or not.
    fileExists = check file:test("bar.txt", file:READABLE);
    io:println("Is the bar.txt file readable: ", fileExists.toString());

    // Checks whether the file is writable or not.
    fileExists = check file:test("bar.txt", file:WRITABLE);
    io:println("Is the bar.txt file writeable: ", fileExists.toString());

    // Copies the file or directory to the new path.
    check file:copy("bar.txt",  "bar1.txt", file:REPLACE_EXISTING);
    io:println("The bar.txt file copied successfully.");

    check file:rename("bar.txt", "bar2.txt");
    io:println("The bar.txt file renamed successfully.");

    // Gets the metadata information of the file.
    file:MetaData fileMetadata = check file:getMetaData("bar1.txt");
    io:println("File path: ", fileMetadata.absPath);
    io:println("File size: ", fileMetadata.size.toString());
    io:println("Is directory: ", fileMetadata.dir.toString());
    io:println("Modified at ", fileMetadata.modifiedTime.toString());

    // Removes the file in the specified file path.
    check file:remove("bar1.txt");
    check file:remove("bar2.txt");
    io:println("Files removed successfully.");
}
