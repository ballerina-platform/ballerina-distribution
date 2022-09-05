import ballerina/io;

type IntPair [int, int];

function assignToListBindingPattern(IntPair ip) {
    int p;
    int q;
    // The `ip` variable of the IntPair `type` is destructured and
    // assigned to the two `p` and `q` variables.
    [p, q] = ip;

    io:println(p);
    io:println(q);

    // The swapping is done between `p` and `q` by doing
    // tuple destructuring without using a temporary variable.
    [p, q] = [q, p];

    io:println(p);
    io:println(q);

    int r;
    // Destructuring can be ignored using `_`.
    [_, r] = ip;

    io:println(r);

    int a;
    int b;
    int d;
    int e;
    int[] rest;

    // Destructure a list that includes a `rest` value.
    [a, b, _, d, e, ...rest] = [...[1, 2], ...[3, 4], ...[5, 45, 345]];
    io:println(a);
    io:println(b);
    io:println(d);
    io:println(e);
    io:println(rest);
}

type FullName record {
    string firstName;
    string middleName;
    string lastName;
};

function assignToMappingBindingPattern(FullName fullName) {
    string firstName;
    string lastName;

    // The `fullName` variable of  the `FullName` type is destructured and
    // assigned to the two `firstName` and `lastName` variables.
    {firstName, lastName} = fullName;

    io:println(firstName);
    io:println(lastName);
}

public function main() {
    assignToListBindingPattern([0, 1]);
    assignToMappingBindingPattern({firstName: "Jane", middleName: "unknown", lastName: "Doe"});
}
