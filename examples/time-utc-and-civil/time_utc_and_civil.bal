import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Gets the current instant of the system clock (seconds from the epoch of
    // 1970-01-01T00:00:00). The returned `time:Utc` value represents seconds
    // from the epoch with nanoseconds precision.
    time:Utc utc1 = time:utcNow();
    // Converts a given `time:Utc` value to a `time:Civil` value.
    time:Civil civil1 = time:utcToCivil(utc1);
    io:println(`Civil record: ${civil1.toString()}`);

    // Converts a given `time:Civil` value to a `time:Utc` value.
    // Note that, since `time:Civil` is used to represent localized time,
    // it is mandatory to have the `utcOffset` field to be specified in the
    // given `time:Civil` value.
    time:Civil civil2 = {
        year: 2021,
        month: 4,
        day: 13,
        hour: 4,
        minute: 50,
        second: 50.52,
        timeAbbrev: "Asia/Colombo",
        utcOffset: {hours: 5, minutes: 30, seconds: 0d}
    };
    time:Utc utc2 = check time:utcFromCivil(civil2);
    io:println(`UTC value of the civil record: ${utc2.toString()}`);
}
