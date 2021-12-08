import ballerina/io;
import ballerina/lang.runtime;
import ballerina/task;
import ballerina/time;

// Creates a job to be executed by the scheduler.
class Job {

    *task:Job;
    int i = 1;
    string jobIdentifier;

    // Executes this function when the scheduled trigger fires.
    public function execute() {
        self.i += 1;
        io:println(self.jobIdentifier + ", MyCounter: ", self.i);
    }

    isolated function init(int i, string jobIdentifier) {
        self.i = i;
        self.jobIdentifier = jobIdentifier;
    }
}

public function main() returns error? {

    // Gets the current time.
    time:Utc currentUtc = time:utcNow();
    // Increases the time by three seconds to set the starting delay for the scheduling job.
    time:Utc newTime = time:utcAddSeconds(currentUtc, 5);
    // Gets the `time:Civil` for the given time.
    time:Civil time = time:utcToCivil(newTime);

    // Schedules the tasks to execute the job every second.
    task:JobId id1 = check task:scheduleJobRecurByFrequency(
                            new Job(0, "1st Job"), 1);
    task:JobId id2 = check task:scheduleJobRecurByFrequency(
                            new Job(0, "2nd Job"), 3);
    // Schedules the one-time job at the specified time.
    _ = check task:scheduleOneTimeJob(new Job(0, "3rd Job"), time);

    // Waits for 3 seconds.
    runtime:sleep(3);

    // Gets all the running jobs.
    task:JobId[] result = task:getRunningJobs();
    io:println("No of running jobs: ", result.length());

    // Pauses the specified job.
    check task:pauseJob(id1);
    io:println("Pasused the 1st job.");
    // Waits for 3 seconds.
    runtime:sleep(3);

    // Resumes the specified job.
    check task:resumeJob(id1);
    io:println("Resumed the 1st job.");

    // Gets all the running jobs.
    result = task:getRunningJobs();
    io:println("No of running jobs: ", result.length());

     // Waits for 3 seconds.
    runtime:sleep(3);

    // Unschedules the jobs.
    check task:unscheduleJob(id1);
    check task:unscheduleJob(id2);
}
