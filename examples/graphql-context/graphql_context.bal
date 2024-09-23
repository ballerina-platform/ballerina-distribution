import ballerina/graphql;
import ballerina/http;
import ballerina/lang.value;

@graphql:ServiceConfig {
    // Initialization of the `graphqlContext` should be provided to the `contextInit` field.
    contextInit
}
service /graphql on new graphql:Listener(9090) {
    // Defines a `Profile` field inside the service.
    private final Profile profile;

    function init() {
        // Initializes the `profile` value.
        self.profile = new ("Walter White", 51, 737000.00);
    }

    // If the context is needed, it should be defined as a parameter of the resolver function.
    resource function get profile(graphql:Context context) returns Profile|error {
        // The profile information will be returned only if the scope is `admin` or `user`.
        check validateScope(context, ["admin", "user"]);
        return self.profile;
    }
}

// Defines a service class to use as an object in the GraphQL service.
service class Profile {
    private final string name;
    private final int age;
    private final float salary;

    function init(string name, int age, float salary) {
        self.name = name;
        self.age = age;
        self.salary = salary;
    }

    resource function get name() returns string => self.name;

    resource function get age() returns int => self.age;

    // If the context is needed, it should be defined as a parameter of the resolver function.
    // There is no need to pass the context via the `init` method from the parent resolver.
    resource function get salary(graphql:Context context) returns float|error {
        // The salary information will be returned only if the scope is `admin`.
        check validateScope(context, ["admin"]);
        return self.salary;
    }
}

isolated function validateScope(graphql:Context context, string[] allowedScopes) returns error? {
    // Retrieves the `scope` attribute from the context. This will return a `graphql:Error` if
    // the `scope` is not found in the context.
    value:Cloneable|isolated object {} scopeValue = check context.get("scope");
    // Ensure that the obtained scope is a string value.
    final string scope = check scopeValue.ensureType();
    // If the scope doesn't matches any of the allowed scopes return and `error`.
    if !allowedScopes.some(allowedScope => scope == allowedScope) {
        // Returns an `error` if the required scope is not found.
        return error("Permission denied");
    }
}

isolated function contextInit(http:RequestContext requestContext, http:Request request) returns graphql:Context|error {
    // Initialize the `graphql:Context` object.
    graphql:Context context = new;

    // Retrieves the header named `scope` from the `http:request` and set it to the context with
    // the `scope` key. If the header does not exist, this will return an `error`, and thereby,
    // the request will not be processed.
    context.set("scope", check request.getHeader("scope"));

    // Finally, the context object should be returned.
    return context;
}
