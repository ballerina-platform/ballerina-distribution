import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    // Get only the employee_id, first_name and last_name fields of all the records
    stream<EmployeeName, persist:Error?> empNames = sClient->/employees;
    check from var name in empNames
        do {
            io:println(name);
        };

    // Get only the employee_id, first_name and last_name fields of a single record
    string empId = "16c6553a-373c-4b29-b1c8-c282f444248c";
    EmployeeName employee = check sClient->/employees/[empId];
    io:println(employee);
}

// A record with subset of fields
type EmployeeName record {|
    string id;
    string firstName;
    string lastName;
|};
