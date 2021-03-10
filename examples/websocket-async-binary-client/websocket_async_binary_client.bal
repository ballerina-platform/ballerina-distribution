import ballerina/io;
import ballerina/lang.'string;
import ballerina/websocket;

public function main() returns websocket:Error? {
    // Creates a new [WebSocket Async client](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/AsyncClient) with the backend URL and assigns a callback service.
    websocket:AsyncClient wsClientEp = check new ("ws://echo.websocket.org",
                                          new ClientService());
    // Writes a text message to the server using [writeBinaryMessage](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/AsyncClient#writeString).
    check wsClientEp->writeBinaryMessage("Hello World!".toBytes());
}

// The client callback service, which handles backend responses.
service class ClientService {
    *websocket:Service;
    // This remote function is triggered when a new binary message is
    // received from the remote backend.
    remote function onBinaryMessage(websocket:Caller conn, byte[] data)
                    returns error? {
        string stringData = check 'string:fromBytes(data);
        io:println(stringData);
    }
    // This is triggered if an error occurs.
    remote function onError(websocket:Caller conn, error err) {
        io:println(err);
    }
}
