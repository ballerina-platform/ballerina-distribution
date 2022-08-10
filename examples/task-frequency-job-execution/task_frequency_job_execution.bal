import ballerina/io;
import ballerina/lang.runtime;
import ballerina/task;

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

    // Schedules the task to execute the job every second.
    task:JobId id = check task:scheduleJobRecurByFrequency(new Job(0), 1);

    // Waits for nine seconds.
    runtime:sleep(9);

    // Unschedules the job.
    check task:unscheduleJob(id);
}
