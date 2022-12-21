import ballerina/graphql;

service class Profile {
    private final int id;
    private final string name;
    private final int age;

    function init(int id, string name, int age) {
        self.id = id;
        self.name = name;
        self.age = age;
    }

    // This resource method does not have `nil` as a possible return type, which means the
    // corresponding GraphQL field type is wrapped by GraphQL `NON_NULL` type. Therefore, if this
    // method returns an `error`, the `name` value will become `null` and since it is a `NON_NULL`
    // field, the value will be propagated to the upper level. This means the corresponding
    // `profile` field value will become `null`.
    resource function get name() returns string|error {
        if self.id == 2 {
            // return a mock error
            return error("Error occurred while retrieving name");
        }
        return self.name;
    }

    // This resource method has `nil` as a possible return type, which means the corresponding
    // GraphQL field type is nullable. Therefore, if this field returns an error, the field value
    // can be `null`. Hence, when an error returned from this method,
    resource function get age() returns int|error? {
        if self.id == 1 {
            // return a mock error
            return error("Error occurred while retrieving age");
        }
        return self.age;
    }
}

service /graphql on new graphql:Listener(9090) {

    // This resource method returns only the `Profile` type, which means the field type is wrapped
    // by GraphQL `NON_NULL` type. Therefore, if the `null` value is propagated to the `profile`
    // field, (by returning an `error` from the `name` field in the `Profile` object), it will be
    // propagated further, making the `data` field of the response `null`.
    resource function get profile(int id) returns Profile {
        return new (id, "Walter White", 50);
    }
}
