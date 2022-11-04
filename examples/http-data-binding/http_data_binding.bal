import ballerina/http;

xmlns "http://www.test.com" as test;

public type Student record {
    string name;
    int grade;
};

service /register on new http:Listener(9090) {

    // The `Student` parameter in the payload annotation.
    // represents the entity body of the inbound request.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/Payload.
    resource function post student(@http:Payload Student student) returns string {
        return string `Student data of '${student.name}' is updated`;
    }
}
