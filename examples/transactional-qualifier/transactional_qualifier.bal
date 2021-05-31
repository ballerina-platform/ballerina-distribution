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
}

// Called within transaction stmt
transactional function doUpdate(Update u) returns error? {
    // Call non-transactional function
    foo(u);
    // Call transactional function
    bar(u);
}

function foo(Update u) {
    if transactional {
        // This is transactional context
        bar(u);
    }
}

transactional function bar(Update u) {
    io:println("Calling from a transactional context");
}
