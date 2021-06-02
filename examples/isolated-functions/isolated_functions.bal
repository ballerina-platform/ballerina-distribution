import ballerina/io;

type R record {
    int v;
};

final int N = getN();

function getN() returns int {
    return 100;
}

// Can access mutable state that is passed as a parameter.
isolated function set(R r) returns R {
    // Can access non-`isolated` module-level state only if the variable
    // is `final` and the type is a subtype of `readonly` or
    // `isolated object {}`.
    r.v = N;

    return r;
}

R r = {v: 0};

// This is not an `isolated` function.
function setGlobal(int n) {

    r.v = n;
}

public function main() {
    setGlobal(200);
    io:println(r);
    io:println(set(r));
}
