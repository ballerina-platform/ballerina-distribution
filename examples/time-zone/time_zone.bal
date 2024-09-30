import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Event recorded in UTC (2022-01-29 22:48:00).
    time:Utc eventUtcTime = check time:utcFromString("2022-01-29T22:48:00Z");
    io:println("Event time in UTC: ", eventUtcTime);

    // Load the system's default time zone.
    time:Zone systemZone = check new time:TimeZone();
    // Convert UTC event time to the system's local time.
    time:Civil eventInSystemZone = systemZone.utcToCivil(eventUtcTime);
    io:println("Event time in system's local time: " + eventInSystemZone.toString());

    // Print the event time in 'Europe/London' time zone.
    printZoneTimeFromUtc(eventUtcTime, "Europe/London");

    // Print the event time in 'Asia/Tokyo' time zone.
    printZoneTimeFromUtc(eventUtcTime, "Asia/Tokyo");
}

function printZoneTimeFromUtc(time:Utc utcTime, string zoneId) {
    time:Zone? zone = time:getZone(zoneId);
    if zone is time:Zone {
        time:Civil timeInZone = zone.utcToCivil(utcTime);
        io:println(string `Event time in ${zoneId} time zone: ${timeInZone.toString()}`);
    } else {
        io:println(string `Failed to load the '${zoneId}' time zone.`);
    }
}
