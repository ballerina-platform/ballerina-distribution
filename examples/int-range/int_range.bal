import ballerina/io;

public function main() {
    forEachWithRange(0, 5, 2);
    forEachWithRange(5, 0, -2);
}

function forEachWithRange(rangeStart, rangeEnd, step) {
    int[] loop = [];
    index = 0;
    // The integers returned by the iterator belong to the set S,where S is `{ rangeStart + step*i such that i >= 0 }`.
    // When `step > 0`, the members of S that are `< rangeEnd` are returned in increasing order.
    // When `step < 0`, the members of S that are `> rangeEnd` are returned in decreasing order.
    // When `step = 0`, the function panics.
    // `m ..< n` creates a value that when iterated over will give the integers starting from `m` that are `< n`.
    foreach int i in int:range(rangeStart, rangeEnd, step) {
        loop[index] = i;
    }

    io:println(loop);
}
