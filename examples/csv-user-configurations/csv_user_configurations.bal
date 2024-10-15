import ballerina/data.csv;
import ballerina/io;

// Defines the structure of an `Employee` record.
type Employee record {|
    int id;
    string name;
    string department;
|};

// Defines the structure of an `EmployeeDepartment` record.
type EmployeeDepartment record {|
    int id;
    string department;
|};

public function main() returns error? {
    // This CSV string contains `|` separated values and a comment.
    // The `"` character in `O\"Connor` value is escaped using the `\` character.
    string csvString = string `id|name|department # This is a comment
                                1|O\"Connor|Engineering
                                2|Doe|HR
                                3|Jane|Finance
                                4|John|Engineering`; 

    // Defines the options for parsing the CSV string.                            
    // The `|` character is used as the delimiter for separating fields.
    // The `\` character is used to escape characters (e.g., quotes) within the data.
    // The `#` character indicates the start of a comment, lines starting with `#` will be ignored.
    // The second and fourth data rows will be skipped during parsing.
    csv:ParseOptions parseOptions = {
        delimiter: "|",
        escapeChar: "\\",
        comment: "#",
        skipLines: [2, 4]
    };

    // Parse the CSV string into an array of `Employee` records with specified options.
    Employee[] employees = check csv:parseString(csvString, parseOptions);
    io:println(employees);

    Employee[] employeeRecords = [
        {id: 1, name: "John", department: "Engineering"},
        {id: 2, name: "Doe", department: "HR"},
        {id: 3, name: "Jane", department: "Finance"},
        {id: 4, name: "John", department: "Engineering"}
    ];
    
    // Defines the options for transforming the `Employee` records.
    // The second and fourth data rows will be skipped during transformation.
    csv:TransformOptions transformOptions = {
        skipLines: [2, 4]
    };

    // Transform the `employee` records into `EmployeeDepartment` records with specified options.
    EmployeeDepartment[] employeeDepartments = check csv:transform(employeeRecords, transformOptions);
    io:println(employeeDepartments);
}
