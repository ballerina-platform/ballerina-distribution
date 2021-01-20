import ballerina/io;
import ballerina/task;

// The [`task:TimerConfiguration`](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/task/latest/task/records/TimerConfiguration) record to configure the task listener.
task:TimerConfiguration timerConfiguration = {
    intervalInMillis: 1000,
    initialDelayInMillis: 3000,
    // Number of recurrences will limit the number of times the timer runs.
    noOfRecurrences: 10
};

// Initializes the listener using the configurations defined above.
listener task:Listener timer = new (timerConfiguration);

int count = 0;

// Creating a service bound to the task listener.
service on timer {
    // This resource triggers when the timer goes off.
    remote function onTrigger() {
        count += 1;
        io:println("MyCounter: ", count);
    }
}
