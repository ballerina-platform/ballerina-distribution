
import ballerina/io;

public function main() {
    string name;
    int age;

    // The following example uses a list binding pattern to destructure the  
    // returned list and assign it to the two variables, `name` and `age`.
    // However, other binding patterns can also be used similarly.
    [name, age] = getDetails();

    io:println(name);
    io:println(age);
}

function getDetails() returns [string, int] {
    return ["John", 30];
}
