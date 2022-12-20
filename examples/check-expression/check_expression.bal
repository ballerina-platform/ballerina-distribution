import ballerina/io;

function checkId(int id) returns error? {
   if id <= 0 {
       return error("id must be larger than 0");
   }
}

function getNextId(int id) returns int|error {
   // Check statement can be used when the type of an expression is `error?`
   // This will return if the result is `error`
   check checkId(id);

   return id + 1;
}

public function main() returns error? {
   // If `getNextId()` returns an `error` value, `check`
   // makes the function return the `error` value here.
   int nextId = check getNextId(-1);

   io:println("next ID: ", nextId);
}
