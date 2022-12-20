import ballerina/websocket;

listener websocket:Listener chatListener = new (9090,
    secureSocket = {
    key: {
        certFile: "../resource/path/to/public.crt",
        keyFile: "../resource/path/to/private.key"
    }
}
);

// The service can be secured with Basic authentication and can be authorized optionally.
// Using Basic authentication with the file user store can be enabled by setting the
// `websocket:FileUserStoreConfig` configurations.
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
service /chat on chatListener {
    resource function get .() returns websocket:Service {
        return new ChatService();
    }
}

service class ChatService {
    *websocket:Service;
    remote function onMessage(websocket:Caller caller, string chatMessage) returns websocket:Error? {
        check caller->writeMessage("Hello, How are you?");
    }
}
