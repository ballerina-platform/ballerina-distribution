import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    # Returns a person using the provided ID.
    # + id - The ID of the person
    # + return - The person with the requested ID
    resource function get profile(int id) returns Person? {
        if id == 1 {
            return {name: "Walter White", age: 52};
        } else if id == 2 {
            return {name: "Jesse Pinkman", age: 25};
        }
        return;
    }
}

# Represents a person.
# + name - The name of the person
# + age - The age of the person
type Person record {
    string name;
    int age;
};
