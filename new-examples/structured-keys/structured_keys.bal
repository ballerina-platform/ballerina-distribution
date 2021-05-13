import ballerina/io;

type Employee record {
    readonly record {
        string first;
        string last;
    } name;
    int salary;
};

public function main() {
    // key field, `name` is of `record` type.
    table<Employee> key(name) t = table [
        {name: {first: "John", last: "Smith"}, salary: 100},
        {name: {first: "Fred", last: "Bloggs"}, salary: 200}
    ];

    Employee? e = t[{first: "Fred", last: "Bloggs"}];
    io:println(e);
}
