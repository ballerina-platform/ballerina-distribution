import ballerina/io;
import ballerina/xmldata;

public function main() returns error? {
    // Creates a JSON object.
    json j1 = {
        "Store": {
            "@id": "AST",
            "name": "Anne",
            "address": {
                "street": "Main",
                "city": "94"
            },
            "codes": ["4", "8"]
        }
    };
    // Converts the JSON object to XML using the default `attributePrefix`
    // and the default `arrayEntryTag`.
    xml? x1 = check xmldata:fromJson(j1);
    io:println(x1);

    json j2 = {
        "Store": {
            "#id": "AST",
            "name": "Anne",
            "address": {
                "street": "Main",
                "city": "94"
            },
            "codes": ["4", "8"]
        }
    };
    // Converts the JSON object to XML using a custom `attributePrefix` (i.e., the `#` character)
    // and the custom `arrayEntryTag` (i.e., `wrapper`).
    xml? x2 = check xmldata:fromJson(j2,
                        {attributePrefix: "#", arrayEntryTag: "wrapper"});
    io:println(x2);
}
