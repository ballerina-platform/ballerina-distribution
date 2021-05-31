import ballerina/io;

type R record {
    int v;
};

// The initialization expression of an `isolated` variable
// has to be an `isolated` expression, which itself will be
// an `isolated` root.
isolated R r = {v: 0};

isolated function setGlobal(int n) {
    // An `isolated` variable can be accessed within
    // a `lock` statement.
    lock {
        r.v = n;
    }

}

public function main() {
    setGlobal(200);
    // Accesses the `isolated` variable within a
    // `lock` statement.
    lock {
       io:println(r);
    }

}
