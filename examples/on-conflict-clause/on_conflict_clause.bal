import ballerina/io;

type Employee record {|
    readonly int id;
    string name;
    string role;
    int salary;
|};

public function main() {
    table<Employee> employees = table [
            {id: 1, name: "Mike", role: "Admin", salary: 100},
            {id: 2, name: "John", role: "HR", salary: 150},
            {id: 3, name: "Amy", role: "HR", salary: 150},
            {id: 1, name: "Mike", role: "Admin", salary: 200}
        ];

    // The result of the following will be an error since the map key `Mike` is duplicated
    // and the `replaceIfSafe()` function returns an error for the role `Admin`.
    map<int>|error employeeScores = map from var {name, salary, role} in employees
                                   select [name, salary]
                                   on conflict replaceIfSafe(role);

    io:println(employeeScores);

    // The result of the following will be an error since the key `1` is duplicated
    // and `replaceIfSafe()` function returns an error for the role `Admin`.
    table<Employee> key(id)|error employeeScoresTable = table key(id) from var employee in employees
                                                      select employee
                                                      on conflict replaceIfSafe(employee.role);

    io:println(employeeScoresTable);

    table<Employee> employees2 = table [
            {id: 1, name: "Mike", role: "Admin", salary: 100},
            {id: 2, name: "John", role: "HR", salary: 150},
            {id: 1, name: "John", role: "HR", salary: 200}
        ];

    // The value `150` of the map key `John` will be replaced by the second occurrence value `200`
    // since `replaceIfSafe()` function returns `nil` for the role 'HR`.
    map<int>|error lastRoundScore = map from var employee in employees2
                                    select [employee.name, employee.salary]
                                    on conflict replaceIfSafe(employee.role);

    io:println(lastRoundScore);

    // The return value will be just the construct type if the `on conflict` clause
    // always returns nil.
    map<int> lastRoundScore2 = map from var employee in employees2
                               select [employee.name, employee.salary]
                               on conflict ();

    io:println(lastRoundScore2);
}

function replaceIfSafe(string role) returns error? {
    if role == "Admin" {
        return error("Key Conflict", message = "record with same key exists.");
    }
}
