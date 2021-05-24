import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Gets the current instant of the system clock (seconds from the epoch of
    // 1970-01-01T00:00:00). The returned `time:Utc` value represents seconds
    // from the epoch with nanoseconds precision.
    time:Utc utc = time:utcNow();

    // Converts a given UTC to an RFC 5322 formatted string
    // (e.g `Mon, 3 Dec 2007 10:15:30 GMT`).
    string emailFormattedString = time:utcToEmailString(utc, "Z");
    io:println(`Email formatted string: ${emailFormattedString}`);
}
