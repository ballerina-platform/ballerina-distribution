import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    string empId = "16c6553a-373c-4b29-b1c8-c282f444248c";
    // Get entire Employee record by key
    store:Employee employee = check sClient->/employees/[empId];
    io:println(employee);
}
