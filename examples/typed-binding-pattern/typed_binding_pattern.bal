import ballerina/io;

public function main() returns error? {

    [string, int] [name, age] = getDetails();
    io:println(name);
    io:println(age);

    // The type of variable `profession` will be inferred from the expression `Software Engineer`.
    var profession = "Software Engineer";
    io:println(profession);

    // In the following capture binding pattern, the value `Hello World` gets 
    // matched to the type `string`, resulting in a successful match and
    // causing the value to be assigned to the variable `greeting`.
    string greeting = "Hello World";
    io:println(greeting);

    // The inferred type of the following capture binding pattern will be `int|error`.
    var response = check int:fromString("404");
    io:println(response);
}

function getDetails() returns [string, int] {
    return ["John", 30];
}
