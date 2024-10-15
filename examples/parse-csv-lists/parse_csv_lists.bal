import ballerina/data.csv;
import ballerina/io;

// Represents the details of an employee.
type Employee record {|
    int empId;
    string empName;
    string department;
    float salary;
|};

// Represents the salary details of an employee.
type EmployeeSalary record {|
    // This annotation is used to map the empId field in the source CSV record 
    // to the id field in the target record.
    @csv:Name {
        value: "empId"
    }
    int id;
    float salary;
|};

public function main() returns error? {
    // Sample CSV string array representing employee data.
    string[][] csvList = [
        ["1", "John", "Engineering", "1000.0"],
        ["2", "Doe", "HR", "2000.0"],
        ["3", "Jane", "Finance", "3000.0"]
    ];

    // Parse the CSV list into an array of `Employee` records by specifying custom headers.
    Employee[] employees = check csv:parseList(csvList, {
        customHeaders: ["empId", "empName", "department", "salary"]
    });
    io:println(employees);

    // Parse the CSV list into an array of `EmployeeSalary` records by specifying custom headers.
    // Only the fields specified in the EmployeeSalary type (`id` and `salary`) 
    // are included in the resulting array.
    EmployeeSalary[] employeeSalaries = check csv:parseList(csvList, {
        customHeaders: ["empId", "empName", "department", "salary"]
    });
    io:println(employeeSalaries);

    // Parse the CSV list into an array of `anydata` arrays.
    anydata[][] employeesArray = check csv:parseList(csvList);
    io:println(employeesArray);
}
