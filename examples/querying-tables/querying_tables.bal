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
        {id: 2, firstName: "Jane", lastName: "Smith", salary: 150},
        {id: 4, firstName: "Fred", lastName: "Bloggs", salary: 200},
        {id: 7, firstName: "Bobby", lastName: "Clark", salary: 300},
        {id: 9, firstName: "Cassie", lastName: "Smith", salary: 250}
    ];

    // The `from` clause iterates `employees` table.
    // The query expression creates an integer `array` based on the contextually-expected type.
    int[] salaries = from var {salary} in employees
                     select salary;


    io:println(salaries);

    // `from` clause iterates `employees` `table` and creates a `table`.
    // The query expression creates a `table` based on the contextually-expected type.
    table<Employee> smiths = from Employee emp in employees
                     where emp.lastName == "Smith" select emp;

    foreach Employee emp in smiths {
        io:println(emp.firstName, " ", emp.lastName);
    }
}
