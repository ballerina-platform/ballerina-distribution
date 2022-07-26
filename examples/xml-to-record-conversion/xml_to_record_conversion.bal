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
    string status?;
};

@xmldata:Namespace {
    uri: "http://example2.com"
}
type Item record {
    string itemCode;
    int item_count;
};

public function main() returns error? {
    xml data = xml `<ns:Invoice xmlns="example.com"
                        xmlns:ns="http://sdf.com" status="paid">
                        <id>1</id>
                        <purchased_item>
                            <itemCode>223345</itemCode>
                            <item_count>1</item_count>
                        </purchased_item>
                        <purchased_item>
                            <itemCode>223300</itemCode>
                            <item_count>7</item_count>
                        </purchased_item>
                    </ns:Invoice>`;

    // Converts an XML representation to its `record` representation.
    Invoice output = check xmldata:fromXml(data);
    io:println(output);
}
