import ballerina/io;

type Employee record {|
    readonly int id;
    string name;
    int score;
|};

public function main() {
    table<Employee> employees = table [
            {id: 1, name: "Admin", score: 100},
            {id: 2, name: "John", score: 150},
            {id: 1, name: "Admin", score: 200}
        ];

    // The result of the following will be an error since the key `Admin` is duplicated
    // and the `replaceIfSafe()` function returns an error for the key `Admin`.
    map<int>|error employeeScores = map from var {name, score} in employees
                                   select [name, score]
                                   on conflict replaceIfSafe(name);

    io:println(employeeScores);

    // The result of the following will be an error since the key `1` is duplicated
    // and `replaceIfSafe()` function returns an error for the name `Admin`.
    table<Employee> key(id)|error employeeScoresTable = table key(id) from var employee in employees
                                                      select employee
                                                      on conflict replaceIfSafe(employee.name);

    io:println(employeeScoresTable);

    table<Employee> employees2 = table [
            {id: 1, name: "Admin", score: 100},
            {id: 2, name: "Mike", score: 150},
            {id: 2, name: "Mike", score: 200}
        ];

    // The value `100` of the key `Mike` will be replaced by the second occurrence value `200`
    // since `replaceIfSafe()` function returns `nil` for the name 'Mike`.
    map<int>|error lastRoundScore = map from var employee in employees2
                                    select [employee.name, employee.score]
                                    on conflict replaceIfSafe(employee.name);

    io:println(lastRoundScore);

    // The return value will be just the construct type if the `on conflict` clause
    // always returns nil.
    map<int> lastRoundScore2 = map from var employee in employees2
                               select [employee.name, employee.score]
                               on conflict ();

    io:println(lastRoundScore2);
}

function replaceIfSafe(string name) returns error? {
    if name == "Admin" {
        return error("Key Conflict", message = "record with same key exists.");
    }
}
