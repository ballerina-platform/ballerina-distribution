import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // Define a `string` array in the service.
    private string[] names;

    function init() {
        // Initialize the array.
        self.names = ["Walter White", "Jesse Pinkman", "Skyler White"];

    }

    // The mandatory resource function with the `get` accessor represents a field in the root `Query` operation.
    resource function get names() returns string[] {

        return self.names;
    }
    
    // A resource function with the `subscribe` accessor represents a field in the root `Subscription` operation.
    // It must always return a stream. And each name will be returned in the `string` type as GraphQL responses.
    resource function subscribe names() returns stream<string, error?> {
        
        return self.names.toStream();
    
    }
}
