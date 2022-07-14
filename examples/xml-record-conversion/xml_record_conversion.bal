import ballerina/io;
import ballerina/xmldata;

// Defines a record type with annotations.
@xmldata:Namespace {
    prefix: "ns",
    uri: "http://sdf.com"
}
type Invoice record {
    string address;
    Item[] items;
    @xmldata:Attribute
    string 'xmlns;
    @xmldata:Attribute
    string attr?;
    @xmldata:Attribute
    string ns\:attr?;
};

type Item record {
    string|ItemCode itemCode;
    int count;
};

@xmldata:Namespace {
    uri: "http://example.com"
}
type ItemCode record {
    @xmldata:Attribute
    string discount;
    string \#content;
};

// Creates an `Invoice` records.
Invoice data = {
    items: [
        {itemCode: "223345", count: 10},
        {itemCode: "223300", count: 7},
        {
            itemCode: {discount: "22%", \#content: "200777"},
            count: 7
        }
    ],
    address: "20, Palm grove, Colombo 3",
    attr: "attr-val",
    'xmlns: "http://sample.com",
    ns\:attr: "http://attr.com"
};

public function main() returns error? {
    // Converts a `record` representation to its XML representation.
    xml result = check xmldata:toXml(data);
    io:println(result);

    // Converts an XML representation to its `record` representation.
    Invoice output = check xmldata:fromXml(result);
    io:println(output);
}
