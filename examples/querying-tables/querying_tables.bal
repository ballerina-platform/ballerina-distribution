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
        {id: 2, firstName: "Fred", lastName: "Bloggs", salary: 200}
    ];

    // `from` clause iterates `employees` `table`.
    // The contextually-expected type of the `query expression` is an `int[]`.
    int[] salaries = from var {salary} in employees
                     select salary;


    io:println(salaries);
}
