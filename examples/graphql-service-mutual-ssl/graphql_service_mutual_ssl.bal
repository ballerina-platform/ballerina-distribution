import ballerina/graphql;
import ballerina/http;

type Profile record {|
    string name;
    int age;
|};

// A GraphQL listener can be configured to accept new connections that are secured via mutual SSL.
listener graphql:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        // Enables mutual SSL.
        mutualSsl: {
            verifyClient: http:REQUIRE,
            cert: "../resource/path/to/public.crt"
        }
    }
);

service /graphql on securedEP {
    resource function get profile() returns Profile {
        return {
            name: "Walter White",
            age: 50
        };
    }
}
