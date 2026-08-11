import ballerina/io;
import ballerina/xlsx;

type Employee record {|
    // This annotation is used to map the `Employee Name` column header
    // in the sheet to the `name` field of the record.
    @xlsx:Name {
        value: "Employee Name"
    }
    string name;
    decimal salary;
|};

public function main() returns error? {
    check xlsx:writeSheet([
            {"Employee Name": "Alice", "SALARY": 4500.50},
            {"Employee Name": "Bob", "SALARY": 3800.00},
            {"Employee Name": "Carol", "SALARY": 5100.25}
        ], "employees.xlsx", "Staff", sheetWriteMode = xlsx:REPLACE);

    Employee[] employees = check xlsx:parseSheet("employees.xlsx", "Staff", {
        // Match column headers ignoring case, so `SALARY` binds to `salary`.
        caseInsensitiveHeaders: true,
        // Read only the first two data rows.
        rowCount: 2
    });
    io:println(employees);
}
