import ballerina/graphql;
import ballerina/io;

type ProfileResponse record {|
    *graphql:GenericResponseWithErrors;
    record {|Profile profile;|} data;
|};

type Profile record {|
    string name;
    int age;
|};

public function main() returns error? {
    do {
        graphql:Client graphqlClient = check new ("localhost:9090/graphql");
        // This is a malformed GraphQL document.
        string document = "mutation { updateName(name: 1) { name, age } }";
        ProfileResponse response = check graphqlClient->execute(document);
        io:println(response);
    } on fail graphql:ClientError err {
        handleErrors(err);
    }
}

function handleErrors(graphql:ClientError clientError) {
    if clientError is graphql:PayloadBindingError {
        // This error represents a client-side data binding error. This error occurs due to the
        // assigned variable type and the value obtained from the wire having a mismatching 
        // shape.
        io:println("PayloadBindingError: ", clientError.message());
    } else if clientError is graphql:InvalidDocumentError {
        // This error represents GraphQL errors due to GraphQL server-side document 
        // validation. The GraphQL errors returned from the server-side can be obtained by 
        // calling the `detail()` method on `graphql:InvalidDocumentError`.
        graphql:ErrorDetail[]? errorDetails = clientError.detail().errors;
        io:println("InvalidDocumentError: ", errorDetails);
    } else if clientError is graphql:HttpError {
        // This error represents network-level errors. If the response from the server contains 
        // a body then, it can be obtained by calling the `detail()` method on `graphql:HttpError`.
        anydata body = clientError.detail().body;
        io:println("HttpError: ", body, clientError.message());
    }
}
