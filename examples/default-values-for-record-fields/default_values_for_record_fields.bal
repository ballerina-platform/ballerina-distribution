import ballerina/io;

type Student record {|
    string name;
    int age;
    // Specifies a default value for `code`.
    string code = "Admitted";
|};

type PartTimeStudent record {|
    *Student;
    int studyHours;
|};

public function main() returns error? {
    // Creates a `Student` record without explicitly specifying a value for the `code` field.
    Student s1 = {name: "Anne", age: 23};
    io:println(s1);

    json j = {name: "Anne", age: 23};
    // Calling the `value:cloneWithType()` function with `Student` will make use of default values
    // in `Student`.
    Student s2 = check j.cloneWithType(Student);
    io:println(s2);

    // `*Student` copies the default values.
    PartTimeStudent s3 = {name: "Anne", age: 23, studyHours: 6};
    io:println(s3);
}
