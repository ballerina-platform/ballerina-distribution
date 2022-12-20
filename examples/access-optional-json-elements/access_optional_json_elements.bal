import ballerina/io;

public function main() returns error? {
   json user = {
      name: {
         firstName: "John",
         lastname: "Smith"
      },
      age: 24
   };

   string? address = check user?.address;

   if address is string {
      io:println("Address: " + address);
   }

   string? lastName = check user?.name?.firstName;

   if lastName is string {
      io:println("Last name: " + lastName);
   }
}
