import ballerina/io;

// Defines the `Update` record type.
type Update record {
    int updateIndex;
    int stockMnt;
};

public function main() returns error? {
    // Creates an array of `Update` records.
    Update[] updates =
    [
        {updateIndex: 0, stockMnt: 2000},
        {updateIndex: 1, stockMnt: -1000},
        {updateIndex: 2, stockMnt: 1500},
        {updateIndex: 3, stockMnt: -1000},
        {updateIndex: 4, stockMnt: -2000}
    ];

    io:println(transfer(updates));

    // Creates an array of employee salaries.
    int[] salaryList = [100, 200, 300, 100];

    incrementSallary(salaryList);
}

function transfer(Update[] updates) returns error? {

    transaction {
        // Inside the transaction, call `doUpdate` on each `update` record.
        foreach var u in updates {
            // If an error is returned, the `transfer` function returns with
            // that error and the transaction is rolled back.
            check doUpdate(u);

        }
        // `commit` will not be called because of an implicit rollback.
        check commit;
    }
    return;
}

function doUpdate(Update u) returns error? {
    // If the stock amount is less than -1500, an error is returned.
    if (u.stockMnt < -1500) {
        return error("Not enough Stocks: ", stockIndex = u.updateIndex);
    }

    return;
}

function incrementSallary(int[] salaryList) returns error? {
    transaction {
        foreach int index in 0 ..< salaryList.length() {
            salaryList[index] += 100;
        }

        // If the new total salary exceeds `1000`, then the rollback statement performs 
        // rollback on the transaction.
        if (salaryList.reduce(function(int total, int n) returns int => total + n, 0) > 1000) {
            io:println("Salary limit exceeded");
            rollback;
        } else {
            check commit;
        }
    }
}
