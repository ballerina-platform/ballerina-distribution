import ballerina/io;

public function main() returns error? {
    json user = {
      name: {
         firstName: "John",
         lastname: "Smith"
      },
      age: 24
    };

    // Since the availability of `address` field is unknown, optional access is used
    string? address = check user?.address;

    if address is string {
      io:println("Address: " + address);
    }

    // Optional access can be used again on fields accessed with optional access
    string? lastName = check user?.name?.firstName;

    if lastName is string {
      io:println("Last name: " + lastName);
    }
}
