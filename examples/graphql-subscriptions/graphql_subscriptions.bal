import ballerina/graphql;
import ballerina/lang.runtime;
import ballerina/random;

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}
service /graphql on new graphql:Listener(9090) {

    private final readonly & string[] names = ["Walter White", "Jesse Pinkman", "Saul Goodman"];

    resource function get names() returns string[] {
        return self.names;
    }

    // A resource method with the `subscribe` accessor represents a field in the root
    // `Subscription` operation. It must always return a stream. Since the stream is of type
    // `string`, the resulting field in the generated GraphQL schema will be of type `String!`.
    resource function subscribe names() returns stream<string, error?> {
        // Create a `NameGenerator` object.
        NameGenerator nameGenerator = new (self.names);
        // Create a stream using the `NameGenerator` object.
        stream<string, error?> names = new (nameGenerator);
        return names;
    }
}

// Defines a stream implementor that can be used to create a stream of strings. This will pick a random name from
// the list of names and return it with a delay to demonstrate a stream of values.
class NameGenerator {
    private final string[] names;

    isolated function init(string[] names) {
        self.names = names;
    }

    // The `next` method picks a random name from the list and returns it.
    public isolated function next() returns record {|string value;|}|error? {
        // Sleep for 1 second to simulate a delay.
        runtime:sleep(1);
        int index = check random:createIntInRange(0, self.names.length());
        return {value: self.names[index]};
    }
}
