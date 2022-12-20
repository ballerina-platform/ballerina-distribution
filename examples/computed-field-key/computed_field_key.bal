import ballerina/io;

const ID = "unique-identifier";

function getStudentDetails(string studentId,
        string name,
        string org,
        string orgName) returns map<string> {
    return {
        // The `"unique-identifier"` value is substituted from the constant `ID` as the key.
        [ID] : studentId,
        "name": name,
        // The key computed at runtime will be the concatenation of `_` and
        // the argument passed for `org`.
        ["_" + org] : orgName
    };
}

public function main() {
    map<string> studentDetails = getStudentDetails("stu123", "John", "school", "West High");
    io:println(studentDetails);
}
