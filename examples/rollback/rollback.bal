import ballerina/io;

// Defines the `Update` record type.
type Update record {
    int updateIndex;
    int stockMnt;
};

public function main() returns error? {
    // Creates an array of `Update` records.
    Update[] updates = [
        {updateIndex: 0, stockMnt: 2000},
        {updateIndex: 1, stockMnt: -1000},
        {updateIndex: 2, stockMnt: 1500},
        {updateIndex: 3, stockMnt: -1000},
        {updateIndex: 4, stockMnt: -2000}
    ];
    // This transfer will be rolled back.
    io:println(transfer(updates));

    // Creates an array of employee salaries.
    int[] salaryList = [100, 200, 300, 100];

    // This salary increment will be rolled back.
    check incrementSalary(salaryList);

    int[] salaryList2 = [100, 200, 100, 100];

    // This salary increment will be successful.
    check incrementSalary(salaryList2);
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
    // If the stock amount is less than `-1500`, an error is returned.
    if (u.stockMnt < -1500) {
        return error("Not enough stocks: ", stockIndex = u.updateIndex);
    }

    return;
}

function incrementSalary(int[] salaryList) returns error? {
    transaction {
        foreach int index in 0 ..< salaryList.length() {
            salaryList[index] += 100;
        }

        // If the new total salary exceeds `1000`, then, the rollback statement performs 
        // rollback on the transaction.
        int salarySum = int:sum(...salaryList);
        if (salarySum > 1000) {
            io:println("Budget exceeded");
            rollback;
        } else {
            io:println("Salary increment successful");
            check commit;
        }
    }
}
