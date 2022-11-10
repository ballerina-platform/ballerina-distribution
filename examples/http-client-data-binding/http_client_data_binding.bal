import ballerina/http;

public type Person record {|
    string name;
    int age;
|};

http:Client httpClient = check new("http://localhost:9092");

service / on new http:Listener(9090) {
    resource function get person() returns Person|error {
        // Binding the payload to a `record`` type. The contextually expected type is inferred from the LHS variable type.
        Person person = check httpClient->/backend/data;
        return person;
    }
}

service /backend on new http:Listener(9092) {
    resource function get data() returns Person {
        return {name: "Smith", age: 15};
    }
}
