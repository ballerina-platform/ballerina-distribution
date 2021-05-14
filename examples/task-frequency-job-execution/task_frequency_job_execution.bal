import ballerina/io;
import ballerina/lang.runtime;
import ballerina/task;
import ballerina/time;

// Creating a job to be executed by the scheduler.
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
    // Increases the time by three seconds to set the starting delay for the scheduling job.
    time:Utc newTime = time:utcAddSeconds(currentUtc, 3);
    // Get the `time:Civil` for the given time.
    time:Civil time = time:utcToCivil(newTime);

    // Schedules the task to execute the job every second.
    task:JobId id = check task:scheduleJobRecurByFrequency(new Job(0),
                                        1, startTime = time);

    // Waits for twelve seconds.
    runtime:sleep(12);

    // Unschedules the job.
    check task:unscheduleJob(id);
}
