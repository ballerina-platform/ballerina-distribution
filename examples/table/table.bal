import ballerina/io;
 
type Employee record {|
   	// The key must be read-only.
   	readonly string name;
   	int salary;
|};
 
public function main() {
   	// Creates a `table` with members of the `Employee` type in which each
   	// member is uniquely identified using their `name` field.
   	table<Employee> key(name) employees = table [
   	    { name: "John", salary: 100 },
   	    { name: "Jane", salary: 200 }
   	];
	
   	// Since the key is already available, `put` method updates the entry with new `salary`
   	// If the key is not available `put` will function same as `add`
   	employees.put({name: "John", salary: 320});
   	io:println(employees);
	
   	// As the key is not available, the `add` method appends the new entry.
   	// If the key is available, the operation results in a panic.
   	employees.add({name: "Sam", salary: 150});
   	io:println(employees);
	
   	// Retrieves the `Employee` member with `"Fred"` as the value of the key.
   	Employee? e = employees["Fred"];
   	io:println(e is ());
	
   	// Iterates over the rows of `employees` in the specified order.
   	foreach Employee employee in employees {
   	    employee.salary += 102;
   	}
   	_ = employees.remove("John");
	
   	io:println(employees);
}
