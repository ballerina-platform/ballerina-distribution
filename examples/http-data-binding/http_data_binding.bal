import ballerina/http;

xmlns "http://www.test.com" as test;

public type Student record {
    string Name;
    int Grade;
};

service /info on new http:Listener(9090) {

    // The `Student` parameter in the payload annotation.
    // represents the entity body of the inbound request.
    // For details, see https://lib.ballerina.io/ballerina/http/latest/records/Payload.
    resource function post student(@http:Payload Student student) returns string {
        return student.Name;
    }

    //Binds the XML payload of the inbound request to the `store` variable.
    resource function post store(@http:Payload xml store) returns xml {
        xml city = store/<test: city>;
        return city;
    }
}
