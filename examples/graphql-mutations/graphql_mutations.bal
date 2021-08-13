import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // Define a `Person` object in the service.
    private Person person;

    function init() {
        // Initialize the `person` value.
        self.person = new("Walter White", 51);

    }

    // A resource function represents a field in the root `Query` operation.
    resource function get profile() returns Person {

        return self.person;
    }

    // A remote function represents a field in the root `Mutation` operation.
    // After updating the name, the `person` object will be returned.
    remote function updateName(string name) returns Person {

        self.person.setName(name);
        return self.person;
    }

    // Remote function to update the age.
    remote function updateAge(int age) returns Person {

        self.person.setAge(age);
        return self.person;
    }
}

// Define a service class to use as an object in the GraphQL service.
public service class Person {

    private string name;
    private int age;

    function init(string name, int age) {
        self.name = name;
        self.age = age;
    }

    resource function get name() returns string {
        return self.name;
    }
    resource function get age() returns int {
        return self.age;
    }
    resource function get isAdult() returns boolean {
        return self.age > 21;
    }

    function setName(string name) {
        self.name = name;
    }
    function setAge(int age) {
        self.age = age;
    }
}
