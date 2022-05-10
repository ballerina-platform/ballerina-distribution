import ballerina/io;
import ballerina/lang.runtime;
import ballerina/task;
import ballerina/time;

// Creates a job to be executed by the scheduler.
class Job {

    *task:Job;
    int i = 1;

    // Executes this function when the scheduled trigger fires.
    public function execute() {
        self.i += 1;
        io:println("MyCounter: ", self.i);
    }

    isolated function init(int i) {
        self.i = i;
    }
}

public function main() returns error? {
    // Gets the current time.
    time:Utc currentUtc = time:utcNow();
    // Increases the time by three seconds to get the specified time for scheduling the job.
    time:Utc newTime = time:utcAddSeconds(currentUtc, 3);
    // Gets the `time:Civil` for the given time.
    time:Civil time = time:utcToCivil(newTime);

    // Schedules the one-time job at the specified time.
    _ = check task:scheduleOneTimeJob(new Job(0), time);

    // Waits for five seconds.
    runtime:sleep(5);
}
