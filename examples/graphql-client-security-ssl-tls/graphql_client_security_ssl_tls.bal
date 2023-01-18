import ballerina/graphql;
import ballerina/io;

// User defined data types to retrive data from the service.
type ProfileResponse record {|
    *graphql:GenericResponseWithErrors;
    record {|Profile profile;|} data;
|};

type Profile record {|
    string name;
    int age;
|};

public function main() returns error? {
    // Create a GraphQL client with secure socket configurations. To secure a client using
    // HTTPS, the client needs to be configured with a certificate file of the listener.
    graphql:Client graphqlClient = check new("localhost:9090/graphql",
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    // Define the GraphQL document to be sent to the GraphQL service.
    string document = "{ profile { name, age } }";

    // Execute the document and retrieve the response from the GraphQL service.
    ProfileResponse response = check graphqlClient->execute(document);
    io:println(response.data.profile);
}
