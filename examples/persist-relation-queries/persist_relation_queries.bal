import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    // Get record with relation fields for one-to-one relation
    stream<EmployeeWorkspace, persist:Error?> empWorkspaceStream = sClient->/employees;
    check from var empWorkspace in empWorkspaceStream
        do {
            io:println(empWorkspace);
        };

    // Get record with relation fields for one-to-many relation
    stream<DepartmentEmployees, error?> departmentStream = sClient->/departments;
    check from var department in departmentStream
        do {
            io:println(department);
        };
}

// A record with relation fields - one-to-one relation
type EmployeeWorkspace record {|
    string id;
    string firstName;
    string lastName;
    record {|
        string id;
        string workspaceType;
    |} workspace;
|};

// A record with relation fields - one-to-many relation
type DepartmentEmployees record {|
    string id;
    string name;
    record {|
        string id;
        string firstName;
        string lastName;
    |}[] employees;
|};
