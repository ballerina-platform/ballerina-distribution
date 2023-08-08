import ballerina/time;
import ballerinax/azure.functions;

// This function gets executed every 10 seconds by the Azure Functions app. Once the function is executed, the timer 
// details will be stored in the selected queue storage for every invocation.
@functions:TimerTrigger {schedule: "*/10 * * * * *"}
listener functions:TimerListener timerListener = new functions:TimerListener();

service "timer" on timerListener {
    remote function onTrigger(functions:TimerMetadata metadata) returns
    @functions:QueueOutput {queueName: "timer-queue"} string|error {
        time:Utc utc = time:utcNow();
        return "Hello from timer: " + time:utcToEmailString(utc);
    }
}
