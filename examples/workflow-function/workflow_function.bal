import ballerina/io;
import ballerina/workflow;

// A workflow is a durable function. The runtime records its progress, so a
// workflow resumes from where it stopped after a crash or a restart.
// The first parameter of a workflow is always the `workflow:Context`.
@workflow:Workflow
function greet(workflow:Context ctx, string name) returns string|error {
    return string `Hello, ${name}!`;
}

public function main() returns error? {
    // Start a new workflow instance. This returns the instance ID.
    string id = check workflow:run(greet, "Alice");

    // Wait for the instance to complete and read its result.
    string result = check workflow:waitForResult(id);
    io:println(result);
}
