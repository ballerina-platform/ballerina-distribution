import ballerina/io;

// These options are some of those found in the [`grep` command line 
// utility](https://www.man7.org/linux/man-pages/man1/grep.1.html).
public type GrepOptions record {|
    int 'after\-context = 0;
    int 'before\-context = 0;
    boolean 'ignore\-case;
    boolean 'line\-number;
    boolean recursive;
    string? file;
|};

// The main function accepts a `pattern` to search for the `fileName`
// and the arguments for the linux/unix `grep` command. This program 
// processes the command line arguments and prints their values with an 
// explanation of what they accomplish.
public function main(string pattern, string fileName, 
    *GrepOptions grepOptions) returns error? {
    io:println("The options for 'grep' command is set to the following: ");
    // Handles the `after-context` and `before-context` defaultable options.
    io:println("Print '", grepOptions.'after\-context, "' lines of the", 
    " trailing context after each match");
    io:println("Print '", grepOptions.'before\-context, "' lines of the", 
        " leading context after each match");
    // Handles the boolean options.
    if (grepOptions.'ignore\-case) {
        io:println("Perform case insensitive matching");
    } else {
        io:println("Perform case sensitive matching");
    }

    if (grepOptions.'line\-number) {
        io:println("Precede each output line by its line number");
    }
    if (grepOptions.recursive) {
        io:println("Recursively search subdirectories listed");
    }
    // Handles the optional `file` option.
    if (grepOptions.file is string) {
        io:println("Read one or more newline separated patterns from file '",
             grepOptions.file, "'");
    }
    // Handles the operands.
    io:println();
    io:println("The operands for the 'grep'  command is set to the following: ");
    io:println("The pattern to search for is '", pattern, "'");
    io:println("The file to search in is '", fileName, "'");
}
