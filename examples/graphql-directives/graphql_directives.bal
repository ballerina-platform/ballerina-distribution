import ballerina/graphql;

type Profile record {
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
    # The `profile` field is deprecated. Use `profile` instead.
    @deprecated
    resource function get profileeeeeee() returns Profile {
        return {
            name: "Walter White",
            age: 51,
            gender: MALE
        };
    }

    resource function get profile() returns Profile {
        return {
            name: "Walter White",
            age: 51,
            gender: MALE
        };
    }
}
