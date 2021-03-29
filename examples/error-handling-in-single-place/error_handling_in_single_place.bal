import ballerina/io;

type InvalidAccountIDError error;

type AccountNotFoundError error;

const ACCOUNT_NOT_FOUND = "AccountNotFound";

const INVALID_ACCOUNT_ID = "InvalidAccountID";

public function main() {
   int negResult = getAccountBalance(-1);
   int invalidResult = getAccountBalance(200);

   transaction {
      int parsedNum = check parse("12");

      // Parsing a random string will return an error. This will
      // cause control to be transferred to the `on fail` clause.
      int parsedStr = check parse("invalid");

      error? res = commit;
   } on fail error e {
      io:println("Error occurred during parsing: ", e.message());
   }
}

function parse(string num) returns int|error {
   return int:fromString(num);
}

function getAccountBalance(int accountID) returns int {
   do {
      if accountID < 0 {
         // Fail with an `InvalidAccountIDError` error if the `accountID`
         // is less than zero.
         InvalidAccountIDError invalidAccoundIdError =
            error InvalidAccountIDError(INVALID_ACCOUNT_ID,
                                        accountID = accountID);
         fail invalidAccoundIdError;
      } else if accountID > 100 {
         // Fail with an `AccountNotFound` error if the `accountID` is
         // greater than hundred.
         AccountNotFoundError accountNotFoundError =
            error AccountNotFoundError(ACCOUNT_NOT_FOUND,
                                       accountID = accountID);
         fail accountNotFoundError;
      }
   // The type of `e` should be the union of the error types that can cause
   // control to be transferred to the `on fail` clause from within the
   // `do` statement.
   } on fail InvalidAccountIDError|AccountNotFoundError e {
      io:println("Error occurred: ", e.message(),
                 "Account ID: ", e.detail()["accountID"]);
   }
   return 600;
}
