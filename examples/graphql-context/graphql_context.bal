import ballerina/graphql;
import ballerina/http;
import ballerina/lang.value;

// Define a service class to use as an object in the GraphQL service.
type Person record {|
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
service /graphql on new graphql:Listener(4000) {

    // Define a `Person` object when the service is initialized.
    private final Person person;

    function init() {
        // Initialize the `person` value.
        self.person = {name: "Walter White", age: 51, salary: 737000.00};
    }

    // If the context is needed, it should be defined as the first parameter of the resolver
    // function.
    resource function get profile(graphql:Context context) returns Person|error {
        // Retrieve the `scope` attribute from the context. This will return a `graphql:Error` if
        // the `scope` is not found in the context.
        value:Cloneable|isolated object {} scope = check context.get("scope");

        // The profile information will be returned for the scope of either `admin` or `user`.
        if scope is string && scope == "admin" {
            return self.person;
        }

        // Return an `error` if the required scope is not found.
        return error("Permission denied");
    }
}
