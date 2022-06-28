import ballerina/io;

// n must not be 0.
function divide(int m, int n) returns int {

    if n == 0 {
        // Panic if n is 0.
        panic error("division by 0");

    }
    return m / n;
}

public function main() {
    
    // Since divide(1, 0) panics, but due to the trap expression program will not terminate here.
    int|error x = trap divide(1, 0);

    if x is error {
        io:println(x);
    }
    
    int y = divide(1, 0);

    // Since divide(1, 0) panics, the program will terminate and the following code will not be
    // executed.
    io:println(y);

}
