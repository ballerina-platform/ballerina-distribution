import ballerina/http;

xmlns "http://www.test.com" as test;

type Student record {
    string Name;
    int Grade;
};

service /hello on new http:Listener(9090) {

    // The `Student` parameter in the [payload annotation](https://docs.central.ballerina.io/ballerina/http/latest/records/Payload)
    // represents the entity body of the inbound request.
    resource function post student(@http:Payload Student student) returns json {
        string name = student.Name;
        return {Name: name};
    }

    //Binds the XML payload of the inbound request to the `store` variable.
    resource function post store(@http:Payload xml store) returns xml {
        xml city = store/<test: city>;
        return city;
    }
}
