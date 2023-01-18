import ballerina/io;

public function main() {
    // Declare an array of length 3, where the members are arrays of length 2.
    string[3][2] orderItems = [["carrot", "apple"], ["avocado", "egg"], ["fish", "banana"]];
    io:println(orderItems);

    // Declare an array of length 2, where the element type is an array of variable length.
    string[2][] orderItems2 = [["carrot", "apple"], ["avocado", "egg", "fish", "banana"]];
    io:println(orderItems2);

    // Inferring supported only for the first dimension of the array type descriptor
    string[*][] orderItems3 = [["carrot", "apple"], ["avocado", "egg", "fish", "banana"]];
    io:println(orderItems3);

    // Accessing a nested array.
    // This will access first item of the third order.
    string item = orderItems3[1][0];
    io:println(item);

    // Updating a nested array.
    // This will update first item of the third order.
    orderItems3[1][0] = "apple";
    io:println(orderItems3);
}
