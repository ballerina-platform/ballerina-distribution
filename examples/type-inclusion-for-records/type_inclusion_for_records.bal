import ballerina/io;

type Person record {|
    string name;
    int age;
|};

type Student record {|
    int studentId;
    string code;
|};

// The `PartTimeStudent` record has all the fields of `Person` and `Student`.
type PartTimeStudent record {|
    *Person;
    *Student;
    // Overrides the `code` field in `Student`.
    string:Char code;
|};

public function main() {
    PartTimeStudent student = {
        name: "Anne",
        age: 23,
        studentId: 1001,
        code: "A"
    };
    io:println(student);
}
