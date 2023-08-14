<<<<<<< HEAD
import ballerina/time;
import ballerinax/azure.functions;
=======
import ballerinax/azure.functions;
import ballerina/time;
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae

// This function gets executed every 10 seconds by the Azure Functions app. Once the function is executed, the timer 
// details will be stored in the selected queue storage for every invocation.
@functions:TimerTrigger {schedule: "*/10 * * * * *"}
<<<<<<< HEAD
listener functions:TimerListener timerListener = new functions:TimerListener();

service "timer" on timerListener {
    remote function onTrigger(functions:TimerMetadata metadata) returns
    @functions:QueueOutput {queueName: "timer-queue"} string|error {
=======
listener af:TimerListener timerListener = new af:TimerListener();

service "timer" on timerListener {
    remote function onTrigger(af:TimerMetadata metadata) returns @af:QueueOutput {queueName: "timer-queue"} string|error {
>>>>>>> 2a84a2d3c676c4a3b03d236f287fef9e855a81ae
        time:Utc utc = time:utcNow();
        return "Hello from timer: " + time:utcToEmailString(utc);
    }
}
