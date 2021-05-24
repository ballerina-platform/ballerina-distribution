import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Converts a given RFC 3339 timestamp
    // (e.g. `2007-12-03T10:15:30.12Z`) string to a `time:Utc` value.
    time:Utc utc = check time:utcFromString("2007-12-03T10:15:30.120Z");
    io:println("UTC value: " + utc.toString());

    // Converts a given `time:Utc` to a RFC 3339 timestamp
    // (e.g. `2007-12-03T10:15:30.00Z`) string.
    string utcString = time:utcToString(utc);
    io:println(`UTC string representation: ${utcString}`);
}
