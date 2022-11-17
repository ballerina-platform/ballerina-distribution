import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {
    // Marking a field as deprecated.
    # # Deprecated
    # The `person` field is deprecated. Use `profile` instead.
    @deprecated
    resource function get person() returns Person {
        return person;
    }

    resource function get profile() returns Person {
        return person;
    }
}

public type Person record {
    string name;
    int age;
    Gender gender;
    Address address;
};

public type Address record {
    string number;
    string street;
    string city;
};

// Marking enum value as deprecated.
public enum Gender {
    MALE,
    FEMALE,
    # # Deprecated
    # The `NON_BINARY` is deprecated. Use `OTHER` instead.
    @deprecated
    NON_BINARY,
    OTHER
}

Person person = {
    name: "Walter White",
    age: 51,
    gender: MALE,
    address: {
        number: "308",
        street: "Negra Arroyo Lane",
        city: "Albuquerque"
    }
};
