import ballerina/io;

// Defines a `closed record` type named `Student`. It only allows fields that are specified.
type Student record {|
    string name;
    int age;
|};

// Defines an `open record` type named `Employee`. It allows fields other than those specified.
type Employee record {
    string name;
    int age;
};

public function main() {
    // Creates an `open record` by specifying values for its fields.
    record {string name; int age;} person = {
        name: "Harry",
        age: 12
    };

    // Creates a record using the `Student` type definition.
    Student student = {
        name: "Harry",
        age: 12
    };

    // Creates a record using the `Employee` type definition with an additional `country` field.
    Employee employee = {
        name: "Harry",
        age: 12,
        "country": "UK"
    };

    // Accesses the `name` field in `employee`.
    string name = employee.name;
    io:println(name);

    // The two `person` & `student` records are equal since they have the same set of fields 
    // and values.
    io:println(person == student);

    // Record equality returns `false` on the following two records as `employee` has 
    // an additional field called `country`.
    io:println(person == employee);
}
