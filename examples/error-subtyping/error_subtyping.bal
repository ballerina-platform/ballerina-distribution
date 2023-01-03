import ballerina/io;
 
// `distinct` creates a new subtype.
type InvalidIDError distinct error;
type InvalidNameError distinct error;
 
type InvalidError InvalidIDError|InvalidNameError;
 
function checkId(int id) returns InvalidIDError? {
    if id <= 0 {
        // The name of the distinct type can be used with the `error` constructor to create an error
        // value of that type.
        return error InvalidIDError("id must be larger than 0");
    }
}
 
function getNextId(int id) returns int|InvalidError {
    // Check can also be used with custom errors.
    check checkId(id);
    return id + 1;
}
 
public function main() {
    InvalidError|int result = getNextId(-1);
    
    if result is InvalidIDError {
        io:println("InvalidIDError");
    }
}
