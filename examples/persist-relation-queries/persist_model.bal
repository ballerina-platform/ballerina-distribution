import ballerina/persist as _;
import ballerina/time;

type Employee record {|
    readonly string id;
    string firstName;
    string lastName;
    time:Date birthDate;
    string gender;
    time:Date hireDate;

    // one-to-many relationship with Department
    Department department;
    // one-to-one relationship with Workspace
    Workspace workspace;
|};

type Workspace record {|
    readonly string id;
    string workspaceType;

    // one-to-many relationship with Building
    Building location;
    // one-to-one relationship with Employee
    Employee? employee;
|};

type Department record {|
    readonly string no;
    string deptName;

    // one-to-many relationship with Employee
    Employee[] employees;
|};

type Building record {|
    readonly string code;
    string city;
    string state;
    string country;
    string postalCode;
    string 'type;

    // one-to-many relationship with Workspace
    Workspace[] workspaces;
|};
