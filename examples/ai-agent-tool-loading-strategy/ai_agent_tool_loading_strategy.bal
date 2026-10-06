import ballerina/ai;
import ballerina/io;

final ai:Agent hrAgent = check new ({
    systemPrompt: {
        role: "HR Assistant",
        instructions: "You help employees with HR tasks using the available tools. Keep answers brief."
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    tools: [getLeaveBalance, requestLeave, getPublicHolidays, getPayslip, updateBankAccount,
            getTrainingCourses, enrollInCourse, getManager],
    // With `ai:NO_FILTER` (the default), the schemas of all tools are sent to the LLM with every request.
    // With `ai:LLM_FILTER`, only the tool names and descriptions are sent first; the LLM selects
    // the tools relevant to the query, and only their full schemas are then loaded. This reduces the
    // prompt size for agents with many tools.
    toolLoadingStrategy: ai:LLM_FILTER
});

public function main() returns error? {
    string response = check hrAgent.run("How many leave days do I have left? My employee ID is E-1001.");
    io:println(response);
    response = check hrAgent.run("Enroll me (E-1001) in the Cloud Security course and tell me who my manager is.");
    io:println(response);
}

// A set of tools for an HR assistant. Each tool has a short description (from the doc comment),
// which is what the LLM sees first when the `ai:LLM_FILTER` tool loading strategy is used.

# Gets the remaining annual leave balance of an employee.
# + employeeId - The employee ID
# + return - The number of remaining leave days
@ai:AgentTool
isolated function getLeaveBalance(string employeeId) returns int => 12;

# Submits a leave request for an employee.
# + employeeId - The employee ID
# + fromDate - The start date in YYYY-MM-DD format
# + toDate - The end date in YYYY-MM-DD format
# + return - A confirmation message
@ai:AgentTool
isolated function requestLeave(string employeeId, string fromDate, string toDate) returns string
    => string `Leave request submitted for ${employeeId} from ${fromDate} to ${toDate}`;

# Gets the upcoming public holidays.
# + return - The dates of the upcoming public holidays
@ai:AgentTool
isolated function getPublicHolidays() returns string[] => ["2026-12-25", "2027-01-01"];

# Gets the payslip summary of an employee for a month.
# + employeeId - The employee ID
# + month - The month in YYYY-MM format
# + return - The payslip summary
@ai:AgentTool
isolated function getPayslip(string employeeId, string month) returns string
    => string `Payslip for ${employeeId} (${month}): gross 5000.00, net 4100.00`;

# Updates the bank account of an employee.
# + employeeId - The employee ID
# + accountNumber - The new bank account number
# + return - A confirmation message
@ai:AgentTool
isolated function updateBankAccount(string employeeId, string accountNumber) returns string
    => string `Bank account of ${employeeId} updated`;

# Gets the training courses available to employees.
# + return - The names of the available courses
@ai:AgentTool
isolated function getTrainingCourses() returns string[] => ["Ballerina Fundamentals", "Cloud Security"];

# Enrolls an employee in a training course.
# + employeeId - The employee ID
# + course - The name of the course
# + return - A confirmation message
@ai:AgentTool
isolated function enrollInCourse(string employeeId, string course) returns string
    => string `${employeeId} enrolled in ${course}`;

# Gets the manager of an employee.
# + employeeId - The employee ID
# + return - The name of the manager
@ai:AgentTool
isolated function getManager(string employeeId) returns string => "Jane Perera";
