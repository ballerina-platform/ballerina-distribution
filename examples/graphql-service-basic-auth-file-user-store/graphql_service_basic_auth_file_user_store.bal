import ballerina/graphql;

type Profile record {|
    string name;
    int age;
|};

listener graphql:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// Basic authentication with the file user store can be enabled by setting
// the `graphql:FileUserStoreConfig` configuration.
// Authorization is based on scopes, which can be specified in the `scopes` field.
@graphql:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["admin"]
        }
    ]
}
service /graphql on securedEP {
    resource function get profile() returns Profile {
        return {
            name: "Walter White",
            age: 50
        };
    }
}
