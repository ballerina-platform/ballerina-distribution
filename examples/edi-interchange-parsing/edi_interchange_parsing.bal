import ballerina/io;

import ballerinax/edifact.d03a.supplychain.mORDERS;

// One EDIFACT interchange (UNB/UNZ) carrying two D03A `ORDERS` messages. The second is
// missing its mandatory `BGM` segment, so it cannot be parsed.
final string interchangeText = string `UNB+UNOA:3+SUPERMART:14+SUPPLIER456:14+260821:1000+IC0001'` + "\n" +
    string `UNH+0001+ORDERS:D:03A:UN'` + "\n" +
    string `BGM+220+PO20001+9'` + "\n" +
    string `DTM+137:20260821:102'` + "\n" +
    string `NAD+SU+SUPPLIER456'` + "\n" +
    string `UNS+S'` + "\n" +
    string `UNT+6+0001'` + "\n" +
    string `UNH+0002+ORDERS:D:03A:UN'` + "\n" +
    string `DTM+137:20260821:102'` + "\n" +
    string `UNS+S'` + "\n" +
    string `UNT+4+0002'` + "\n" +
    string `UNZ+2+IC0001'`;

public function main() returns error? {
    // Read the whole envelope hierarchy into typed records.
    mORDERS:EDI_ORDERS_ORDERSInterchange interchange =
        check mORDERS:interchangeFromEdiString(interchangeText);

    io:println("Interchange from ", interchange.interchangeHeader.interchange_header.sender.id);

    // Bodies are fail-safe: a message the schema cannot read carries its error instead of
    // failing the whole interchange, so the rest of the batch is still processed.
    foreach mORDERS:EDI_ORDERS_ORDERSTransaction txn in interchange.transactions {
        string reference = txn.transactionHeader.Message_header.message_reference_number;
        mORDERS:EDI_ORDERS_ORDERS|error body = txn.body;
        if body is error {
            io:println("  message ", reference, ": quarantined");
            continue;
        }
        io:println("  message ", reference, ": order ",
            body.Beginning_of_message?.DOCUMENT_MESSAGE_IDENTIFICATION?.Document_identifier ?: "-",
            ", parties: ", body.group_2.length());
    }
}
