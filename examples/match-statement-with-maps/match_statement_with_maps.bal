import ballerina/io;
 
function execute(json j) {
   	match j {
   	    // A `match` statement can be used to match maps.
   	    // Patterns on the left hand side in a match statement can have variable
   	    // parts that can be captured.
   	    {command: "print", amount: var x} => {
   	        if x is int {
   	            io:println("Int: ", x);
   	        }
   	    }
	
   	    _ => {
   	        io:println("invalid command");
   	    }
   	}
}
 
public function main() {
   	execute({command: "print", amount: 100, status: "pending"});
   	execute({command: "print", amount: 10});
   	execute({command: "subtract", amount: 100});
}
