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
    // This annotation is used to map the `empId` field in the source CSV record 
    // to the `id` field in the target record.
    @csv:Name {
        value: "empId"
    }
    int id;
    float salary;
|};

public function main() returns error? {
    Employee[] employees = [
        {empId: 1, empName: "John", department: "Engineering", salary: 1000.0},
        {empId: 2, empName: "Doe", department: "HR", salary: 2000.0},
        {empId: 3, empName: "Jane", department: "Finance", salary: 3000.0}
    ];

    // Transform the `employees` array into an array of `EmployeeSalary` records.
    // Only the fields specified in the `EmployeeSalary` type (`id` and `salary`) 
    // are included in the resulting array.
    EmployeeSalary[] employeeSalaries = check csv:transform(employees);
    io:println(employeeSalaries);

    // Transform the `employees` array into an array of `anydata` arrays.
    anydata[][] employeesArray = check csv:transform(employees);
    io:println(employeesArray);
}
