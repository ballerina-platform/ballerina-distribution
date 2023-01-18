import ballerina/io;
 
public function main() {
    // Declare a tuple of length 3 where the type of each members are `string`, `int`, `boolean` respectively.
    [string, int, boolean] person = ["Mike", 24, false];
    io:println(person);
 
    // Tuple with member type descriptors of same type is equivalent to array with a length.
    // This is equivalent to `int[3]``.
    [int, int, int] numbers = [1, 2, 3];
    io:println(numbers);
 
    // Members of a tuple can be accessed using member access expression.
    int age = person[1];
    io:println(age);
 
    // Members of a tuple can be updated using member access expression in LHS of a assignment
    person[1] = 25;
    io:println(person);
 
    int length = person.length();
    // `array:length()` method can be used to get the length of a tuple
    io:println(length);
 
    // Tuples can be used to return multiple values from a function.
    var personDetails = getPersonDetails();
    io:println(personDetails);
}
 
function getPersonDetails() returns [int, boolean] {
    return [30, true];
}
