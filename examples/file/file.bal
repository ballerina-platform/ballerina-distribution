import ballerina/file;
import ballerina/io;

public function main() returns error? {
    // Gets the path of the current directory.
    io:println("Current directory: ", file:getCurrentDir());

    // Creates a new directory.
    check file:createDir("foo");

    // Creates a new directory with any non-existent parents.
    string dirPath = check file:joinPath("foo", "bar");
    check file:createDir(dirPath, file:RECURSIVE);

    // Creates a file in the given file path.
    check file:create("bar.txt");

    // Gets metadata information of the file.
    file:MetaData fileMetadata = check file:getMetaData("bar.txt");
    if (fileMetadata is file:MetaData) {
        io:println("File path: ", fileMetadata.absPath);
        io:println("File size: ", fileMetadata.size.toString());
        io:println("Is directory: ", fileMetadata.dir.toString());
        io:println("Modified at ", fileMetadata.modifiedTime.
            toString());
    }

    // Checks whether the file or directory of the provided path exists.
    boolean fileExists = check file:test("bar.txt", file:EXISTS);
    io:println("bar.txt file exists: ", fileExists.toString());

    // Copies the file or directory to the new path.
    string file = check file:joinPath("foo", "bar", "bar.txt");
    check file:copy("bar.txt", file, file:REPLACE_EXISTING);

    // Renames (Moves) the file or directory to the new path.
    string newfile = check file:joinPath("foo", "bar1.txt");
    check file:rename("bar.txt", newfile);

    // Gets the list of files in the directory.
    file:MetaData[] readDirResults = check file:readDir("foo");

    // Removes the file or directory in the specified file path.
    check file:remove(newfile);

    // Removes the directory in the specified file path with all its children.
    check file:remove("foo", file:RECURSIVE);

    // Creates a temporary file in the default `tmp` directory of the OS.
    string tmpResult = check file:createTemp();
    io:println("Absolute path of the tmp file: ", tmpResult);

    // Creates a temporary file in a specific directory.
    string tmp2Result = check file:createTemp(dir = file:getCurrentDir());
    io:println("Absolute path of the tmp file: ", tmp2Result);
}
