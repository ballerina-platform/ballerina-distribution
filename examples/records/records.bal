import ballerina/io;

// Defines a `closed record` type named `Student`. It only allows fields that are specified.
type Student record {|
    string name;
    int age;
|};

// Defines an `open record` type named `Person`. It allows fields other than those specified.
type Person record {
    string name;
    int age;
};

public function main() {
    // Creates an `open record` by specifying values for its fields.
    record {string name; int age;} stu = {
        name: "Harry",
        age: 12
    };

    // Accesses the `name` field in `stu`.
    string name = stu.name;
    io:println(name);

    // Creates a record using the `Student` type definition.
    Student student = {
        name: "Harry",
        age: 12
    };

    // Accesses the `age` field in `student`.
    int age = student.age;
    io:println(age);

    // Creates a record using the `Person` type definition with an additional `country` field.
    Person person = {
        name: "Harry",
        age: 12,
        "country": "UK"
    };

    // The two `stu` & `student` records are equal since they have the same set of fields 
    // and values.
    io:println(stu == student);

    // Record equality returns `false` on the following two records as `person` has 
    // an additional field called `country`.
    io:println(stu == person);
}
