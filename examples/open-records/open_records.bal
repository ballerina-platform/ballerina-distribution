import ballerina/io;

// `Person` type allows additional fields with `anydata` values.
type Person record {
    string name;
};

// `Employee` type allows additional fields with `anydata` values.
type Employee record {
    string name;
    int id;
};

// Adds an additional `id` field to `e`.
Employee e = {
    name: "James", id: 10
};

// You can assign an `Employee` type value to a `Person`.
Person p = e;

Person p2 = {
    name: "John", "country": "UK"
};

// You can assign a `Person` type value to a `map`.
map<anydata> m = p2;

public function main() {
    io:println(p);
    io:println(m);
}
