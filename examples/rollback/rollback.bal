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
    // If an error is returned from the `transfer` function,
    // the error is returned from the `main` and it exits.
    check transfer(updates);

    return;
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
