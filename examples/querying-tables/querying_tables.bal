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

    // Since the contextually-expected type for the query expression is `int[]`,
    // the evaluation of the query expression will result in an integer array.
    int[] salaries = from var emp in employees
                     select emp.salary;
    io:println(salaries);

    // The query expression creates a table based on the contextually-expected type.
    table<Employee> highPaidEmployees = from Employee emp in employees
                             where emp.salary > 180
                             order by emp.firstName
                             select emp;

    foreach Employee emp in highPaidEmployees {
        io:println(emp.firstName, " ", emp.lastName);
    }
}
