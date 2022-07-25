# Schedule job recurrence by frequency

A  `task:scheduleJobRecurByFrequency()` can be used to execute Ballerina jobs periodically.
The `task:Job` and interval should be specified and optional configurations are start time,
end time, and maximum count.
For more information on the underlying module, 
see the [Task module](https://lib.ballerina.io/ballerina/task/latest/).

::: code task_frequency_job_execution.bal :::

::: out task_frequency_job_execution.out :::