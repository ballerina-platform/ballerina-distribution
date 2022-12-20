import ballerina/io;
 
public function main() {
    // Since the filler value for int is `0`,
    // `severity` array will be initialized as [0, 0, 0].
    int[3] severity = [];
    io:println(severity);
 
    // Since filler value for `boolean` is `false` and rest type can contain no members
    // `scores` will be initialized as `[false]`.
    [boolean, int...] scores = [];
    io:println(scores);
 
    // Since the filler value for string is `""`,
    // `names` array will be initialized as ["John", "Mike", ""].
    string[3] names = ["John", "Mike"];
    io:println(names);
 
    // Since the filler value for list is empty list,
    // `orderItems` tuple will be initialized as `[["carrot", "apple"], ["avacado", "egg"], ["", ""]]``.
    string[3][2] orderItems = [["carrot", "apple"], ["avocado", "egg"]];
    io:println(orderItems);
}
