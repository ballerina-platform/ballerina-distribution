import ballerina/http;

type Student record {
    string Name;
    int Grade;
    map<any> Marks;
};

service /hello on new http:Listener(9090) {

    // The `orderDetails` parameter in [Payload annotation](https://docs.central.ballerina.io/ballerina/http/latest/records/Payload)
    // represents the entity body of the inbound request.
    resource function post bindJson(@http:Payload json orderDetails)
            returns json|http:BadRequest {
        //Accesses the JSON field values.
        var details = orderDetails.Details;
        if (details is json) {
            return details;
        } else {
            http:BadRequest response = {body: "Order Details unavailable"};
            return response;
        }
    }

    //Binds the XML payload of the inbound request to the `store` variable.
    @http:ResourceConfig {
        consumes: ["application/xml"]
    }
    resource function post bindXML(@http:Payload xml store) returns xml {
        //Accesses the XML content.
        xml city = store.selectDescendants("{http://www.test.com}city");
        return city;
    }

    //Binds the JSON payload to a custom record. The payload's content should
    //match the record.
    @http:ResourceConfig {
        consumes: ["application/json"]
    }
    resource function post bindStruct(@http:Payload Student student)
            returns json {
        //Accesses the fields of the `Student` record.
        string name = <@untainted>student.Name;
        int grade = <@untainted>student.Grade;
        string english = <@untainted string>student.Marks["English"];
        return {Name: name, Grade: grade, English: english};
    }
}
