// This demonstrates different ways to mock functions.

// This function calls the `intAdd` function and returns the result.
public function addValues(int a, int b) returns int {
    return intAdd(a, b);
}

// This function adds two integers and returns the result.
public function intAdd(int a, int b) returns int {
    return (a + b);
}
