import ballerina/io;

type Employee record {|
    readonly int id;
    string firstName;
    string lastName;
    int salary;
|};

public function main() {
    table<Employee> key(id) employees = table [
        {id: 1, firstName: "John", lastName: "Smith", salary: 100},
        {id: 2, firstName: "Fred", lastName: "Bloggs", salary: 2000}
    ];

    // The query expression starts with `table`.
    // The key specifier `key(id)` specifies the key sequence of the constructed `table`.
    // The result of the query expression is a `table`.
    var highPaidEmployees = table key(id) from var e in employees
                            where e.salary >= 1000
                            select e;


    io:println(highPaidEmployees);
}
