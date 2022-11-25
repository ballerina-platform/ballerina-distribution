import ballerina/graphql;

// Define the interface `Animal` using a `distinct` `service` object.
type Animal distinct service object {

    // Define the field `name` as a resource method definition.
    resource function get name() returns string;
};

// Define the `Leopard` class implementing the `Animal` interface.
distinct service class Leopard {

    // This denotes that this object implements the `Animal` interface.
    *Animal;

    // Since this object implements the `Animal` interface, this object must implement the fields of
    // the `Animal` interface.
    resource function get name() returns string {
        return "Panthera pardus kotiya";
    }

    // Add an additional field `location` to the `Leopard` class
    resource function get location() returns string {
        return "Wilpaththu";
    }
}

// Another class implementing the `Animal` interface.
distinct service class Elephant {
    *Animal;

    resource function get name() returns string {
        return "Elephas maximus maximus";
    }
}

service /graphql on new graphql:Listener(9090) {

    // Returning the `Animal` type from a GraphQL resolver will identify it as an interface.
    resource function get animals() returns Animal[] {
        return [new Leopard(), new Elephant()];
    }
}
