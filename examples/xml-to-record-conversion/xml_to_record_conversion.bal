import ballerina/io;
import ballerina/xmldata;

// Defines a record type with annotations.
@xmldata:Namespace {
    prefix: "ns",
    uri: "http://sdf.com"
}
type Invoice record {
    int id;
    Item[] purchased_item;
    @xmldata:Attribute
    string 'xmlns?;
    @xmldata:Attribute
    string attr?;
};

@xmldata:Namespace {
    uri: "http://example.com"
}
type Item record {
    string itemCode;
    int item_count;
};

public function main() returns error? {
    xml data = xml `<ns:Invoice xmlns="example2.com" xmlns:ns="http://sdf.com" attr="attr-val">
                        <id>1</id>
                        <purchased_item xmlns="http://example.com">
                            <itemCode>223345</itemCode>
                            <item_count>1</item_count>
                        </purchased_item>
                        <purchased_item xmlns="http://example.com">
                            <itemCode>223300</itemCode>
                            <item_count>7</item_count>
                        </purchased_item>
                    </ns:Invoice>`;

    // Converts an XML representation to its `record` representation.
    Invoice output = check xmldata:fromXml(data);
    io:println(output);
}
