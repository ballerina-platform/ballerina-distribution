import ballerina/io;

type Employee record {|
    string company = "WS02";
    string name;
    string department;
|};

type ContractEmployee record {|
    *Employee;
    int duration;
|};

public function main() returns error? {
    // Calling the `value:cloneWithType()` function with `Employee` will make use of default values
    // in `Employee`.
    json j = {name: "John", department: "IT"};
    io:println(check j.cloneWithType(Employee));

    // `*Employee` copies the default values.
    ContractEmployee emp = {name: "Anne", department: "HR", duration: 12};
    io:println(emp);
}
