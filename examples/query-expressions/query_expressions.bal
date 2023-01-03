import ballerina/io;
 
public function main() {
    int[] nums = [1, 2, 3, 4];
 
    // The `from` clause works similar to a `foreach` statement.
    int[] numsTimes10 = from var i in nums
                        // The `select` clause is evaluated for each iteration.
                        select i * 10;
    io:println(numsTimes10);
 
    // Where clause can be used to filter iterable values.
    // It can occur multiple times anywhere between the from and the select clause.
    // This will pass the frame to the select clause only if `i % 2 == 0` is true.
    int[] evenNums = from int i in nums
                     where i % 2 == 0
                     select i;
    io:println(evenNums);
 
    // The `order by` clause can be used to sort the result in 
    // `ascending` or `descending` way.
    int[] numsReversed = from int i in nums
                         order by i descending
                         select i;
    io:println(numsReversed);
 
    // Iterating a string value using the query expression.
    string languageName = "Ballerina";
    string newName = from var char in languageName
                     select char + char;
 
    io:println(newName);
}
