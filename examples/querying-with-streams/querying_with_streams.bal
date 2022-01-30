import ballerina/io;

type Error error;

type LineStream stream<string, Error?>;

type ValueRecord record {|
    string value;
|};

const SAMPLE_LINE_COUNT = 5;

class LineGenerator {
    int i = -1;
    string inputString;

    public function init(string str) {
        self.inputString = str;
    }

    public isolated function next() returns ValueRecord|Error? {
        self.i += 1;
        if (self.i < SAMPLE_LINE_COUNT) {
            if (self.i % 2 == 0) {
                return {value: self.inputString};
            }
            return {value: ""};
        }
        return;
    }
}

// This method strips the blank lines.
function strip(LineStream lines) returns LineStream {
    // Creates a `stream` from the query expression.
    LineStream res = stream from var line in lines
             where line.trim().length() > 0
             select line;

    return res;
}

function count(LineStream lines) returns int|Error {
    int nLines = 0;
    // Counts the number of lines by iterating the `stream`
    // in `query action`.
    var _ = check from var _ in lines
              do {
                  nLines += 1;
              };

    return nLines;
}

public function main() {
    LineGenerator generator = new ("Everybody can dance");
    LineStream inputLineStream = new (generator);

    LineStream strippedStream = strip(inputLineStream);

    int|Error nonBlankCount = count(strippedStream);

    if (nonBlankCount is int) {
        io:println("Input line count: ", SAMPLE_LINE_COUNT.toString());
        io:println("Non blank line count: ", nonBlankCount.toString());
    }
}
