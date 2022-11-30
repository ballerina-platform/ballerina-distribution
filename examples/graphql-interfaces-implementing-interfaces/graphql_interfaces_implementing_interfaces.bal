import ballerina/graphql;

// Define the `Profile` interface using a `distinct` `service` object.
type Profile distinct service object {

    // Define the `name` field as a resource method definition.
    resource function get name() returns string;
};

// Define another `Teacher` interface, which implements the `Profile` interface.
type Teacher distinct service object {

    // This denotes that this interface implements the `Profile` interface.
    *Profile;

    // Add an additional field to the `Teacher` interface.
    resource function get school() returns string;
};

// Define the `HighSchoolTeacher` class implementing the `Teacher` interface.
distinct service class HighSchoolTeacher {
    // This denotes that this object implements the `Teacher` interface.
    *Teacher;

    private final string name;
    private final string school;
    private final string subject;

    function init(string name, string school, string subject) {
        self.name = name;
        self.school = school;
        self.subject = subject;
    }

    // Since this object implements the `Teacher` interface and the `Teacher` interface implements
    // the `Profile` interface, this object must implement the fields from both interfaces.
    // Implement the `name` field from the `Profile` interface.
    resource function get name() returns string {
        return self.name;
    }

    // Implement the `school` field from the `Teacher` interface.
    resource function get school() returns string {
        return self.school;
    }

    // Add an additional `subject` field to the `HighSchoolTeacher` class.
    resource function get subject() returns string {
        return self.subject;
    }
}

service /graphql on new graphql:Listener(9090) {

    // Returning the `Profile` type from a GraphQL resolver will identify it as an interface.
    resource function get profile() returns Profile {
        return new HighSchoolTeacher("Walter White", "J. P. Wynne", "Chemistry");
    }
}
