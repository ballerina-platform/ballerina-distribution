import ballerina/io;
import ballerina/task;
import ballerina/time;

// Creating a job to be executed by the scheduler.
class Job {

    *task:Job;
    int i = 1;

    // Get executed by the scheduler when the scheduled trigger fires.
    public function execute() {
        self.i += 1;
        io:println("MyCounter: ", self.i);
    }

    isolated function init(int i) {
        self.i = i;
    }
}

public function main() returns error? {
    // Get the current time.
    time:Utc currentUtc = time:utcNow();
    // Increase the time by three seconds.
    time:Utc newTime = time:utcAddSeconds(currentUtc, 3);
    // Get the `time:Civil` for the given time.
    time:Civil time = time:utcToCivil(newTime);

    // Schedule the one-time job.
    JobId result = check scheduleOneTimeJob(new Job(5), time);

    // Wait for five seconds.
    runtime:sleep(5);
}
