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

    // The `key(id)` key specifier specifies the key sequence of the constructed table.
    // `select` clause must emit values belonging to `map<any|error>`.
    var highPaidEmployees = table key(id) from var e in employees
                            where e.salary >= 1000
                            select e;

    io:println(highPaidEmployees);

    // A table can also be constructed by providing the contextually expected type.
    // `table<Employee>` is the contextually expected type.
    // `select` clause must emit values belonging to `Employee`.
    table<Employee> highPaidEmployees2 = from var e in employees
                                         where e.salary >= 1000
                                         select e;
    io:println(highPaidEmployees2);
}
