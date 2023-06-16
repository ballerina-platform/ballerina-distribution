import ballerina/persist as _;
import ballerina/time;

type Employee record {|
    readonly string id;
    string firstName;
    string lastName;
    time:Date birthDate;
    string gender;
    time:Date hireDate;
|};
