import ballerina/io;

// A variable of type `any` can hold any value except an `error` value.
any x = 1;

public function main() {
    // Can cast `any` to specific type.
    int n = <int>x;
    
    io:println(n);

    // The `lang.value` lang library contains functions that apply to multiple basic types.
    // `x.toString()` converts `x` to a `string`.
    string s = x.toString();

    io:println(s == "1");

    // Can test its type with the `is` operator.
    float f = x is int|float ? <float>x : 0.0;

    io:println(f);
}
