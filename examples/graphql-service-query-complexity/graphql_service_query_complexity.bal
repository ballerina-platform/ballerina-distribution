import ballerina/graphql;

// Defines a service class to use as an object in the GraphQL service.
service class Profile {
    private final string name;
    private final int age;

    function init(string name, int age) {
        self.name = name;
        self.age = age;
    }

    @graphql:ResourceConfig {
        complexity: 1
    }
    resource function get name() returns string {
        return self.name;
    }

    @graphql:ResourceConfig {
        complexity: 10
    }
    resource function get age() returns int {
        return self.age;
    }

    // Default complexity will be applied
    resource function get isAdult() returns boolean {
        return self.age > 21;
    }
}

@graphql:ServiceConfig {
    // The queryComplexityConfig is used to define the values for the maximum query complexity,
    // default field complexity, and whether to return an error or warning when the maximum
    // complexity is exceeded.
    queryComplexityConfig: {
        maxComplexity: 50, // Maximum complexity allowed for a query
        defaultFieldComplexity: 2 // Default complexity for a field
    }
}
service graphql:Service /graphql on new graphql:Listener(9090) {

    @graphql:ResourceConfig {
        complexity: 20
    }
    resource function get profile(@graphql:ID int id) returns Profile {
        // Return a dummy profile object
        return new ("Walter White", 50);
    }
}
