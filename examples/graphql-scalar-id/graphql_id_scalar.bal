import ballerina/graphql;

service /graphql on new graphql:Listener(9090) {
    private User[] users = [
        {id: 1, name: "Walter White", age: 57},
        {id: 2, name: "Jesse Pinkman", age: 28}
    ];

    isolated resource function get user(@graphql:ID int userId) returns User {
        return self.users.filter(user => user.id == userId)[0];
    }
}

public type User record {|
    @graphql:ID
    int id;
    string name;
    int age;
|};
