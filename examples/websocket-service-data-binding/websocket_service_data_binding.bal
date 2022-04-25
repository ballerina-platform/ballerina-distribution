import ballerina/log;
import ballerina/websocket;

public type Person record {|
    string name;
    int age;
|};

service /basic on new websocket:Listener(9090) {
    resource function get ws() returns websocket:Service|websocket:Error {
        return new WsService();
    }
}

service class WsService {
    *websocket:Service;

    // Bind the incoming text data to `Person` record.
    remote isolated function onTextMessage(websocket:Caller con, Person person)
	                    returns websocket:Error? {
        log:printInfo("Person name: " + person.name);

        // Echo back the received `Person` record directly.
        check con->writeTextMessage(person);
    }
}
