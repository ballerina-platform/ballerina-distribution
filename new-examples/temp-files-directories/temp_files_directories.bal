import ballerina/file;
import ballerina/io;

public function main() returns error? {

    // Creates a temporary directory in the default `tmp` directory of the OS.
    string tmpDir = check file:createTempDir();
    io:println("Absolute path of the tmp directory: ", tmpDir);

    // Creates a temporary file in the default `tmp` directory of the OS.
    string tmpResult = check file:createTemp();
    io:println("Absolute path of the tmp file: ", tmpResult);

    // Creates a temporary file in a specific directory.
    string tmp2Result = check file:createTemp(dir = tmpDir);
    io:println("Absolute path of the tmp file: ", tmp2Result);
}
