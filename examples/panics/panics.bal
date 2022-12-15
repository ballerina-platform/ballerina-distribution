import ballerina/io;
 
// `n` must not be `0`
function divide(int m, int n) returns int {
    if n == 0 {
        // Panic if `n` is `0`.
        panic error("division by 0");
    }
    return m / n;
}
 
public function main() {
    int y = divide(1, 0);
    // if `divide(1, 0)` panics, the program will terminate.
    io:println(y);
}
