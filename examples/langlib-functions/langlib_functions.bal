import ballerina/io;

public function main() returns error? {
    // You can call langlib functions using the method-call syntax.
    string str = "abc".substring(1, 2);

    // `len` will be 1.
    int len = str.length();
    io:println(len);

    // `str.length()` is same as `string:length(str)`.
    len = string:length(str);
    io:println(len);

    int val = 123;
    // lang.value module provides functions that work on values of more than one basic type.
    // val.toString() performs a direct conversion of a val to a string
    io:println("value is " + val.toString());

    // val.ensureType() safely casts a value to a type and
    // returns an error if the cast is impossible.
    float|error floatVal = val.ensureType(float);
    io:println(floatVal);

    int[] evenNumbers = [2, 4, 6 ,8, 10, 12];

    // value.clone() returns a clone of a value.
    int[] clonedEvenNumbers = [2, 4, 6 ,8, 10, 12].clone();
    // following statement is `true`.
    io:println(evenNumbers == clonedEvenNumbers);
    //following statement is `false`.
    io:println(evenNumbers === clonedEvenNumbers);

    // value.cloneReadOnly() returns a clone of a value that is read-only.
    int[] & readonly immutableEvenNumbers = evenNumbers.cloneReadOnly();
    io:println(immutableEvenNumbers);

    // value.cloneWithType() constructs a value with a specified type by cloning another value.
    float clonedVal = check val.cloneWithType(float);
    // following statement is `true`.
    io:println(clonedVal);
}
