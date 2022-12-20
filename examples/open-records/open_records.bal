import ballerina/io;

// `Student` type allows additional fields with `anydata` values.
type Student record {
    string name;
    int age;
};

type PartTimeStudent record {|
    string name;
    int age;
    // Rest descriptor allows additional fields with `anydata` values
    // in `PartTimeStudent` type.
    anydata...;
|};

public function main() {
    // Adds an additional `country` field to `s1`.
    Student s1 = {
        name: "John",
        age: 25,
        "country": "UK"
    };
    io:println(s1);

    // Accesses the `age` field in `s1`.
    int age = s1.age;
    io:println(age);

    // Accesses the `country` field in `s1`.
    anydata country = s1["country"];
    io:println(country);

    // Adds an additional `studyHours` field to `s2`.
    PartTimeStudent s2 = {
        name: "Anne",
        age: 23,
        "studyHours": 6
    };

    // Accesses the `studyHours` field in `s2`.
    anydata studyHours = s2["studyHours"];
    io:println(studyHours);

    // Adds an additional `credits` field to `s2`.
    s2["credits"] = 120.5;
    io:println(s2);

    // You can assign a `PartTimeStudent` type value to a `Student`.
    Student s3 = s2;
    io:println(s3);

    // You can assign a `Person` type value to a `map`.
    map<anydata> s4 = s3;
    io:println(s4);
}
