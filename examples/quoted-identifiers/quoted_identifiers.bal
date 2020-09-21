import ballerina/io;

// Use the reserved keyword `function` as the name of the function.
function 'function(int val) returns int {
    return val + 1;
}

public function main() {

    // Use the reserved keyword `int` as the name of the variable.
    int 'int = 1;

    // Invoke the function named `function` with the variable named `int`.
    // The quoted identifier syntax is used to refer to both the function and
    // the variable.
    int i = 'function('int);
    io:println(i);

    // Define a variable where the variable name starts with a digit.
    int '1PlusI = 1 + i;
    io:println('1PlusI);

    // Define a variable where the variable name contains special characters with a preceding `\`.
    int '\{add\#5\} = 5 + i;
    io:println('\{add\#5\});

    // Define a variable where the variable name contains unicode characters.
    string 'üňĩćőđę_ňāɱȇ = "John doe";
    io:println('üňĩćőđę_ňāɱȇ);

    // Define a variable where the variable name contains unicode character specified by hexadecimal code points.
    string 'unicode_\u{2324} = "Jane doe";
    io:println('unicode_\u{2324});

}
