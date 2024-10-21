import ballerina/io;

public function main() {
    string creditCardNumber = "1234-5678-9876-5432";
    string:RegExp pattern = re `\d{4}-\d{4}-\d{4}`;
    // Replace the first occurrence of the credit card pattern with a masked representation.
    string maskedCardNumber = pattern.replace(creditCardNumber, "****-****-****");
    io:println(maskedCardNumber);

    xml xmlString = 
            xml `<root><!--comment 1 --><e1>value1</e1><e2>value2</e2><!--comment 2-->></root>`;
    
    // Regular expression to match XML comments.
    string:RegExp commentPattern = re `<!--.*?-->`;
    // Replace all occurrences of XML comments with an empty string, effectively removing them.
    string commentsRemovedXml = commentPattern.replaceAll(xmlString.toString(), "");
    io:println("XML string with comments removed: ", commentsRemovedXml);
}
