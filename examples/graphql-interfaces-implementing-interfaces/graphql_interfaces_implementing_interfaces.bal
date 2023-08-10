import ballerina/graphql;

// Defines the `Profile` interface using a `distinct` `service` object.
type Profile distinct service object {

    // Defines the `name` field as a resource method definition.
    resource function get name() returns string;
};

// Defines another `Teacher` interface, which implements the `Profile` interface.
type Teacher distinct service object {

    // Denotes that this interface implements the `Profile` interface.
    *Profile;

    // Adds an additional field to the `Teacher` interface.
    resource function get school() returns string;
};

// Defines the `HighSchoolTeacher` class implementing the `Teacher` interface.
distinct service class HighSchoolTeacher {
    // Denotes that this object implements the `Teacher` interface. Since this object implements
    // the `Teacher` interface and the `Teacher` interface implements the `Profile` interface, this
    // object must implement the fields from both interfaces.
    *Teacher;

    private final string name;
    private final string school;
    private final string subject;

    function init(string name, string school, string subject) {
        self.name = name;
        self.school = school;
        self.subject = subject;
    }

    // Implements the `name` field from the `Profile` interface.
    resource function get name() returns string {
        return self.name;
    }

    // Implements the `school` field from the `Teacher` interface.
    resource function get school() returns string {
        return self.school;
    }

    // Adds an additional `subject` field to the `HighSchoolTeacher` class.
    resource function get subject() returns string {
        return self.subject;
    }
}

service /graphql on new graphql:Listener(9090) {

    // Returns the `Profile` type from a GraphQL resolver. The `Profile` type is identified as an
    // interface.
    resource function get profile() returns Profile {
        return new HighSchoolTeacher("Walter White", "J. P. Wynne", "Chemistry");
    }
}
