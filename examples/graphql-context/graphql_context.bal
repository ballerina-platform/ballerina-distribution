import ballerina/graphql;
import ballerina/http;
import ballerina/lang.value;

// Define a record type to use as an object in the GraphQL service.
type Profile record {|
    string name;
    int age;
    float salary;
|};

@graphql:ServiceConfig {
    // Initialization of the `graphqlContext` should be provided to the `contextInit` field.
    contextInit: isolated function(http:RequestContext requestContext, http:Request request)
    returns graphql:Context|error {

        // Initialize the `graphql:Context` object.
        graphql:Context context = new;

        // Retrieve the header named `scope` from the `http:request` and set it to the context with
        // the `scope` key. If the header does not exist, this will return an `error`, and thereby,
        // the request will not be processed.
        context.set("scope", check request.getHeader("scope"));

        // Finally, the context object should be returned.
        return context;
    }
}
service /graphql on new graphql:Listener(9090) {
    // Define a `Profile` field inside the service.
    private final Profile profile;

    function init() {
        // Initialize the `profile` value.
        self.profile = {name: "Walter White", age: 51, salary: 737000.00};
    }

    // If the context is needed, it should be defined as the first parameter of the resolver
    // function.
    resource function get profile(graphql:Context context) returns Profile|error {
        // Retrieve the `scope` attribute from the context. This will return a `graphql:Error` if
        // the `scope` is not found in the context.
        value:Cloneable|isolated object {} scope = check context.get("scope");

        // The profile information will be returned only if the scope is `admin`.
        if scope is string && scope == "admin" {
            return self.profile;
        }

        // Return an `error` if the required scope is not found.
        return error("Permission denied");
    }
}
