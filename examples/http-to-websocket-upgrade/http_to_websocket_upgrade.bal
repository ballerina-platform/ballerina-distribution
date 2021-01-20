import ballerina/http;
import ballerina/io;
import ballerina/log;

@http:ServiceConfig {
    basePath: "/hello"
}
service httpService on new http:Listener(9090) {
    // This is an HTTP to WebSocket upgrade resource. This is defined using the WebSocket upgrade resource config.
    // Here you have access to the [http:Request](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/classes/Request), query, and path params where applicable.
    @http:ResourceConfig {
        webSocketUpgrade: {
            upgradePath: "/ws",
            upgradeService: wsService
        }
    }
    resource function upgrader(http:Caller caller, http:Request req) {

    }
}


// Note: When a WebSocket upgrade path is defined in the HTTP resource configuration. <br>
// - Without service configuration for WebSocketService default values are taken for sub protocols, idle timeout etc.<br>
// - If [WebSocketServiceConfig](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/http/latest/http/annotations#WebSocketServiceConfig) is defined without the path, sub protocols, idle timeout etc. can be configured.<br>
// - If path is defined in the `WebSocketServiceConfig` it shall be ignored.<br>
// - This service can also be bound to a different `Listener` in which case the path configuration becomes useful.
service wsService = @http:WebSocketServiceConfig {subProtocols: ["xml, json"]
                                         ,idleTimeoutInSeconds: 20} service {

    resource function onOpen(http:WebSocketCaller caller) {
        io:println("New WebSocket connection: " + caller.getConnectionId());
    }

    resource function onText(http:WebSocketCaller caller, string text) {
        io:println(text);
        var err = caller->pushText(text);
        if (err is error) {
            log:printError("Error sending message", err);
        }
    }

    resource function onIdleTimeout(http:WebSocketCaller caller) {
        io:println("Idle timeout: " + caller.getConnectionId());
    }
};
