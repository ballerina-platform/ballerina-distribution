import ballerina/io;
import ballerina/xmldata;

// Defines a record type with annotations.
@xmldata:Namespace {
    prefix: "ns",
    uri: "http://sdf.com"
}
type Invoice record {
    int id;
    Item[] items;
    @xmldata:Attribute
    string 'xmlns?;
    @xmldata:Attribute
    string attr?;
};

@xmldata:Namespace {
    uri: "http://example.com"
}
@xmldata:Name {
    value: "purchased_item"
}
type Item record {
    string itemCode;
    @xmldata:Name {
        value: "item_count"
    }
    int count;
};

public function main() returns error? {
    // Creates an `Invoice` records.
    Invoice data = {
        id: 1,
        items: [
                   {itemCode: "223345", count: 1},
                   {itemCode: "223300", count: 7}
               ],
        attr: "attr-val",
        'xmlns: "example2.com",
        ns\:attr: "example1.com"
    };

    // Converts a `record` representation to its XML representation.
    xml result = check xmldata:toXml(data);
    io:println(result);
}
