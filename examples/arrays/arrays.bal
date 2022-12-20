import ballerina/io;
 
const LENGTH = 3;
 
public function main() {
    // Declare an int array of length 3.
    int[3] numbers = [1, 2, 3];
    io:println(numbers);
 
    // Using a constant reference as the array length.
    string[LENGTH] animals = ["cat", "dog", "mouse"];
    io:println(animals);
 
    // Declare a variable length array.
    int[] indexes = [1, 2];
    indexes = [1, 2, 3, 4];
    io:println(indexes);
 
    // Length of the array can be inferred using `*`. Bellow sample will declare an array of length 3.
    string[*] colors = ["red", "green", "blue"];
    io:println(colors);
 
    // Elements of an array can be accessed using member access expression.
    string firstColor = colors[0];
    io:println(firstColor);
 
    // Members of an array can be updated using member access expression in LHS of a assignment
    colors[0] = "pink";
    io:println(colors);
 
    string[] names = ["Mike", "Amy", "Korina"];
    // New members can be pushed to an open array by using `array:push()` method
    names.push("Peter");
    io:println(names);
 
    int length = names.length();
    // `array:length()` method can be used to get the length of an array
    io:println(length);
 
    // An element can be removed using `array:remove(n)` method by passing the index
    string secondPerson = names.remove(1);
    io:println(secondPerson);
    io:println(names.length());
 
    string[] fullNames = [];
    // Array can be iterated using foreach statement.
    // There are other ways like query expression for the same purpose
    // This will iterate over `names` array and create a new array by adding surnames to each name
    foreach string name in names {
        fullNames.push(string `${name} Johnson`);
    }
    io:println(fullNames);
}
