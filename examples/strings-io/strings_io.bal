import ballerina/io;

public function main() returns @tainted error? {
    // Initialize the text path and the content.
    string textFilePath1 = "./files/textfile1.txt";
    string textFilePath2 = "./files/textfile2.txt";
    string textFilePath3 = "./files/textfile3.txt";
    string textContent = "Ballerina is an open source programming language.";
    string[] lines = ["The Big Bang Theory", "F.R.I.E.N.D.S",
    "Game of Thrones", "LOST"];

    // Write the given string to a file.
    check io:fileWriteString(textFilePath1, textContent);
    // If the write operation was successful, then, read the content as a string.
    string readContent = check io:fileReadString(textFilePath1);
    io:println(readContent);

    // Write the given array of lines to a file.
    check io:fileWriteLines(textFilePath2, lines);
    // If the write operation was successful, then, perform a read operation to read the lines as an array.
    string[] readLines = check io:fileReadLines(textFilePath2);
    io:println(readLines);

    // Write the given stream of lines to a file.
    check io:fileWriteLinesFromStream(textFilePath3, lines.toStream());
    // If the write operation was successful, then, perform a read operation to read the lines as a stream.
    stream<string, io:Error> lineStream = check
                                    io:fileReadLinesAsStream(textFilePath3);
    // Loop through the stream and print the content.
    error? e = lineStream.forEach(function(string val) {
                               io:println(val);
                           });
}
