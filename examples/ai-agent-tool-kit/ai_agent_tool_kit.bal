import ballerina/ai;
import ballerina/http;
import ballerina/io;
import ballerina/time;
import ballerina/uuid;

type Task record {|
    string id;
    string description;
    time:Date dueBy?;
    boolean completed = false;
|};

type NewTask record {|
    string description;
    time:Date dueBy?;
|};

// The tools that the toolkit provides.
public enum TaskTool {
    LIST_TASKS = "listTasks",
    ADD_TASK = "addTask",
    COMPLETE_TASK = "completeTask"
}

// A toolkit for a task management REST API. The toolkit owns the HTTP client, so the API
// credentials never reach the LLM, and its `init` parameters decide which tools the agent gets.
public isolated class TaskManagerToolkit {
    *ai:BaseToolKit;

    private final http:Client taskApi;
    private final readonly & ai:ToolConfig[] tools;

    # Initializes the toolkit.
    # + serviceUrl - The URL of the task management API
    # + auth - The bearer token configuration used to authenticate with the API
    # + permittedTools - The tools to give the agent, or `()` to give all the tools
    # + readOnly - Whether to give the agent only the tools that do not change the tasks
    # + return - An error if the initialization fails
    public isolated function init(string serviceUrl, http:BearerTokenConfig auth,
            TaskTool[]? permittedTools = (), boolean readOnly = false) returns error? {
        self.taskApi = check new (serviceUrl, {auth});
        // The `ai:getToolConfigs` function generates the tool configurations for the specified
        // tools, which the toolkit then filters based on its configuration. The names of the
        // tools are the names of the methods, which are the values of `TaskTool`.
        ai:ToolConfig[] allTools = ai:getToolConfigs([self.listTasks, self.addTask, self.completeTask]);
        self.tools = from ai:ToolConfig tool in allTools
            let TaskTool toolName = check tool.name.ensureType()
            where (permittedTools is () || permittedTools.indexOf(toolName) != ())
                && (!readOnly || toolName == LIST_TASKS)
            select tool.cloneReadOnly();
    }

    // The `getTools` method returns the tools provided by this toolkit.
    public isolated function getTools() returns ai:ToolConfig[] => self.tools;

    # Lists all the tasks.
    # + return - The tasks, or an error if the request fails
    @ai:AgentTool
    isolated function listTasks() returns Task[]|error {
        return self.taskApi->/tasks;
    }

    # Adds a new task.
    # + description - The description of the task
    # + dueBy - The date by which the task should be completed
    # + return - The added task, or an error if the request fails
    @ai:AgentTool
    isolated function addTask(string description, time:Date? dueBy = ()) returns Task|error {
        NewTask newTask = dueBy is () ? {description} : {description, dueBy};
        return self.taskApi->/tasks.post(newTask);
    }

    # Marks a task as completed.
    # + id - The ID of the task
    # + return - The completed task, or an error if the request fails
    @ai:AgentTool
    isolated function completeTask(string id) returns Task|error {
        return self.taskApi->/tasks/[id]/complete.post({});
    }
}

@ai:AgentTool
isolated function getCurrentDate() returns time:Date {
    time:Civil {year, month, day} = time:utcToCivil(time:utcNow());
    return {year, month, day};
}

configurable string taskApiToken = "task-api-token";

public function main() returns error? {
    // Start a mock task management API on port 9095 so that the example is self-contained.
    http:Listener taskApiListener = check new (9095);
    check taskApiListener.attach(createTaskApi(taskApiToken), "api");
    check taskApiListener.'start();

    // Include the toolkit in the tools of the agent. This agent can list and add tasks,
    // but it does not get the tool that completes tasks.
    TaskManagerToolkit taskManager = check new ("http://localhost:9095/api", {token: taskApiToken},
        permittedTools = [LIST_TASKS, ADD_TASK]);
    io:println("Task tools: ", from ai:ToolConfig tool in taskManager.getTools() select tool.name);

    ai:Agent taskAssistantAgent = check new ({
        systemPrompt: {
            role: "Task Assistant",
            instructions: string `You are a helpful assistant for
                managing a to-do list. You can manage tasks and
                help a user plan their schedule. Use the current
                date to resolve dates such as today or the 30th.`
        },
        tools: [taskManager, getCurrentDate],
        // Use the default model provider (with configuration added
        // via a Ballerina VS Code command).
        model: check ai:getDefaultModelProvider()
    });

    while true {
        string userInput = io:readln("User (or 'exit' to quit): ");
        if userInput == "exit" {
            break;
        }
        // Pass the user input to the agent and get a response.
        string response = check taskAssistantAgent.run(userInput);
        io:println("Agent: ", response);
    }
    check taskApiListener.gracefulStop();
}

// Creates the mock task management API, which requires a bearer token.
function createTaskApi(string token) returns http:Service {
    return isolated service object {
        private final map<Task> tasks = {};

        resource function get tasks(@http:Header string authorization) returns Task[]|http:Unauthorized {
            if authorization != "Bearer " + token {
                return http:UNAUTHORIZED;
            }
            lock {
                return self.tasks.toArray().clone();
            }
        }

        resource function post tasks(@http:Header string authorization, @http:Payload NewTask newTask)
                returns Task|http:Unauthorized {
            if authorization != "Bearer " + token {
                return http:UNAUTHORIZED;
            }
            Task task = {id: uuid:createRandomUuid(), ...newTask};
            lock {
                self.tasks[task.id] = task.clone();
            }
            return task;
        }

        resource function post tasks/[string id]/complete(@http:Header string authorization)
                returns Task|http:Unauthorized|http:NotFound {
            if authorization != "Bearer " + token {
                return http:UNAUTHORIZED;
            }
            lock {
                Task? task = self.tasks[id];
                if task is () {
                    return http:NOT_FOUND;
                }
                task.completed = true;
                return task.clone();
            }
        }
    };
}
