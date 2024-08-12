import ballerina/http;
import ballerina/lang.runtime;
import ballerina/random;

service /stocks on new http:Listener(9090) {
    // This resource method returns a stream of `http:SseEvent` (with stock prices)
    // to push real-time data to clients using server-event events (SSE).
    resource function get .() returns stream<http:SseEvent, error?> {
        // Create a new value of type `StockPriceEventGenerator` to generate stock price events.
        StockPriceEventGenerator generator = new;
        // Return a new stream that uses the generator to produce events.
        return new (generator);
    }
}

// Define a stream implementor that can be used to create a stream 
// of `http:SseEvent`, representing stock price events.
class StockPriceEventGenerator {
    int eventCounter = 0;

    public isolated function next() returns record {|http:SseEvent value;|}|error? {
        // If the eventCounter reaches 5, stop generating events by returning nil.
        if self.eventCounter == 5 {
            return ();
        }
        self.eventCounter += 1;
        runtime:sleep(1);
        // Generate a random stock price
        float stockPrice = (check random:createIntInRange(1, 1000)) * random:createDecimal();
        http:SseEvent event = {data: stockPrice.toString()};
        return {value: event};
    }
}
