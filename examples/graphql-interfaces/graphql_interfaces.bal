import ballerina/graphql;

service on new graphql:Listener(4000) {

    // Returning the `Animal` type from a GraphQL resolver will idenitify it as an interface
    resource function get animals() returns Animal[] {
        return [new Leopard(), new Elephant()];
    }
}

// Define the interface `Animal` using a `distinct` `service` object
public type Animal distinct service object {

    // Define the field `name` as a resource function definition
    resource function get name() returns string;
};

// Define another interface `Mammal`, that implements `Animal` interface
public type Mammal distinct service object {

    // This denotes that this interface implements the `Animal` interface
    *Animal;

    // Add an additional field to the `Mammal` interface
    resource function get call() returns string;
};

// Define the `Leopard` class implementing the `Mammal` interface
public distinct service class Leopard {

    // This denotes that this object implements the `Mammal` interface
    *Mammal;

    // Since this object implements the `Mammal` interface and the `Mammal` interface implements the
    // `Animal` interface, this object must implement the fields from the `Animal` interface
    resource function get name() returns string {
        return "Panthera pardus kotiya";
    }

    // Implement the `call` field from the `Mammal` interface
    resource function get call() returns string {
        return "Growl";
    }

    resource function get location() returns string {
        return "Wilpaththu";
    }
}

// Another class implementing the `Mammal` class
public distinct service class Elephant {
    *Mammal;

    resource function get name() returns string {
        return "Elephas maximus maximus";
    }

    // Implement the `call` field from the `Mammal` interface
    resource function get call() returns string {
        return "Trumpet";
    }
}
