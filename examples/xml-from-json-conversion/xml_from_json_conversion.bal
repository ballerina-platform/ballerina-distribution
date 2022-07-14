import ballerina/io;
import ballerina/xmldata;

public function main() returns error? {
    // Creates a JSON value.
    json jsonValue = {"Store": {
            "@id": "AST",
            "name": "Anne",
            "address": {
                "street": "Main",
                "city": "94"
            },
            "codes": ["4", "8"]
        }};
    // Converts the JSON value to XML using a default `attributePrefix` (i.e., the `@` character)
    // and the default `arrayEntryTag` (i.e., `root`).
    xml? xmlValue = check xmldata:fromJson(jsonValue);
    io:println(xmlValue);
}
