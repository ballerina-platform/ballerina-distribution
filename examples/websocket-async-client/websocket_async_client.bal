import ballerina/lang.runtime as runtime;
import ballerina/io;
import ballerina/websocket;

public function main() returns websocket:Error? {
    // Creates a new [WebSocket Async client](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/clients/AsyncClient) with the backend URL and assigns a callback service.
    websocket:AsyncClient wsClientEp = check new ("ws://echo.websocket.org",
                                          new ClientService());
    // Writes a text message to the server using [writeString](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/websocket/clients/AsyncClient#writeString).
    var err = wsClientEp->writeString("Hello World!");
    if (err is error) {
        // Prints the error.
        io:println(err);
    }
    runtime:sleep(5);
}
// The client callback service, which handles backend responses.
service class ClientService {
    *websocket:Service;
    // This remote function is triggered when a new text frame is received from
    // the remote backend.
    remote function onString(websocket:Caller conn, string text) {
        io:println(text);
    }
    // This is triggered if an error occurs.
    remote function onError(websocket:Caller conn, error err) {
        io:println(err);
    }
}
