import ballerina/http;
import ballerinax/azure.functions;

public type Person record {
    string name;
    int age;
};

service / on new functions:HttpListener() {
    resource function post queue(@http:Payload Person person) returns
    [@functions:HttpOutput http:Created, @functions:QueueOutput {queueName: "people"}
    string] {
        http:Created httpRes = {
            body: person.name + " Added to the Queue!"
        };
        return [httpRes, string `${person.name} is ${person.age.toString()} years old.`];
    }
}
