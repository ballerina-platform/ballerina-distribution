import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    string empId = "16c6553a-373c-4b29-b1c8-c282f444248c";

    // Update hire date of employee with id 16c6553a-373c-4b29-b1c8-c282f444248c
    store:Employee employee = check sClient->/employees/[empId].put({
        hireDate: {
            year: 2014,
            month: 5,
            day: 1
        }
    });
    io:println(string `Updated employee record: ${employee.toString()}`);
}
