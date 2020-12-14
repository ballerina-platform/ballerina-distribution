import ballerina/io;
import ballerina/uuid;

public function main() {
    // Generate a UUID of type 1 as a string.
    string uuid1String = uuid:createType1AsString();
    io:println("UUID of type 1 as a string: ", uuid1String);

    // Generate a UUID of type 1 as a UUID record.
    uuid:Uuid|uuid:Error uuid1Record = uuid:createType1AsRecord();
    io:println("UUID of type 1 as a record: ", uuid1Record);

    // Generate a UUID of type 3 as a string.
    string|uuid:Error uuid3String = uuid:createType3AsString(
    uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 3 as a string: ", uuid3String);

    // Generate a UUID of type 3 as a record.
    uuid:Uuid|uuid:Error uuid3Record = uuid:createType3AsRecord(
    uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 3 as a record: ", uuid3Record);

    // Generate a UUID of type 4 as a string.
    string uuid4String = uuid:createType4AsString();
    io:println("UUID of type 4 as a string: ", uuid4String);

    // Generate a UUID of type 1 as a UUID record.
    uuid:Uuid|uuid:Error uuid4Record = uuid:createType4AsRecord();
    io:println("UUID of type 4 as a record: ", uuid4Record);

    // Generate a UUID of type 5 as a string.
    string|uuid:Error uuid5String = uuid:createType5AsString(uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 5 as a string: ", uuid5String);

    // Generate a UUID of type 5 as a record.
    uuid:Uuid|uuid:Error uuid5Record = uuid:createType5AsRecord(uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 5 as a record: ", uuid5Record);

    // Generate a nil UUID as a string.
    string nilUuidString = uuid:nilAsString();
    io:println("Nil UUID as a string: ", nilUuidString);

    // Generate a nil UUID as a UUID record.
    uuid:Uuid nilUuidRecord = uuid:nilAsRecord();
    io:println("Nil UUID as a record: ", nilUuidRecord);

    // Test a string to see if it is a valid UUID.
    boolean valid = uuid:validate("4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID validated: ", valid.toString());

    // Detect RFC version of a UUID.
    uuid:Version|uuid:Error v = uuid:getVersion("4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID version: ", v.toString());

    // Convert UUID string to a UUID record.
    uuid:Uuid|uuid:Error uuidRecord = uuid:toRecord("4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID record: ", uuidRecord);

    // Convert UUID record to a UUID string.
    uuid:Uuid uuidRecord2 = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    string|error uuidString = uuid:toString(uuidRecord2);
    io:println("UUID string: ", uuidString);
}
