import ballerina/io;
import ballerina/xmldata;

public function main() returns error? {
    xml xmlData = xml `<Store id="AST">
                          <name>Anne</name>
                          <address>
                              <street>Main</street>
                              <city>94</city>
                          </address>
                          <codes>4</codes>
                          <codes>8</codes>
                        </Store>`;
    // Converts the XML to JSON object using a default `attributePrefix` (i.e., the `@` character)
    // and the default `preserveNamespaces` (i.e., `true`).
    json jsonObject = check xmldata:toJson(xmlData);
    io:println(jsonObject);
}
