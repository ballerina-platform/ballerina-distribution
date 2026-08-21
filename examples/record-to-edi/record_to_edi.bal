import ballerina/io;
import ballerinax/edifact.d03a.supplychain.mORDERS;

public function main() returns error? {
    // Build the purchase order as the typed record for D03A `ORDERS`. The prebuilt
    // `mORDERS` module carries the schema, so nothing is generated here either.
    mORDERS:EDI_ORDERS_ORDERS purchaseOrder = {
        Beginning_of_message: {
            DOCUMENT_MESSAGE_NAME: {Document_name_code: "220"},
            DOCUMENT_MESSAGE_IDENTIFICATION: {Document_identifier: "PO20001"},
            MESSAGE_FUNCTION_CODE: "9"
        },
        Date_time_period: [
            {
                DATE_TIME_PERIOD: {
                    Date_or_time_or_period: "137",
                    Date_or_time_or_period_text: "20260821",
                    Date_or_time_or_period_format_code: "102"
                }
            }
        ],
        group_1: [
            {Reference: {REFERENCE: {Reference_code_qualifier: "CT", Reference_identifier: "CONTRACT-77"}}}
        ],
        group_2: [
            {
                Name_and_address: {
                    PARTY_FUNCTION_CODE_QUALIFIER: "BY",
                    PARTY_IDENTIFICATION_DETAILS: {Party_identifier: "SUPERMART"}
                }
            },
            {
                Name_and_address: {
                    PARTY_FUNCTION_CODE_QUALIFIER: "SU",
                    PARTY_IDENTIFICATION_DETAILS: {Party_identifier: "SUPPLIER456"}
                }
            }
        ],
        // `UNS` separates the header section from the detail section and is mandatory.
        Section_control: {section_identification: "S"}
    };

    // Serialize the record back to EDI text against the same schema.
    string ediText = check mORDERS:toEdiString(purchaseOrder);
    io:println(ediText);
}
