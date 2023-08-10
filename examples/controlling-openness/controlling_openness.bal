import ballerina/io;

type Student record {|
    string name;
    string country;
|};

type PartTimeStudent record {|
    string name;
    string country;
    // Rest descriptor of type `string` allows additional fields with `string` values.
    string...;
|};

public function main() {
    // `s1` can only have fields exclusively specified in `Student`.
    Student s1 = {name: "Anne", country: "UK"};

    // `s1` is a `map` with `string` values.
    map<string> s2 = s1;
    io:println(s2);

    // `s3` has an additional `faculty` field.
    PartTimeStudent s3 = {
        name: "Anne",
        country: "UK",
        "faculty": "Science"
    };

    // Accesses the `faculty` field in `s3`.
    string? faculty = s3["faculty"];
    io:println(faculty);

    // `s3` is a `map` with `string` values.
    map<string> s4 = s3;
    io:println(s4);
}
