import ballerina/http;
import ballerina/mqtt;
import ballerina/time;
import ballerina/uuid;

type TemperatureDetails readonly & record {
    string deviceId;
    time:Utc timestamp;
    decimal temperature;
};

service / on new http:Listener(9090) {
    private final mqtt:Client temperaturePublisher;

    function init() returns error? {
        self.temperaturePublisher = check new (mqtt:DEFAULT_URL, uuid:createType1AsString());
    }

    resource function post temperature(TemperatureDetails temperatureDetails) returns http:Accepted|error {
        _ = check self.temperaturePublisher->publish("mqtt/topic", {
            payload: temperatureDetails.toJsonString().toBytes()
        });
        return http:ACCEPTED;
    }
}
