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

    // Converts a given RFC 3339 timestamp(e.g. `2007-12-03T10:15:30.00Z`)
    // to a `time:Civil` record.
    time:Civil civil1 = check
    time:civilFromString("2021-04-12T23:20:50.520+05:30[Asia/Colombo]");
    io:println("Converted civil value: " + civil1.toString());

    // Converts a given `time:Civil` value to a RFC 3339
    // (e.g. `2007-12-03T10:15:30.00Z`) formatted string.
    string civilString = check time:civilToString(civil1);
    io:println(`Civil string representation: ${civilString}`);

    // Converts a given UTC to an RFC 5322 formatted string
    // (e.g `Mon, 3 Dec 2007 10:15:30 GMT`).
    string emailFormattedString = time:utcToEmailString(utc, "Z");
    io:println(`Email formatted string: ${emailFormattedString}`);

    // Converts a given RFC 5322 formatted string
    // (e.g `Mon, 3 Dec 2007 10:15:30 GMT`) to a `time:Civil` record.
    time:Civil civil2 = check
    time:civilFromEmailString("Wed, 10 Mar 2021 19:51:55 -0800 (PST)");
    io:println(`Civil record of the email string: ${civil2.toString()}`);

    // Converts a given `time:Civil` record to an RFC 5322 formatted string
    // (e.g `Mon, 3 Dec 2007 10:15:30 GMT`).
    string emailString = check
    time:civilToEmailString(civil2, time:PREFER_ZONE_OFFSET);
    io:println(`Email string of the civil record: ${emailString}`);
}
