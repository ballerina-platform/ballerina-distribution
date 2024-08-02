import ballerina/http;
import ballerina/lang.runtime;
import ballerina/random;

service /stocks on new http:Listener(9090) {
    resource function get .() returns stream<http:SseEvent, error?> {
        StockPriceEventGenerator generator = new;
        return new (generator);
    }
}

class StockPriceEventGenerator {
    int eventCounter = 0;

    public isolated function next() returns record {|http:SseEvent value;|}|error? {
        if self.eventCounter == 5 {
            return ();
        }
        self.eventCounter += 1;
        runtime:sleep(1);
        float stockPrice = (check random:createIntInRange(1, 1000)) * random:createDecimal();
        http:SseEvent event = {data: stockPrice.toString()};
        return {value: event};
    }
}
