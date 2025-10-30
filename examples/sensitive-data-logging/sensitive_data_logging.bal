import ballerina/log;

// Custom masking function
isolated function maskString(string input) returns string {
    if input.length() <= 2 {
        return "****";
    }
    return input.substring(0, 1) + "****" + input.substring(input.length() - 1);
}

// User record with sensitive data annotations
type User record {
    string id;
    @log:Sensitive
    string password;
    @log:Sensitive {
        strategy: {
            replacement: "****"
        }
    }
    string creditCard;
    @log:Sensitive {
        strategy: {
            replacement: maskString
        }
    }
    string ssn;
    string name;
};

public function main() returns error? {
    // Create user with sensitive information
    User user = {
        id: "U001",
        password: "mypassword",
        creditCard: "4111-1111-1111-1234",
        ssn: "123-45-6789",
        name: "John Doe"
    };

    // Log user details - sensitive fields will be masked automatically
    log:printInfo("User details", user = user);
}
