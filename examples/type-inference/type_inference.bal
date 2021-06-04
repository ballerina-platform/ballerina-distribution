import ballerina/io;

//`var` says that type of variable from type of expression
// used to initialize it.
var x = "str";

function printLines(string[] sv) {
    // Type inference with `foreach` statement
    foreach var s in sv {
        io:println(s);
    }

}

public function main() {
    string[] s = [x, x];
    printLines(s);

    // Infers `x` as type `MyClass`.
    var x = new MyClass();

    // Infers class for `new` as `MyClass`.
    MyClass y = new;

}

class MyClass {
    function foo() {

    }
}
