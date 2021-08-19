import ballerina/io;
import ballerina/lang.'string as langstring;
import ballerina/test;

string[] outputs = [];
int counter = 0;

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new ();

public function mockPrint(io:Printable... s) {
    string outstr = "";
    foreach io:Printable str in s {
        outstr = outstr + new PrintableClassImpl(str).toString();
    }
    outputs[counter] = outstr;
    counter += 1;
}

// From ballerina/io module to mock io:println() with raw templates
class PrintableClassImpl {
    io:Printable printable;

    public isolated function init(io:Printable printable) {
        self.printable = printable;
    }
    public isolated function toString() returns string {
        io:Printable printable = self.printable;
        if printable is io:PrintableRawTemplate {
            return new PrintableRawTemplateImpl(printable).toString();
        } else if printable is error {
            return printable.toString();
        } else {
            return printable.toString();
        }
    }
}

class PrintableRawTemplateImpl {
    *object:RawTemplate;
    public io:Printable[] insertions;

    public isolated function init(io:PrintableRawTemplate printableRawTemplate) {
        self.strings = printableRawTemplate.strings;
        self.insertions = printableRawTemplate.insertions;
    }
    public isolated function toString() returns string {
        io:Printable[] templeteInsertions = self.insertions;
        string[] templeteStrings = self.strings;
        string templatedString = templeteStrings[0];
        foreach int i in 1 ..< (templeteStrings.length()) {
            io:Printable templateInsert = templeteInsertions[i - 1];
            if (templateInsert is io:PrintableRawTemplate) {
                templatedString += new PrintableRawTemplateImpl(templateInsert).toString() + templeteStrings[i];
            } else if (templateInsert is error) {
                templatedString += templateInsert.toString() + templeteStrings[i];
            } else {
                templatedString += templateInsert.toString() + templeteStrings[i];
            }
        }
        return templatedString;
    }
}

@test:Config {}
function testFunc() returns error? {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function
    check main();
    test:assertTrue(langstring:includes(outputs[0], "Civil record: {\"timeAbbrev\":\"Z\","));
    test:assertEquals(outputs[1], "UTC value of the civil record: [1618269650,0.52]");
}
