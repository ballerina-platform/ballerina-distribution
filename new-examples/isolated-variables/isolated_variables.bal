import ballerina/io;

// Initializes an `isolated` variable using
// an `isolated` expression.
isolated int[] stack = [];

isolated function push(int n) {
    // Accesses `isolated` variable within a
    // `lock` statement.
    lock {
        stack.push(n);
    }

}

isolated function pop() returns int {
    lock {
        return stack.pop();
    }
}

public function main() {
    push(10);
    push(20);
    io:println(pop());
}
