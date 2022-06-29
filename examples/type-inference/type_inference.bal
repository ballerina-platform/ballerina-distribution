import ballerina/io;

//`var` says that the type of the variable is from the type of expression used to initialize it.
var x = "str";

function printLines(string[] sv) {
    // Type inference with a `foreach` statement.
    foreach var s in sv {
        io:println(s);
    }

}

public function main() {
    string[] s = [x, x];
    printLines(s);

    // Infers `x`'s type as `MyClass`.
    var x = new MyClass();
    MyClass _ = x;

    // Infers the class for `new` as `MyClass`.
    MyClass _ = new;

}

class MyClass {
    function foo() {

    }
}
