import ballerina/io;

public function main() {
    int[] a = [1];
    int[1] b = [1];
    // Output will be `true` since the values are the same
    io:println(a == b);
    // Output will be `false` since the references are different
    io:println(a === b);
    // Output will be `true` since the references are the same
    io:println(a === a);

    string[3][2] orderItems = [["carrot", "apple"], ["avacado", "egg"], ["fish", "banana"]];
    string[3][2] orderItems2 = [["carrot", "apple"], ["avacado", "egg"], ["fish", "banana"]];
    // Output will be `true` since order items are the same
    io:println(orderItems == orderItems2);
    // Output will be `false` since order items are the same
    io:println(orderItems != orderItems2);
    // Output will be `true` since the references are different
    io:println(orderItems !== orderItems2);

    string[3][2] orderItems3 = [["avacado", "egg"], ["carrot", "apple"], ["fish", "banana"]];
    // Output will be `false` since order of the items are different
    io:println(orderItems == orderItems3);
}
