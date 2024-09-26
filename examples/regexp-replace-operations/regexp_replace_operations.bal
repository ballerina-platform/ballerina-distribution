import ballerina/io;

public function main() {
    string creditCardNumber = "1234-5678-9876-5432";
    string:RegExp pattern = re `(\d{4})-(\d{4})-(\d{4})`;
    // Replaces the first occurrence of the credit card pattern with a masked representation.
    string maskedCardNumber = pattern.replace(creditCardNumber, "****-****-****");
    io:println(maskedCardNumber);

    string xmlString = "<root>" +
            "<!-- This is a comment -->" +
            "<element1>Value 1</element1>" +
            "<element2>Value 2</element2>" +
            "<!-- Another comment -->" +
            "<element3>Value 3</element3>" +
        "</root>";
    
    // Regular expression to match XML comments
    string:RegExp commentPattern = re `<!--.*?-->`;
    // Replaces all occurrences of XML comments with an empty string, effectively removing them.
    string commentsRemoved = commentPattern.replaceAll(xmlString, "");
    io:println(string `Comments removed XML: ${commentsRemoved}`);
}
