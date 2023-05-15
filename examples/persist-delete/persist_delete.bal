import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    string empId = "16c6553a-373c-4b29-b1c8-c282f444248c";

    // Delete employee record with id 16c6553a-373c-4b29-b1c8-c282f444248c
    store:Employee employee = check sClient->/employees/[empId].delete();
    io:println(string `Deleted employee record: ${employee.toString()}`);
}
