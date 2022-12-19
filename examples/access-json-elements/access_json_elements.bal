import ballerina/io;
import ballerina/lang.value;
 
public function main() returns error? {
    json[] users = [
        {
            user: {
                name: {
                    firstName: "John",
                    lastname: "Smith"
                },
                age: 24
            }
        },
        null
    ];

    // Field access is allowed on the `json` typed variable. However, the return
    // type would be a union of `json` and `error`.
    json firstUserName = check users[0].user.name;
    
    // This is converted to `check value:ensureType(firstUserName.firstName, string)`.
    // Since the expected type is correct the conversion is successful.
    string firstName = check firstUserName.firstName;
    io:println("Value of first name: " + firstName);
    
    // This is same as above.
    firstName = check value:ensureType(firstUserName.firstName, string);
    io:println("Value of first name: " + firstName);
}
