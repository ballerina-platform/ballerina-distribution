import ballerina/lang.value;
import ballerina/log;
import ballerina/mqtt;
import ballerina/time;

type TemperatureDetails readonly & record {
    string deviceId;
    time:Utc timestamp;
    decimal temperature;
};

service on new mqtt:Listener(mqtt:DEFAULT_URL, "temperature-sub-client", "mqtt/topic") {
    remote function onMessage(mqtt:Message message) returns error? {
        TemperatureDetails details = check value:fromJsonStringWithType(check string:fromBytes(message.payload));
        log:printInfo(string `Received temperature details from device: ${details.deviceId} at
            ${time:utcToString(details.timestamp)} with temperature: ${details.temperature}`);
    }
}
