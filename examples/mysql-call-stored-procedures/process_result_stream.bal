stream<record {}, error?>? resultStream = result.queryResult;
if resultStream !is () {
    _ = check from var student in resultStream
        do {
            io:println(`Student: ${student}`);
        };
}
