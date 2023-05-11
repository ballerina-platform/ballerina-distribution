import ballerinax/azure_functions as af;

// This function gets executed every 10 seconds by the Azure Functions app. Once the function is executed, the timer 
// details will be stored in the selected queue storage for every invocation.
@af:TimerTrigger {schedule: "*/10 * * * * *"}
listener af:TimerListener timerListener = new af:TimerListener();

service "timer" on timerListener {
    remote function onTrigger(af:TimerMetadata metadata) returns @af:QueueOutput {queueName: "queue3"} string|error {
        return "Message Status, " + metadata.IsPastDue.toString();
    }
}
