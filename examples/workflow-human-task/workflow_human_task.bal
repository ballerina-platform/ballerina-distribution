import ballerina/http;
import ballerina/log;
import ballerina/workflow;
import ballerina/workflow.management;

// The result type of the human task. The runtime validates the submitted
// result against it.
type Approval record {|
    boolean approved;
|};

@workflow:Activity
function placeOrder(string item) returns string|error {
    log:printInfo("Placing order", item = item);
    return "PLACED";
}

@workflow:Workflow
function orderWorkflow(workflow:Context ctx, string item) returns string|error {
    // Create a human task and pause durably until a person completes it.
    // Only a user with the `manager` role can complete this task.
    Approval approval = check ctx->awaitHumanTask("approveOrder", {item},
            userRoles = "manager", title = "Approve the order");
    if !approval.approved {
        return "REJECTED";
    }
    return ctx->callActivity(placeOrder, {item});
}

service /orders on new http:Listener(9090) {

    // Starts a workflow instance for the order and returns its ID.
    resource function post .(@http:Payload string item) returns string|error {
        return workflow:run(orderWorkflow, item);
    }

    // Lists the pending human tasks of a workflow instance.
    resource function get [string id]/tasks()
            returns management:HumanTaskGroup[]|error {
        return management:listPendingHumanTasks(id);
    }

    // Completes a task as a `manager`. The workflow resumes with the result.
    resource function post tasks/[string taskId](Approval approval)
            returns error? {
        check workflow:completeHumanTask(taskId, approval, ["manager"]);
    }
}
