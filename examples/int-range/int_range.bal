import ballerina/io;

public function main() {
    int[] loop1 = [];
    // Below int:range gives a range of integers from 0 to 5 (excluding) with a distance of 2
    // between each integer (i.e. 0, 2, 4)
    foreach int i in int:range(0, 5, 2) {
        loop1.push(i)
    }

    io:println(loop1);

    int[] loop2 = [];
    // We can also use a negative step to get a descending set of integers (i.e. 5, 3, 1)
    foreach int i in int:range(5, 0, -2) {
        loop2.push(i)
    }

    io:println(loop2);
}
