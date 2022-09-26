import ballerina/io;

// You can define the body of a function using the `=>` notation followed by the return value expression
// instead of using curly braces to define the function body block when the function body is just
// a return statement with an expression.
function inc1(int x) returns int => x + 1;

// `inc2` is effectively same as` inc1`.
function inc2(int x) returns int {
    return x + 1;
}

var obj = object {
    private int x = 1;
    // This can also be used to define the body of a method.
    function getX() returns int => self.x;
};

// Let expressions allows you to do more with an expression
// Here 'let' allows to use a temporary variable to be used in the expression.
function hypot(float x) returns float =>
    let float x2 = x * x in float:sqrt(x2 + x2);

public function main() {
    int x = 2;
    io:println(inc1(x));
    io:println(inc2(x));
    
    io:println(obj.getX());

    io:println(hypot(1.5));
}
