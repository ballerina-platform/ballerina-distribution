import ballerina/edi;
import ballerina/io;

// A schema for a simple order carried in an EDIFACT envelope. `envelope` describes the
// interchange and message levels, and `segments` describes the body inside a message.
final string schemaJson = string `{
    "name": "SimpleOrder",
    "delimiters": {"segment": "'", "field": "+", "component": ":", "repetition": "*"},
    "envelope": {
        "interchange": {
            "header": [{"code": "UNB", "tag": "interchangeHeader", "fields": [
                {"tag": "code"},
                {"tag": "syntax", "dataType": "composite", "components": [{"tag": "id"}, {"tag": "version"}]},
                {"tag": "sender", "dataType": "composite", "components": [{"tag": "id"}, {"tag": "qualifier"}]},
                {"tag": "recipient", "dataType": "composite", "components": [{"tag": "id"}, {"tag": "qualifier"}]},
                {"tag": "dateTime", "dataType": "composite", "components": [{"tag": "date"}, {"tag": "time"}]},
                {"tag": "controlReference"}]}],
            "trailer": [{"code": "UNZ", "tag": "interchangeTrailer", "fields": [
                {"tag": "code"}, {"tag": "count", "dataType": "int"}, {"tag": "controlReference"}]}]
        },
        "transaction": {
            "header": [{"code": "UNH", "tag": "messageHeader", "fields": [
                {"tag": "code"}, {"tag": "messageReference"},
                {"tag": "messageIdentifier", "dataType": "composite", "components": [
                    {"tag": "type"}, {"tag": "version"}, {"tag": "release"}, {"tag": "agency"}]}]}],
            "trailer": [{"code": "UNT", "tag": "messageTrailer", "fields": [
                {"tag": "code"}, {"tag": "segmentCount", "dataType": "int"}, {"tag": "messageReference"}]}]
        }
    },
    "segments": [
        {"code": "BGM", "tag": "orderHeader", "minOccurances": 1, "fields": [
            {"tag": "code"}, {"tag": "documentName"}, {"tag": "orderId"}]},
        {"code": "LIN", "tag": "items", "maxOccurances": -1, "fields": [
            {"tag": "code"}, {"tag": "lineNumber"}, {"tag": "item"}, {"tag": "quantity", "dataType": "int"}]}
    ]
}`;

// One interchange carrying two messages. The second is missing its mandatory BGM segment.
final string ediText = "UNB+UNOA:3+SUPERMART:14+SUPPLIER456:14+260101:1200+REF2'" +
    "UNH+0001+ORDERS:D:03A:UN'BGM+220+PO20001'LIN+1+ITEM-A+100'LIN+2+ITEM-B+40'UNT+5+0001'" +
    "UNH+0002+ORDERS:D:03A:UN'LIN+1+ITEM-C+10'UNT+3+0002'" +
    "UNZ+2+REF2'";

public function main() returns error? {
    edi:EdiSchema schema = check edi:getSchema(schemaJson);

    // Read the whole envelope hierarchy. Envelope segments are fail-fast, so a malformed
    // UNB or UNT fails the call.
    edi:EdiInterchange interchange = check edi:interchangeFromEdiString(ediText, schema);
    json sender = check interchange.interchangeHeader.interchangeHeader.sender.id;
    io:println(string `Interchange from ${sender.toString()}`);

    // Transaction bodies are fail-safe: a body the schema cannot read leaves its error on
    // that transaction, and every other message in the interchange still arrives.
    foreach edi:EdiTransaction txn in interchange.transactions ?: [] {
        json messageRef = check txn.transactionHeader.messageHeader.messageReference;
        json|error body = txn.body;
        if body is error {
            io:println(string `  message ${messageRef.toString()}: quarantined`);
            continue;
        }
        json orderHeader = check body.orderHeader;
        json orderId = check orderHeader.orderId;
        json itemList = check body.items;
        json[] items = <json[]>itemList;
        io:println(string `  message ${messageRef.toString()}: order ${orderId.toString()}, ${items.length()} items`);
    }
}
