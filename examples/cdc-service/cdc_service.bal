import ballerina/log;
import ballerinax/cdc;
import ballerinax/mysql;
import ballerinax/mysql.cdc.driver as _;

type Transactions record {|
    int tx_id;
    int user_id;
    float amount;
    string status;
    int created_at;
|};

listener mysql:CdcListener financeDBListener = new (
    database = {
        username: "root",
        password: "Test@123",
        includedDatabases: "finance_db"
    }
);

service on financeDBListener {

    isolated remote function onRead(Transactions trx) returns cdc:Error? {
        if trx.amount > 10000.00 {
            string fraudAlert = string `Fraud detected! Transaction Id: ${trx.tx_id}, User Id: ${trx.user_id}, Amount: $${trx.amount}`;
            log:printInfo(fraudAlert);
        }
    }

    isolated remote function onCreate(Transactions trx) returns cdc:Error? {
        if trx.amount > 10000.00 {
            string fraudAlert = string `Fraud detected! Transaction Id: ${trx.tx_id}, User Id: ${trx.user_id}, Amount: $${trx.amount}`;
            log:printInfo(fraudAlert);
        }
    }
}
