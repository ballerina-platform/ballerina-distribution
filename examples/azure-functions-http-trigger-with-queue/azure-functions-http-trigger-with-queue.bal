import ballerina/http;
import ballerinax/azure.functions;

public type Person record {
    string name;
    int age;
};

service / on new functions:HttpListener() {
<<<<<<< HEAD
    resource function post queue(@http:Payload Person person) returns
    [@functions:HttpOutput http:Created, @functions:QueueOutput {queueName: "people"}
    string] {
        http:Created httpRes = {
            body: person.name + " Added to the Queue!"
        };
        return [httpRes, string `${person.name} is ${person.age.toString()} years old.`];
=======
    resource function post queue(@http:Payload Person person) returns [@functions:HttpOutput http:Created, @functions:QueueOutput {queueName: "people"} string] {
        http:Created httpRes = {
            body: person.name + " Added to the Queue!"
        };
        return [httpRes, person.name + " is " + person.age.toString() + " years old."];
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae
    }
}
