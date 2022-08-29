import ballerina/io;

public function main() returns error? {
    string|int s1 =  "Ballerina";
    // `lang.value:ensureType()` is a  is a dependently-typed function.
    // The return type of `ensureType` function is dependent on the
    // value of the parameter, which is `string` type descriptor here.
    string s2 = check s1.ensureType(string);
    io:println(s2);

    json j = 12.5d;
    // `ensureType()` function is called on `j`, and it returns a `float` value which is
    // assigned to `f`, which is of the `float` type.  This happens because the function parameter
    // `t` of `ensureType` has a default value of `<>` which causes the compiler to infer the
    // argument for `t` from the function call context.
    float f = check j.ensureType();
    io:println(f);
}
