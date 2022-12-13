import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

listener http:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// Basic authentication with the file user store can be enabled by setting 
// the `http:FileUserStoreConfig` configuration.
// Authorization is based on scopes, which can be specified in the `scopes` field.
@http:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["admin"]
        }
    ]
}
service / on securedEP {

    // The authentication and authorization configurations can be overwritten at 
    // the resource level. Otherwise, the service level configurations will be 
    // applied automatically to the resource.
    resource function get albums() returns Album[] {
        return [
            {title: "Blue Train", artist: "John Coltrane"},
            {title: "Jeru", artist: "Gerry Mulligan"}
        ];
    }
}
