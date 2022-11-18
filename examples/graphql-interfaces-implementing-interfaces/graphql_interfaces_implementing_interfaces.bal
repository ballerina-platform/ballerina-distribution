import ballerina/graphql;

// Define the `Animal` interface using a `distinct` `service` object.
type Animal distinct service object {

    // Define the `name` field as a resource function definition.
    resource function get name() returns string;
};

// Define another `Mammal` interface, which implements the `Animal` interface.
type Mammal distinct service object {

    // This denotes that this interface implements the `Animal` interface.
    *Animal;

    // Add an additional field to the `Mammal` interface.
    resource function get call() returns string;
};

// Define the `Leopard` class implementing the `Mammal` interface.
distinct service class Leopard {

    // This denotes that this object implements the `Mammal` interface.
    *Mammal;

    // Since this object implements the `Mammal` interface and the `Mammal` interface implements
    // the `Animal` interface, this object must implement the fields from both interfaces.
    resource function get name() returns string {
        return "Panthera pardus kotiya";
    }

    // Implement the `call` field from the `Mammal` interface.
    resource function get call() returns string {
        return "Growl";
    }

    // Add an additional `location` field to the `Leopard` class.
    resource function get location() returns string {
        return "Wilpaththu";
    }
}

// Another class implementing the `Mammal` class.
distinct service class Elephant {
    *Mammal;

    resource function get name() returns string {
        return "Elephas maximus maximus";
    }

    resource function get call() returns string {
        return "Trumpet";
    }
}

service /graphql on new graphql:Listener(4000) {

    // Returning the `Animal` type from a GraphQL resolver will identify it as an interface.
    resource function get animals() returns Animal[] {
        return [new Leopard(), new Elephant()];
    }
}
