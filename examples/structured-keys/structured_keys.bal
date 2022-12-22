import ballerina/io;

type Employee record {
   readonly record {
       string first;
       string last;
   } name;
   int salary;
};

public function main() {
   //In the key field, the `name` is of the `record` type.
   table<Employee> key(name) t = table [
       {name: {first: "John", last: "Smith"}, salary: 100},
       {name: {first: "Fred", last: "Bloggs"}, salary: 200}
   ];

   Employee? e = t[{first: "Fred", last: "Bloggs"}];
   io:println(e);

   record {|string first; string last;|} n = {first: "Sam", last: "Smith"};
   // Make the key immutable using `cloneReadOnly()`.
   t.add({name: n.cloneReadOnly(), salary: 23});
   io:println(t);
}
