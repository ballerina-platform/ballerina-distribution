import ballerina/io;
import ballerinax/edifact.d03a.supplychain.mORDERS;

// A UN/EDIFACT D03A `ORDERS` purchase order. The prebuilt `mORDERS` module already carries
// the D03A `ORDERS` schema, so there is no schema file to write and no code to generate.
final string orderText = string `UNH+0001+ORDERS:D:03A:UN'` + "\n" +
    string `BGM+220+PO20001+9'` + "\n" +
    string `DTM+137:20260821:102'` + "\n" +
    string `RFF+CT:CONTRACT-77'` + "\n" +
    string `NAD+BY+SUPERMART'` + "\n" +
    string `NAD+SU+SUPPLIER456'` + "\n" +
    string `UNS+S'` + "\n" +
    string `UNT+8+0001'`;

public function main() returns error? {
    // Parse the message into the typed record for D03A `ORDERS`. Envelope segments are
    // skipped, so the same call works on a bare message or on a full interchange.
    mORDERS:EDI_ORDERS_ORDERS purchaseOrder = check mORDERS:fromEdiString(orderText);

    io:println("Order Id: ",
        purchaseOrder.Beginning_of_message?.DOCUMENT_MESSAGE_IDENTIFICATION?.Document_identifier ?: "-");

    // Each RFF segment becomes one `group_1` entry.
    foreach mORDERS:Group_1_GType reference in purchaseOrder.group_1 {
        io:println("Reference: ", reference.Reference?.REFERENCE?.Reference_identifier ?: "-");
    }

    // Each NAD segment becomes one `group_2` entry: BY is the buyer, SU the supplier.
    foreach mORDERS:Group_2_GType party in purchaseOrder.group_2 {
        mORDERS:Name_and_address_Type nad = party.Name_and_address;
        io:println("Party ", nad.PARTY_FUNCTION_CODE_QUALIFIER, ": ",
            nad?.PARTY_IDENTIFICATION_DETAILS?.Party_identifier ?: "-");
    }
}
