import ballerina/io;

public function main() returns error? {
    int[] nums = [1, 2, 3, 4];
    int[] numsTimes10 = [];

    // The `from` clause works similar to a `foreach` statement.
    check from var i in nums
        // The `do` statement block is evaluated in each iteration.
        do {
            numsTimes10.push(i * 10);
        };

    io:println(numsTimes10);

    // Print only the even numbers in the `nums` array.
    // Intermediate clauses such as `let` clause, `join` clause, `order by` clause,
    // `where clause`, and `limit` clause can also be used.
    check from var i in nums
        where i % 2 == 0
        do {
            io:println(i);
        };
}
