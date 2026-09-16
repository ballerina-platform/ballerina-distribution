import ballerina/io;
import ballerina/xlsx;

// Represents the details of an employee.
type Employee record {|
    string name;
    string team;
    decimal salary;
|};

public function main() returns error? {
    // Create a workbook file to parse.
    check xlsx:writeSheet([
            {name: "Alice", team: "Engineering", salary: 4500.00},
            {name: "Bob", team: "Sales", salary: 3800.00}
        ], "employees.xlsx", "Employees", sheetWriteMode = xlsx:REPLACE);

    // Parse the sheet into an array of records. Columns are matched to
    // record fields by the header row.
    Employee[] employees = check xlsx:parseSheet("employees.xlsx", "Employees");
    io:println(employees);
}
