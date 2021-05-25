import ballerina/io;
import ballerina/xmldata;

public function main() returns error? {
    // Creates a JSON object.
    json jsonObject = {"Store": {
            "@id": "AST",
            "name": "Anne",
            "address": {
                "street": "Main",
                "city": "94"
            },
            "codes": ["4", "8"]
        }};
    // Converts the JSON object to XML using a default `attributePrefix` (i.e., the `@` character)
    // and the default `arrayEntryTag` (i.e., `root`).
    xml? xmlData = check xmldata:fromJson(jsonObject);
    io:println(xmlData);

    if (xmlData is xml) {
        // Converts the XML to JSON object using a default `attributePrefix` (i.e., the `@` character)
        // and the default `preserveNamespaces` (i.e., `true`).
        jsonObject = check xmldata:toJson(xmlData);
        io:println(jsonObject);
    }
}
