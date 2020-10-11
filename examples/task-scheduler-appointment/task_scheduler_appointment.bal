import ballerina/io;
import ballerina/runtime;
import ballerina/task;

int reminderCount = 0;

public function main() returns error? {
    // The [`task:AppointmentData`](https://ballerina.io/swan-lake/learn/api-docs/ballerina/task/records/AppointmentData.html) record provides the appointment configuration.
    task:AppointmentData appointmentDetails = {
        seconds: "0/2",
        minutes: "*",
        hours: "*",
        daysOfMonth: "?",
        months: "*",
        daysOfWeek: "*",
        year: "*"
    };

    // Creates an appointment using the given configuration.
    task:Scheduler appointment = new ({appointmentDetails});

    // Attach the service to the scheduler.
    check appointment.attach(appointmentService);

    // Start the scheduler.
    check appointment.start();

    runtime:sleep(9000);

    // Cancel the appointment.
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
