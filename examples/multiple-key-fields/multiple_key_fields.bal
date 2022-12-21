import ballerina/io;

type Employee record {
   readonly string firstName;
   readonly string lastName;
   int salary;
};

public function main() {
   // `employees` has a key sequence with `firstName` and `lastName` fields.
   table<Employee> key(firstName, lastName) employees = table [
       {firstName: "John", lastName: "Smith", salary: 100},
       {firstName: "John", lastName: "Bloggs", salary: 200}
   ];

   // The key sequence provides keyed access to members of the `table`.
   Employee? e = employees["John", "Bloggs"];
   io:println(e);

   // `employees` has a key sequence with `firstName` and `lastName` fields.
   table<Employee> key<[string, string]> employees2 = table key(firstName, lastName) [
       {firstName: "John", lastName: "Smith", salary: 100},
       {firstName: "John", lastName: "Bloggs", salary: 200}
   ];

   e = employees2["John", "Smith"];
   io:println(e);
}
