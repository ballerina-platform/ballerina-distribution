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

service /graphql on securedEP {
    resource function get profile() returns Profile {
        return {
            name: "Walter White",
            age: 50
        };
    }
}
