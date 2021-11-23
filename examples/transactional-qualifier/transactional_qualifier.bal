import ballerina/io;

type Update record {
    int updateIndex;
    int stockMnt;
};

public function main() returns error? {
    Update updates = {updateIndex: 0, stockMnt: 100};
    transaction {
        check doUpdate(updates);
        check commit;
    }
    return;
}

// Called within the transaction statement.
transactional function doUpdate(Update u) returns error? {
    // Calls the `foo()` non-transactional function.
    foo(u);
    // Calls the `bar()` transactional function.
    bar(u);
    return;
}

function foo(Update u) {
    if transactional {
        // This is a transactional context.
        bar(u);

    }
}

transactional function bar(Update u) {
    io:println("Calling from a transactional context");
}
