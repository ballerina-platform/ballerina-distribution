import ballerina/http;
import ballerinax/azure_functions as af;

public type Person record {
    string name;
    int age;
};

service / on new af:HttpListener() {
    resource function post queue(@http:Payload Person person) returns [@af:HttpOutput http:Created, @af:QueueOutput {queueName: "people"} string] {
        http:Created httpRes = {
            body: person.name + " Added to the Queue!"
        };
        return [httpRes, person.name + " is " + person.age.toString() + " years old."];
    }
}