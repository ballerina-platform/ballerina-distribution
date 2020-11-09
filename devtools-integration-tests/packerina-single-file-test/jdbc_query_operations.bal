import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;

string dbUser = "root";
string dbPassword = "test123";

function simpleQuery(mysql:Client mysqlClient) {
    stream<record{}, error> resultStream = mysqlClient->query("Select * from Customers");
    error? e = resultStream.forEach(function(record {} result) {
        io:println("Customer full details: ", result);
        io:println("Customer first name: ", result["FirstName"]);
        io:println("Customer last name: ", result["LastName"]);
    });
    if (e is error) {
        io:println("ForEach operation on the stream failed!", e);
    }
}

type Customer record {|
    int customerId;
    string lastName;
    string firstName;
    int registrationId;
    float creditLimit;
    string country;
|};

function initializeTable() returns sql:Error? {
    mysql:Client mysqlClient = check new (user = dbUser, password = dbPassword);
    sql:ExecutionResult result = check mysqlClient->execute("CREATE DATABASE IF NOT EXISTS MYSQL_TEST_DB");
    result = check mysqlClient->execute("DROP TABLE IF EXISTS MYSQL_TEST_DB.Customers");
    result = check mysqlClient->execute("CREATE TABLE IF NOT EXISTS MYSQL_TEST_DB.Customers(customerId INTEGER " +
                "NOT NULL AUTO_INCREMENT, FirstName  VARCHAR(300), LastName VARCHAR(300), RegistrationID INTEGER," +
                "CreditLimit DOUBLE, Country  VARCHAR(300), PRIMARY KEY (CustomerId))");
    result = check mysqlClient->execute("INSERT INTO MYSQL_TEST_DB.Customers (FirstName,LastName,RegistrationID," +
                "CreditLimit,Country) VALUES ('Peter', 'Stuart', 1, 5000.75, 'USA')");
    result = check mysqlClient->execute("INSERT INTO MYSQL_TEST_DB.Customers (FirstName,LastName,RegistrationID," +
                "CreditLimit,Country) VALUES ('Dan', 'Brown', 2, 10000, 'UK')");
    check mysqlClient.close();
}

public function main() {
    sql:Error? err = initializeTable();
    if (err is sql:Error) {
        io:println("Sample data initialization failed!");
        io:println(err);
    } else {
        mysql:Client|sql:Error mysqlClient = new (user = dbUser,
            password = dbPassword, database = "MYSQL_TEST_DB");
        if (mysqlClient is mysql:Client) {
            simpleQuery(mysqlClient);
            io:println("Queried the database successfully!");
            sql:Error? e = mysqlClient.close();
        } else {
            io:println("MySQL Client initialization for querying data failed!", mysqlClient);
        }
    }
}
