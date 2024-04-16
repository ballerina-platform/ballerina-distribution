import ballerina/graphql;
import ballerina/random;
import ballerina/lang.runtime;

service /graphql on new graphql:Listener(9090) {

    resource function get greeting() returns string {
        return "Hello, World!";
    }

    // A resource method with the `subscribe` accessor represents a field in the root
    // `Subscription` operation. It must always return a stream. Since the stream is of type
    // `string`, the resulting field in the generated GraphQL schema will be of type `String!`.
    resource function subscribe names() returns stream<string, error?> {
        NameGenerator nameGenerator = new;
        stream<string, error?> names = new (nameGenerator);
        return names;
    }
}

// Defines a stream generator class that generates random names.
class NameGenerator {
    private final readonly & string[] names = ["Walter White", "Jesse Pinkman", "Saul Goodman"];

    // Function that picks a random name from the list and returns it.
    public isolated function next() returns record {|string value;|}|error? {
        // Sleep for 1 second to simulate a delay.
        runtime:sleep(1);
        int index = check random:createIntInRange(0, self.names.length());
        return {value: self.names[index]};
    }
}
