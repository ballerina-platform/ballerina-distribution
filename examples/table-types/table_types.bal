import ballerina/io;
 
type Employee record {|
   	readonly string name;
   	int salary;
|};
 
public function main() {
   	// Creates a `table` with members of the `Employee` type, where each
   	// member is uniquely identified using their `name` field.
   	table<Employee> key(name) t1 = table [
   	    { name: "John", salary: 100 },
   	    { name: "Jane", salary: 200 }
   	];
   	io:println(t1);
	
   	// A table can be declared without a key
   	table<Employee> t2 = table [
   	    { name: "John", salary: 100 },
   	    { name: "Jane", salary: 200 }
   	];
   	io:println(t2);
	
   	// A table can also be declared with a type parameter as key type
   	table<Employee> key<string> t3 = table key(name) [
   	    { name: "John", salary: 100 },
   	    { name: "Jane", salary: 200 }
   	];
   	io:println(t3);
}
