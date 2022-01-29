import ballerina/io;

type Update record {
    int updateIndex;
    int stockMnt;
};

public function main() returns error? {
    Update newUpdate = {
        updateIndex: 132,
        stockMnt: 3500
    };
    transaction {
        check exec(newUpdate);
        check commit;
    }
}

// `transactional` function can only be called from a `transactional` context
transactional function exec(Update u) returns error? {
    // `transactional` named workers starts a transaction branch
    // in the current transaction.
    transactional worker A {
        bar();
    }
}

transactional function bar() {
    io:println("bar() invoked");
}
