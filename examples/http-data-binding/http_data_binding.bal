import ballerina/http;

type Student record {
    string Name;
    int Grade;
};

service /hello on new http:Listener(9090) {

    // The `Student` parameter in [Payload annotation](https://docs.central.ballerina.io/ballerina/http/latest/records/Payload)
    // represents the entity body of the inbound request.
    @http:ResourceConfig {
        consumes: ["application/json"]
    }
    resource function post bindStudent(@http:Payload Student student)
            returns json {
        string name = student.Name;
        return {Name: name};
    }

    //Binds the XML payload of the inbound request to the `store` variable.
    @http:ResourceConfig {
        consumes: ["application/xml"]
    }
    resource function post bindXML(@http:Payload xml store) returns xml {
        xml city = store.selectDescendants("{http://www.test.com}city");
        return city;
    }
}
