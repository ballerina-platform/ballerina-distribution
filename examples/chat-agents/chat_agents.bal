import ballerina/ai;
import ballerina/http;
import ballerina/time;
import ballerina/uuid;

// Declare a service attached to an `ai:Listener` listener 
// to interact with the agent.
service /tasks on new ai:Listener(8080) {
    resource function post chat(@http:Payload ai:ChatReqMessage request) 
						returns ai:ChatRespMessage|error {
        string response = check taskAssistantAgent.run(request.message, request.sessionId);
        return {message: response};
    }
}

type Task record {|
    string description;
    time:Date dueBy?;
    time:Date createdAt = time:utcToCivil(time:utcNow());
    time:Date completedAt?;
    boolean completed = false;
|};

// Simple in-memory task management.
isolated map<Task> tasks = {
    "a2af0faa-3b73-4184-9be1-87b29a963be6": {
        description: "Buy groceries",
        dueBy: time:utcToCivil(time:utcAddSeconds(time:utcNow(), 60 * 5))
    }
};

// Define the functions that the agent can use as tools.
// The LLM will identify the arguments to pass to these functions
// based on the user input and the tool (function) signatures.
@ai:AgentTool
isolated function addTask(string description, time:Date? dueBy) returns error? {
    lock {
        tasks[uuid:createRandomUuid()] = {description, dueBy: dueBy.clone()};
    }
}

@ai:AgentTool
isolated function listTasks() returns Task[] {
    lock {
        return tasks.toArray().clone();
    }
}

@ai:AgentTool
isolated function getCurrentDate() returns time:Date {
    time:Civil {year, month, day} = time:utcToCivil(time:utcNow());
    return {year, month, day};
}

// Define an AI agent with a system prompt and a set of tools.
// The agent will use these tools to help manage a task list,
// following the system prompt instructions.
final ai:Agent taskAssistantAgent = check new ({
    systemPrompt: {
        role: "Task Assistant",
        instructions: string `You are a helpful assistant for 
            managing a to-do list. You can manage tasks and
            help a user plan their schedule.`
    },
    // Specify the functions the agent can use as tools.
    tools: [addTask, listTasks, getCurrentDate],
    // Use the default model provider (with configuration added
    // via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider()
});
