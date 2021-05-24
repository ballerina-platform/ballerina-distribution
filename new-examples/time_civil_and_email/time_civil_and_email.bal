import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Converts a given RFC 5322 formatted string
    // (e.g `Mon, 3 Dec 2007 10:15:30 GMT`) to a `time:Civil` record.
    time:Civil civil = check time:civilFromEmailString("Wed, 10 Mar 2021 19:51:55 -0800 (PST)");
    io:println(`Civil record of the email string: ${civil.toString()}`);

    // Converts a given `time:Civil` record to an RFC 5322 formatted string
    // (e.g `Mon, 3 Dec 2007 10:15:30 GMT`).
    string emailString = check time:civilToEmailString(civil, time:PREFER_ZONE_OFFSET);
    io:println(`Email string of the civil record: ${emailString}`);
}
