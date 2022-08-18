import ballerina/io;

const ID = "unique-identifier";

function getDetailMap(string uniqueId,
                      string firstName,
                      string lastName,
                      string idName, 
                      string id) returns map<string> {
    return {
        // The value `"unique-identifier"` is subtituted from the constant as the key.
        [ID]: uniqueId,
        name: firstName + " " + lastName,
        // The key will be computed at runtime and will be the concatenation of `_` and
        // the argument passed for `idName`.
        ["_" + idName]: id
    };
}

public function main() {
    map<string> detailMap = getDetailMap("AQW123", "John", "Doe", "employeeId", "123EMP");
    io:println(detailMap);
}
