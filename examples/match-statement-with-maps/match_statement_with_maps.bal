import ballerina/io;

function foo(json j) returns error? {
    match j {
        // Match statement can be used to match maps.
        // Patterns on the left hand side in a match statement can have variable
        // parts that can be captured.
        // Match semantics are open (may have fields other than those 
        // specified in the pattern).
        {command: "add", amount: var x} => {
            decimal n = check x.ensureType(decimal);
            add(n);
            return;
        }

        _ => {
            return error("invalid command");
        }
    }
}

decimal total = 0;

function add(decimal amount) {
    total += amount;
    io:println("Total: ", total);
}

public function main() returns error? {
    check foo({command: "add", amount: 100, status: "pending"});
    check foo({command: "add", amount: 10});
    check foo({command: "subtract", amount: 100});
    return;
}
