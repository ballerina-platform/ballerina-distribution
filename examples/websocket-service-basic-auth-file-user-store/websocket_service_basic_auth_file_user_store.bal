import ballerina/websocket;

listener websocket:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// The service can be secured with Basic auth and can be authorized optionally.
// Using Basic auth with the file user store can be enabled by setting the
// [`websocket:FileUserStoreConfig`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/FileUserStoreConfig) configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations for `scopes` field.
@websocket:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["admin"]
        }
    ]
}
service /foo on securedEP {
    resource isolated function get bar() returns websocket:Service {
        return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    remote isolated function onTextMessage(websocket:Caller caller,
                             string text) returns websocket:Error? {
        check caller->writeTextMessage(text);
    }
}
