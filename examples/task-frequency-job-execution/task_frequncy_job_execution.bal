import ballerina/io;
import ballerina/task;
import ballerina/time;

// Creating a job to execute by the scheduler
class Job {

    *Job;
    int i = 1;

    // Executes by the Scheduler when the scheduled trigger fires
    public function execute() {
        self.i += 1;
        io:println("MyCounter: ", self.i);
    }

    isolated function init(int i) {
        self.i = i;
    }
}

public function main() {

    // Get the current time
    time:Utc currentUtc = time:utcNow();
    // Increase time by three second
    time:Utc newTime = time:utcAddSeconds(currentUtc, 3);
    // Get `time:Civil` for the given time
    time:Civil time = time:utcToCivil(newTime);
    // Creates a `time:ZoneOffset` using the given configuration.
    time:ZoneOffset zoneOffset = {hours: 5, minutes: 30};
    // Set the offset into `time:Civil`
    time.utcOffset = zoneOffset;

    // Schedule the frequency job
    JobId id = check task:scheduleJobRecurByFrequency(new Job(1), 1, stratTime = time);

    // Wait for nine seconds
    runtime:sleep(9.5);

    // UnSchedule the job
    check task:unscheduleJob(id);
}
