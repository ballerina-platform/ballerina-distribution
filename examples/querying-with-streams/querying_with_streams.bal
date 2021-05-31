type Error error;

type LS stream<string, Error?>;

// This method strips the blank lines.
function strip(LS lines) returns LS {
    // Creates a `stream` from `query expression`.
    LS res = stream from var line in lines
             where line.trim().length() > 0
             select line;
    return res;
}

function count(LS lines) returns int|Error {
    int nLines = 0;
    // Counts the number of lines by iterating the `stream`
    // in `query action`.
    var res = check from var line in lines
              do {
                  nLines += 1;
              };
    return nLines;
}
