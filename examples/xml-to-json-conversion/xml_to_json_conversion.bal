import ballerina/io;
import ballerina/xmldata;

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
    // Converts the XML to JSON value using a default `attributePrefix` (i.e., the `@` character)
    // and the default `preserveNamespaces` (i.e., `true`).
    json jsonValue = check xmldata:toJson(xmlValue);
    io:println(jsonValue);
}