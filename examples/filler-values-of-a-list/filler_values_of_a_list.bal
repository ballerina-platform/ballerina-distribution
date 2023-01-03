import ballerina/io;
 
public function main() {
    // Since the filler value for int is `0`,
    // the `severity` array will be initialized as [0, 0, 0].
    int[3] severity = [];
    io:println(severity);
 
    // Since the filler value for `boolean` is `false` and the rest type can contain no members,
    // the `scores` will be initialized as `[false]`.
    [boolean, int...] scores = [];
    io:println(scores);
 
    // As the filler value for string is `""`,
    // the `names` array will be initialized as ["John", "Mike", ""].
    string[3] names = ["John", "Mike"];
    io:println(names);
 
    // As the filler value for the list is an empty list,
    // the `orderItems` tuple will be initialized as `[["carrot", "apple"], ["avacado", "egg"], ["", ""]]``.
    string[3][2] orderItems = [["carrot", "apple"], ["avocado", "egg"]];
    io:println(orderItems);
}
