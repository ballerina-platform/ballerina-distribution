import ballerina/io;

// You can define the return value expression using the => notation instead of using
// curly braces to define the function body block, whenevere the function body is just
// a return statement with an expression.
function inc1(int x) returns int => x + 1;

// inc2(int x) is the same as inc1(int x)
function inc2(int x) returns int {
    return x + 1;
}

var obj = object {
    private int x = 1;

    function getX() returns int => self.x;
};

function hypot(float x) returns float =>
    let float x2 = x * x in float:sqrt(x2 + x2);

public function main() {
    int x = 2;
    io:println(inc1(x));
    io:println(inc2(x));
    
    io:println(obj.getX());

    io:println(hypot(1.5));
}
