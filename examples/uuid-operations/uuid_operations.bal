import ballerina/io;
import ballerina/uuid;

public function main() returns error? {
    // Tests a string to see if it is a valid UUID.
    boolean valid = uuid:validate("4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID validated: ", valid.toString());

    // Detects the RFC version of a UUID.
    uuid:Version v = check uuid:getVersion(
                                "4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID version: ", v.toString());

    // Converts a UUID string to an array of bytes.
    byte[] uuidBytes1 = check uuid:toBytes(
                                  "4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID bytes: ", uuidBytes1);

    // Converts a UUID string to a UUID record.
    uuid:Uuid uuidRecord1 = check uuid:toRecord(
                            "4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID record: ", uuidRecord1);

    uuid:Uuid uuidRecord = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    // Converts a UUID record to a UUID string.
    string uuidString1 = check uuid:toString(uuidRecord);
    io:println("UUID string: ", uuidString1);

    // Converts a UUID record to an array of bytes.
    byte[] uuidBytes2 = check uuid:toBytes(uuidRecord);
    io:println("UUID bytes: ", uuidBytes2);

    // Converts a UUID bytes array to a UUID string.
    string uuidString2 = check uuid:toString(
                        [67,151,70,94,53,249,17,235,173,193,2,66,172,18,0,2]);
    io:println("UUID string: ", uuidString2);

    // Converts a UUID bytes array to a UUID record.
    uuid:Uuid uuidRecord2 = check uuid:toRecord(
                        [67,151,70,94,53,249,17,235,173,193,2,66,172,18,0,2]);
    io:println("UUID record: ", uuidRecord2);
}
