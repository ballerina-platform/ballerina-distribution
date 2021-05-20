import ballerina/io;

anydata x1 = [1, "string", true];
// `x1.clone()` returns a deep copy with the same mutability.
anydata x2 = x1.clone();

// Checks deep equality.
boolean eq = (x1 == x2);

public function main() {
    io:println(x2);
    io:println(eq);
}
