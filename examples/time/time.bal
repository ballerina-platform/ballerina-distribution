import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Get the current instant of the system clock(seconds from the epoch of
    // 1970-01-01T00:00:00). The returned `time:Utc` value represents seconds
    // from the epoch with nanoseconds precision.
    // The `time:Utc` is a tuple with [int, decimal]. The first member of the
    // tuple represents the number of seconds from the epoch. The second
    // member represents the rest of the nanoseconds from the epoch as a
    // fraction.
    time:Utc currentUtc = time:utcNow();
    io:println(string `Current timestamp seconds: ${currentUtc[0]}s`);
    io:println(string `Current timestamp nanoseconds as a
    fraction: ${currentUtc[1]}s`);

    // Return seconds from some unspecified epoch. The returned `seconds` has
    // the nanoseconds precision which represents using the fractional part.
    time:Seconds seconds = time:monotonicNow();
    io:println(string `Seconds from an unspecified epoch: ${seconds}s`);

    // Returns a `time:Utc` from a given RFC 3339 timestamp
    // (e.g. `2007-12-03T10:15:30.00Z`).
    time:Utc utc1 = check time:utcFromString("2007-12-03T10:15:30.00Z");
    io:println("UTC value: " + utc1.toString());

    // Returns the string representation of RFC 3339 timestamp
    // (e.g. `2007-12-03T10:15:30.00Z`) from a given `time:Utc`.
    string utcString1 = time:utcToString(utc1);
    io:println(string `UTC string representation: ${utcString1}`);

    // Returns the difference of two `time:Utc` values as
    // seconds(`time:Seconds`).
    time:Seconds utcDiff = time:utcDiffSeconds(currentUtc, utc1);
    io:println(string `UTC diff: ${utcDiff}`);

    // Check the given `time:Date` value is valid or not.
    time:Date date = {year: 1994, month: 11, day: 7};
    boolean isValidDate = (time:dateValidate(date) is ())? true: false;
    io:println(string `Is valid date: ${isValidDate}`);

    // Return the day of week as a number starting from 0 to 6 inclusive.
    // 0 - SUNDAY, 1 - MONDAY, 2 - TUESDAY, 3 - WEDNESDAY, 4 - THURSDAY,
    // 5 - FRIDAY, 6 - SATURDAY
    time:DayOfWeek dayOfWeek = time:dayOfWeek(date);
    io:println("Day of week: " + dayOfWeek.toString());

    // Converts a given `time:Utc` value to a `time:Civil` value.
    time:Civil civil1 = time:utcToCivil(utc1);
    io:println("Civil record: " + civil1.toString());

    // Converts a given `time:Civil` value to a `time:Utc` value.
    // Note that, since `time:Civil` is used to represent localized time,
    // it is mandatory to have the `utcOffset` field to be specified in the
    // given `time:Civil` value.
    time:ZoneOffset zoneOffset = {
        hours: 5,
        minutes: 30,
        seconds: <decimal>0.0
    };
    time:Civil civil2 = {
        year: 2021,
        month: 4,
        day: 13,
        hour: 4,
        minute: 50,
        second: 50.52,
        timeAbbrev: "Asia/Colombo",
        utcOffset: zoneOffset
    };
    time:Utc utc2 = check time:utcFromCivil(civil2);
    io:println("UTC value of the civil record: " + utc2.toString());

    // Converts a given RFC 3339 timestamp(e.g. `2007-12-03T10:15:30.00Z`)
    // to `time:Civil`.
    time:Civil civil3 = check
    time:civilFromString("2021-04-12T23:20:50.520+05:30[Asia/Colombo]");
    io:println("Converted civil value: " + civil3.toString());

    // Converts a given `time:Civil` value to a RFC 3339
    // timestamp(e.g. `2007-12-03T10:15:30.00Z`) formatted string.
    string civilString = check time:civilToString(civil3);
    io:println(string `Civil string representation: ${civilString}`);
}
