import ballerina/log;
import ballerina/websocket;

type Person record {|
    string name;
    int age;
|};

public function main() returns error? {
   // Create a new [WebSocket client](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client).
   websocket:Client wsClient = check new("ws://localhost:9090/basic/ws");

   Person personRecord = {name: "John", age: 25};

   // Write the created Person record to the server.
   check wsClient->writeTextMessage(personRecord);

   // Read the text message echoed from the server and bind it to the Person record.
   Person person = check wsClient->readTextMessage();
   log:printInfo("Person name: " + person.name);
}
