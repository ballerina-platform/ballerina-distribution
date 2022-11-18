sql:ProcedureCallResult result = check mysqlClient->call(`{CALL GetCount(${id}, ${totalCount})}`, [Student]);

stream<record {}, error?>? resultStream = result.queryResult;
if resultStream!is () {
    stream<Student, error?> studentStream = <stream<Student, error?>>resultStream;
    _ = check from Student student in studentStream
        do {
            io:println(`Student: ${student}`);
        };
}
