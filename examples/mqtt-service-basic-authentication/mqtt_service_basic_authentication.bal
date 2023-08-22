import ballerina/lang.value;
import ballerina/log;
import ballerina/mqtt;
import ballerina/time;
import ballerina/uuid;

public type TemperatureDetails readonly & record {
    string deviceId;
    time:Utc timestamp;
    decimal temperature;
};

listener mqtt:Listener temperatureSubscriber = new ("tcp://localhost:1883", uuid:createType1AsString(), "mqtt/topic", {
    connectionConfig: {
        username: "alice",
        password: "alice@123"
    }
});

service on temperatureSubscriber {
    remote function onMessage(mqtt:Message message) returns error? {
        TemperatureDetails details = check value:fromJsonStringWithType(check string:fromBytes(message.payload));
        log:printInfo(string `Received temperature details from device: ${details.deviceId} at
            ${time:utcToString(details.timestamp)} with temperature: ${details.temperature}`);
    }
}
