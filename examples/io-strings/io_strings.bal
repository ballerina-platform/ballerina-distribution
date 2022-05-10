import ballerina/io;

public function main() returns error? {
    // Initializes the text path and the content.
    string textFilePath1 = "./files/textfile1.txt";
    string textFilePath2 = "./files/textfile2.txt";
    string textFilePath3 = "./files/textfile3.txt";
    string textContent = "Ballerina is an open source programming language.";
    string[] lines = ["The Big Bang Theory", "F.R.I.E.N.D.S",
    "Game of Thrones", "LOST"];

    // Writes the given string to a file.
    check io:fileWriteString(textFilePath1, textContent);
    // If the write operation was successful, then, reads the content as a string.
    string readContent = check io:fileReadString(textFilePath1);
    io:println(readContent);

    // Writes the given array of lines to a file.
    check io:fileWriteLines(textFilePath2, lines);
    // If the write operation was successful, then, performs a read operation to read the lines as an array.
    string[] readLines = check io:fileReadLines(textFilePath2);
    io:println(readLines);

    // Writes the given stream of lines to a file.
    check io:fileWriteLinesFromStream(textFilePath3, lines.toStream());
    // If the write operation was successful, then, performs a read operation to read the lines as a stream.
    stream<string, io:Error?> lineStream = check
                                    io:fileReadLinesAsStream(textFilePath3);
    // Iterates through the stream and prints the content.
    check lineStream.forEach(function(string val) {
                               io:println(val);
                           });
}
