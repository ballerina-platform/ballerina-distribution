import ballerina/io;

public function main() {
    // Declare an array of length 3, where the members are arrays of length 2.
    string[3][2] orderItems = [["carrot", "apple"], ["avocado", "egg"], ["fish", "banana"]];
    io:println(orderItems);
    // Declare an array of length 2, where the element type is an array of variable length.
    string[2][] secondOrderItems = [["carrot", "apple"], ["avocado", "egg", "fish", "banana"]];
    io:println(secondOrderItems);

    // Accessing a nested array.
    // This will access first item of the third order.
    string item = secondOrderItems[1][0];
    io:println(item);

    // Updating a nested array.
    // This will update first item of the third order.
    secondOrderItems[1][0] = "apple";
    io:println(secondOrderItems);
}
