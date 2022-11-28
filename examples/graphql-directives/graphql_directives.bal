import ballerina/graphql;

type Person record {
    string name;
    int age;
    Gender gender;
};

// Marking enum value as deprecated.
enum Gender {
    MALE,
    FEMALE,
    # # Deprecated
    # The `NON_BINARY` is deprecated. Use `OTHER` instead.
    @deprecated
    NON_BINARY,
    OTHER
}

service /graphql on new graphql:Listener(9090) {
    // Marking a field as deprecated.
    # # Deprecated
    # The `person` field is deprecated. Use `profile` instead.
    @deprecated
    resource function get person() returns Person {
        return {
            name: "Walter White",
            age: 51,
            gender: MALE
        };
    }

    resource function get profile() returns Person {
        return {
            name: "Walter White",
            age: 51,
            gender: MALE
        };
    }
}
