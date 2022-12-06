import ballerina/graphql;
import ballerina/io;

// The `ProfileResponse` is a sub-type of `graphql:GenericResponseWithErrors`.
// The `graphql:GenericResponseWithErrors` record represents the generic shape of the GraphQL
// response. The `graphql:GenericResponseWithErrors` record contains `data`, `errors`
// and `extension`s fields where `data` represents the requested data from the GraphQL server,
// `errors` represents the `Field Errors` raised during the execution and `extensions` represents
// the meta information on protocol extensions from the GraphQL server.
type ProfileResponse record {|
    *graphql:GenericResponseWithErrors;
    record {|Profile profile;|} data;
|};

// If `Field Errors` are raised from the GraphQL server side for the `age` and `name` fields then
// the server sets `null` values for these fields. If these fields are of `NON_NULL` type then the
// errors are further propagated to their parent fields. The following record type defines the
// shape of the response from a GraphQL service which allows the `name` and `age` fields to have a
// `null` value.
type Profile record {|
    string? name;
    int? age;
|};

public function main() returns error? {
    // Creates a new client with the backend URL.
    graphql:Client graphqlClient = check new ("localhost:9090/graphql");

    string document = "{ profile { name, age } }";
    ProfileResponse response = check graphqlClient->execute(document);
    
    // Access the data from the response.
    io:println(response.data);

    if response.errors !is () {
        // Access the `Field errors` from the response.
        io:println(response.errors);
    }
}
