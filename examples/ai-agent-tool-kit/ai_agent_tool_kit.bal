import ballerina/ai;
import ballerina/io;
import ballerina/time;
import ballerina/uuid;

type Task record {|
    string description;
    time:Date dueBy?;
    time:Date createdAt = time:utcToCivil(time:utcNow());
    time:Date completedAt?;
    boolean completed = false;
|};

// A tool kit to manage a set of tasks.
public isolated class TaskManagerToolkit {
    *ai:BaseToolKit;
    
    private final map<Task> tasks = {};

    // The `getTools` method describes the tools provided by this tool kit.
    public isolated function getTools() returns ai:ToolConfig[] => [
        // The JSON schema for the `addTask` tool.
        {
            name: "addTask",
            description: "Add a new task to the to-do list",
            parameters: {
                'type: "object",
                properties: {
                    description: {'type: "string", description: "Description of the task"},
                    dueBy: {
                        'type: "object",
                        description: "Due date for the task",
                        properties: {
                            year: {'type: "integer"},
                            month: {'type: "integer"},
                            day: {'type: "integer"}
                        },
                        required: ["year", "month", "day"]
                    }
                },
                required: ["description"]
            },
            // Refer to the method that is this tool.
            caller: self.addTask
        },
        {
            name: "listTasks",
            description: "List all current tasks",
            caller: self.listTasks
        }
    ];
    
    // Tool to add a new task.
    @ai:AgentTool
    isolated function addTask(string description, time:Date? dueBy = ()) {
        lock {
            self.tasks[uuid:createRandomUuid()] = {
                description: description, 
                dueBy: dueBy.clone()
            };
        }
    }

    // Tool to list all current tasks.
    @ai:AgentTool
    isolated function listTasks() returns map<Task> {
        lock {
            return self.tasks.clone();
        }
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
    // Include the tool kit in tools the agent can use.
    tools: [new TaskManagerToolkit(), getCurrentDate],
    // Use the default model provider (with configuration added
    // via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    maxIter: 10
});

public function main() returns error? {
    while true {
        string userInput = io:readln("User (or 'exit' to quit): ");
        if userInput == "exit" {
            break;
        }
        // Pass the user input to the agent and get a response.
        string response = check taskAssistantAgent.run(userInput);
        io:println("Agent: ", response);
    }
}
