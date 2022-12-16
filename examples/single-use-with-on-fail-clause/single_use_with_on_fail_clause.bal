import ballerina/io;

public function main() {
   do {
       _ = check int:fromString("Hello");
       // A typed capture binding pattern is used with an `on fail` clause.
       // It matches with the associated error value in the clause, and binds the value
       // to the `err` variable.
   } on fail error err {
       io:println(err.message());
   }
}
