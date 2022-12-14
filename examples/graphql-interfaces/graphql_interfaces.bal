import ballerina/graphql;

// Define the interface `Profile` using a `distinct` `service` object.
type Profile distinct service object {

    // Define the field `name` as a resource method definition.
    resource function get name() returns string;
};

// Define the `Teacher` class implementing the `Profile` interface.
distinct service class Teacher {
    // This denotes that this object implements the `Profile` interface.
    *Profile;

    private final string name;
    private final string subject;

    function init(string name, string subject) {
        self.name = name;
        self.subject = subject;
    }

    // Since this object implements the `Profile` interface, this object must implement the fields
    // of the `Profile` interface.
    resource function get name() returns string {
        return self.name;
    }

    // Add an additional field `subject` to the `Teacher` class.
    resource function get subject() returns string {
        return self.subject;
    }
}

// Another class implementing the `Profile` interface.
distinct service class Student {
    *Profile;

    private final string name;

    function init(string name) {
        self.name = name;
    }

    resource function get name() returns string {
        return "Jesse Pinkman";
    }
}

service /graphql on new graphql:Listener(9090) {

    // Returning the `Profile[]` type from a GraphQL resolver will identify it as an interface.
    resource function get profiles() returns Profile[] {
        return [new Teacher("Walter White", "Chemistry"), new Student("Jesse Pinkman")];
    }
}
