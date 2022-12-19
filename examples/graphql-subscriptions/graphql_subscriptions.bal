import ballerina/graphql;

service /graphql on new graphql:Listener(9090) {
    // Define a `string` array in the service.
    private string[] names;

    function init() {
        // Initialize the array.
        self.names = ["Walter White", "Jesse Pinkman", "Skyler White"];
    }

    resource function get names() returns string[] {
        return self.names;
    }

    // A resource method with the `subscribe` accessor represents a field in the root
    // `Subscription` operation. It must always return a stream. Since the stream is of type
    // `string`, the resulting field in the generated GraphQL schema will be of type `String!`.
    resource function subscribe names() returns stream<string> {
        return self.names.toStream();
    }
}
