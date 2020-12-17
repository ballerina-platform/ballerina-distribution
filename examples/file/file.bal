import ballerina/file;
import ballerina/io;

public function main() returns error? {
    // Get the path of the current directory.
    io:println("Current directory: ", file:getCurrentDir());

    // Create a new directory.
    error? createDirResults = file:createDir("foo");
    if (createDirResults is error) {
        io:println(createDirResults.message());
    }

    // Create a new directory with any non-existent parents.
    string dirPath = check file:joinPath("foo", "bar");
    createDirResults = file:createDir(dirPath, file:RECURSIVE);
    if (createDirResults is error) {
        io:println(createDirResults.message());
    }

    // Create a file in the given file path.
    error? createFileResults = file:create("bar.txt");
    if (createFileResults is error) {
        io:println(createFileResults.message());
    }

    // Get metadata information of the file.
    file:MetaData|error fileMetadata = file:getMetaData("bar.txt");
    if (fileMetadata is file:MetaData) {
        io:println("File path: ", fileMetadata.absPath);
        io:println("File size: ", fileMetadata.size.toString());
        io:println("Is directory: ", fileMetadata.dir.toString());
        io:println("Modified at ", fileMetadata.modifiedTime.
            toString());
    }

    // Check whether the file or directory of the provided path exists.
    boolean fileExists = check file:test("bar.txt", file:EXISTS);
    io:println("bar.txt file exists: ", fileExists.toString());

    // Copy the file or directory to the new path.
    string file = check file:joinPath("foo", "bar", "bar.txt");
    error? copyDirResults = file:copy("bar.txt", file, file:REPLACE_EXISTING);
    if (copyDirResults is ()) {
        io:println("bar.txt file is copied to new path ", file);
    }

    // Rename (Move) the file or directory to the new path.
    string newfile = check file:joinPath("foo", "bar1.txt");
    error? renameResults = file:rename("bar.txt", newfile);
    if (renameResults is ()) {
        io:println("bar.txt file is moved to new path ", newfile);
    }

    // Get the list of files in the directory.
    file:MetaData[]|error readDirResults = file:readDir("foo");

    // Remove the file or directory in the specified file path.
    error? removeResults = file:remove(newfile);
    if (removeResults is ()) {
        io:println("Removed file at ", newfile);
    }

    // Remove the directory in the specified file path with all its children.
    removeResults = file:remove("foo", file:RECURSIVE);
    if (removeResults is ()) {
        io:println("Removed 'foo' directory with all the children.");
    }

    // Create a temporary file in the default tmp directory of the OS
    string tmpResult = check file:createTemp();
    io:println("Absolute path of the tmp file: ", tmpResult);

    // Create a temporary file in a specific directory
    string tmp2Result = check file:createTemp(dir = file:getCurrentDir());
    io:println("Absolute path of the tmp file: ", tmp2Result);
}
