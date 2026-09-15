import ballerina/io;
import ballerina/xlsx;

type Employee record {|
    string name;
    string team;
    decimal salary;
|};

public function main() returns error? {
    Employee[] employees = [
        {name: "Alice", team: "Engineering", salary: 4500.00},
        {name: "Bob", team: "Sales", salary: 3800.00}
    ];

    // Write the records to a sheet named `Employees` in the workbook file.
    // The record field names become the header row.
    check xlsx:writeSheet(employees, "employees.xlsx", "Employees",
            sheetWriteMode = xlsx:REPLACE);
    io:println("Created employees.xlsx");
}
