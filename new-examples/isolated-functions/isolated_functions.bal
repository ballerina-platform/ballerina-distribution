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

// This is not `isolated`.
function setGlobal(int n) {
    r.v = n;
}

// The initialization expression of an `isolated` variable
// has to be an isolated expression, which itself will be
// an isolated root.
isolated R r2 = {v: 0};

isolated function setGlobalIsolated(int n) {
    // An `isolated` variable can be accessed within
    // a `lock` statement.
    lock {
        r2.v = n;
    }
}

public function main() {
    setGlobal(200);
    io:println(r);

    setGlobalIsolated(200);
    // Accesses the `isolated` variable within a
    // `lock` statement.
    lock {
       io:println(r2);
    }

    io:println(set(r));
}
