import ballerina/http;
import ballerina/lang.runtime;
import ballerina/random;

service /stocks on new http:Listener(9090) {
    // This function returns a stream of SSE with stock prices
    resource function get .() returns stream<http:SseEvent, error?> {
        // Create a new instance of StockPriceEventGenerator to generate stock price events
        StockPriceEventGenerator generator = new;
        // Return a new stream that uses the generator to produce events
        return new (generator);
    }
}

// Define a class to generate stock price events
class StockPriceEventGenerator {
    int eventCounter = 0;

    public isolated function next() returns record {|http:SseEvent value;|}|error? {
        // If the eventCounter reaches 5, stop generating events by returning nil
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
