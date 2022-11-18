import ballerina/graphql;
import ballerina/io;

// User defined data types to perform client side data-binding. This includes separate fields for
// GraphQL errors and data.
type ResponseWithErrors record {|
    *graphql:GenericResponseWithErrors;
    Data data;
|};

type Data record {|
    Person profile;
|};

type Person record {|
    string name;
    int age;
|};

public function main() returns error? {
    // Creates a new client with the backend URL.
    graphql:Client graphqlClient = check new ("http://localhost:4000/graphql");

    string document = "{ profile { name, age } }";

    // The `execute()` remote function of the graphql:Client takes a GraphQL document as the
    // required argument and sends a request to the specified backend URL seeking a response. On the
    // retrieval of a successful response, the client tries to perform data binding for the
    // user-defined data type. On failure to retrieve a successful response or when the client fails
    // to perform data binding, a graphql:ClientError will be returned.
    ResponseWithErrors response = check graphqlClient->execute(document);
    io:println(response.data.profile);
}
