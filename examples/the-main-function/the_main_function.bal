import ballerina/io;

// The student record to be used as a *record for main function 
// options arguments.
public type Student record {|
    // The first parameter `name` is a required parameter.
    string name;
    // The second parameter `age` is a defaultable parameter.
    int age = 18;
    // The third parameter `year` is also a defaultable parameter.
    string year =  "Freshman";
    // The array parameter `modules` represents the additional arguments.
    string[] modules;
|};
// The `main` function that accepts student information as options and prints 
// out a formatted string. The *record represents the command line options. 
// The options can be specified in any order.
// The `main` function may return an `error` or `()`.
public function main(*Student student) returns error? {

    // Return an error if the name is invalid.
    if (student.name.length() < 5) {
        error e = error("InvalidName", message = "invalid length");
        return e;
    }

    string info = 
    string `Name: ${student.name}, Age: ${student.age}, Year: ${student.year}`;

    if (student.modules.length() > 0) {
        info += ", Module(s): " + student.modules.toString();
    }
    io:println(info);
}
