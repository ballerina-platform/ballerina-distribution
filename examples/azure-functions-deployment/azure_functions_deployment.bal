import ballerinax/azure_functions as af;

// This functions gets triggered from a HTTP call and returns a processed HTTP output to the caller.
@af:Function
public function hello(@af:HTTPTrigger { authLevel: "anonymous" } string payload) returns @af:HTTPOutput string|error {
    return "Hello, " + payload + "!";
}

// This function gets executed from a HTTP call, when it gets executed it will query the blog storage and pick the 
// appropriate blob according to query parameter. Then it will return the processed output as a HTTP response.
@af:Function
public function httpTriggerBlobInput(@af:HTTPTrigger { authLevel: "anonymous" } af:HTTPRequest req, 
                    @af:BlobInput { path: "bpath1/{Query.name}" }byte[]? blobIn) returns @af:HTTPOutput string {
    int length = 0;
    if blobIn is byte[] {
        length = blobIn.length();
    }
    return "Blob: " + req.query["name"].toString() + " Length: " + 
            length.toString() + " Content: " + blobIn.toString();
}

// This function gets executed every 10 seconds from the azure function app. Once the function is executed the timer 
// details will be stored in the selected queue storage for every invocation.
@af:Function
public function queuePopulationTimer(@af:TimerTrigger { schedule: "*/10 * * * * *" } json triggerInfo,
            @af:QueueOutput { queueName: "queue4" } af:StringOutputBinding msg) {
                 msg.value = triggerInfo.toString();
}
