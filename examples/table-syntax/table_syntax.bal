import ballerina/io;

type Employee record {
    readonly string name;
    int salary;
};

// Creates a `table` with `Employee` type members, where each
// member is uniquely identified using their `name` field.
table<Employee> key(name) t = table [
    { name: "John", salary: 100 },
    { name: "Jane", salary: 200 }
];

function increaseSalary(int n) {
    // Iterates over the rows of `t` in the specified order.
    foreach Employee e in t {
        e.salary += n;
    }

}

public function main() {
    // Retrieves `Employee` with key value `Fred`.
    Employee? e = t["Fred"];
    io:println(e.toBalString());

    increaseSalary(100);
    io:println(t);
}
