import ballerina/io;
import ballerina/runtime;
import ballerina/task;

int reminderCount = 0;

public function main() returns error? {

    // The [`task:AppointmentConfiguration`](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/task/records/AppointmentConfiguration) record of the task scheduler.
    task:AppointmentConfiguration appointmentConfiguration = {
        // This CRON expression will schedule the appointment every two second.
        cronExpression: "0/2 * * ? * * *"
    };

    // Creates an appointment using the given configuration.
    task:Scheduler appointment = new (appointmentConfiguration);

    // Attaches the service to the scheduler.
    check appointment.attach(appointmentService);

    // Starts the scheduler.
    check appointment.start();

    runtime:sleep(9000);

    // Cancels the appointment.
    check appointment.stop();

    io:println("Appointment cancelled.");
}

// Creating a service on the task listener.
service appointmentService = service {
    // This resource is triggered when the appointment is due.
    resource function onTrigger() {
        reminderCount += 1;
        io:println("Schedule is due - Reminder: ", reminderCount);
    }

};
