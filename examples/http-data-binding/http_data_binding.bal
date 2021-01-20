import ballerina/http;
import ballerina/log;

type Student record {
    string Name;
    int Grade;
    map<any> Marks;
};

service /hello on new http:Listener(9090) {

    // The `orderDetails` parameter in [Payload annotation](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/records/Payload)
    // represents the entity body of the inbound request.
    resource function post bindJson(http:Caller caller, http:Request req,
                               @http:Payload {} json orderDetails) {
        //Accesses the JSON field values.
        var details = orderDetails.Details;
        http:Response res = new;
        if (details is json) {
            res.setPayload(<@untainted>details);
        } else {
            res.statusCode = 400;
            res.setPayload("Order Details unavailable");
        }
        var result = caller->respond(res);
        if (result is error) {
            log:printError(result.message(), err = result);
        }
    }

    //Binds the XML payload of the inbound request to the `store` variable.
    @http:ResourceConfig {
        consumes: ["application/xml"]
    }
    resource function post bindXML(http:Caller caller, http:Request req,
                                    @http:Payload {} xml store) {
        //Accesses the XML content.
        xml city = store.selectDescendants("{http://www.test.com}city");
        http:Response res = new;
        res.setPayload(<@untainted>city);

        var result = caller->respond(res);
        if (result is error) {
            log:printError(result.message(), err = result);
        }
    }

    //Binds the JSON payload to a custom record. The payload's content should
    //match the record.
    @http:ResourceConfig {
        consumes: ["application/json"]
    }
    resource function post bindStruct(http:Caller caller, http:Request req,
                                 @http:Payload {} Student student) {
        //Accesses the fields of the `Student` record.
        string name = <@untainted>student.Name;
        int grade = <@untainted>student.Grade;
        string english = <@untainted string>student.Marks["English"];
        http:Response res = new;
        res.setPayload({Name: name, Grade: grade, English: english});

        var result = caller->respond(res);
        if (result is error) {
            log:printError(result.message(), err = result);
        }
    }
}
