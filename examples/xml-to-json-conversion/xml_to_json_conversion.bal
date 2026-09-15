import ballerina/data.xmldata;
import ballerina/io;

// Defines a record type to represent the XML structure.
type Address record {
    string street;
    string city;
};

type Store record {
    string name;
    Address address;
    string[] codes;
    @xmldata:Attribute
    string id;
};

public function main() returns error? {
    // Creates an XML value.
    xml xmlValue = xml `<Store id="AST">
                          <name>Anne</name>
                          <address>
                              <street>Main</street>
                              <city>94</city>
                          </address>
                          <codes>4</codes>
                          <codes>8</codes>
                        </Store>`;
    // Converts the XML value to a record type.
    Store store = check xmldata:parseAsType(xmlValue);
    // Converts the record value to a JSON value.
    json jsonValue = store.toJson();
    io:println(jsonValue);
}
