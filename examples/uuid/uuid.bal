import ballerina/io;
import ballerina/uuid;

public function main() returns error? {
    // Generates a UUID of type 1 as a string.
    string uuid1String = uuid:createType1AsString();
    io:println("UUID of type 1 as a string: ", uuid1String);

    // Generates a UUID of type 1 as a UUID record.
    uuid:Uuid uuid1Record = check uuid:createType1AsRecord();
    io:println("UUID of type 1 as a record: ", uuid1Record);

    // Generates a UUID of type 3 as a string.
    string uuid3String = check uuid:createType3AsString(
    uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 3 as a string: ", uuid3String);

    // Generates a UUID of type 3 as a record.
    uuid:Uuid uuid3Record = check uuid:createType3AsRecord(
    uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 3 as a record: ", uuid3Record);

    // Generates a UUID of type 4 as a string.
    string uuid4String = uuid:createType4AsString();
    io:println("UUID of type 4 as a string: ", uuid4String);

    // Generates a UUID of type 1 as a UUID record.
    uuid:Uuid uuid4Record = check uuid:createType4AsRecord();
    io:println("UUID of type 4 as a record: ", uuid4Record);

    // Generates a UUID of type 5 as a string.
    string uuid5String = check uuid:createType5AsString(
                                    uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 5 as a string: ", uuid5String);

    // Generates a UUID of type 5 as a record.
    uuid:Uuid uuid5Record = check uuid:createType5AsRecord(
                                       uuid:NAME_SPACE_DNS, "ballerina.io");
    io:println("UUID of type 5 as a record: ", uuid5Record);

    // Generates a nil UUID as a string.
    string nilUuidString = uuid:nilAsString();
    io:println("Nil UUID as a string: ", nilUuidString);

    // Generates a nil UUID as a UUID record.
    uuid:Uuid nilUuidRecord = uuid:nilAsRecord();
    io:println("Nil UUID as a record: ", nilUuidRecord);

    // Tests a string to see if it is a valid UUID.
    boolean valid = uuid:validate("4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID validated: ", valid.toString());

    // Detects the RFC version of a UUID.
    uuid:Version v = check uuid:getVersion(
                                "4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID version: ", v.toString());

    // Converts a UUID string to an array of bytes.
    byte[] uuidBytes = check uuid:toBytes(
                                  "4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID bytes: ", uuidBytes);

    // Converts a UUID record to a UUID string.
    uuid:Uuid uuidRecord = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    string uuidString = check uuid:toString(uuidRecord);
    io:println("UUID string: ", uuidString);

    // Converts a UUID string to a UUID record.
    uuid:Uuid uuidRecord2 = check uuid:toRecord(
                            "4397465e-35f9-11eb-adc1-0242ac120002");
    io:println("UUID record: ", uuidRecord2);
}
