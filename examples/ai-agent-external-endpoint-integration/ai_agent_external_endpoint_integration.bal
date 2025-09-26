import ballerina/ai;
import ballerina/io;
import ballerinax/googleapis.calendar;
import ballerinax/googleapis.gmail;

// Configuration for external endpoints.
configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshUrl = ?;

configurable string userEmail = ?;

// Create clients for Gmail and Calendar APIs.
final gmail:Client gmailClient = check new ({
    auth: {refreshToken: refreshToken, clientId, clientSecret, refreshUrl}
});

final calendar:Client calendarClient = check new (config = {
    auth: {clientId, clientSecret, refreshToken: refreshToken, refreshUrl}
});

// Define tools for the agent to interact with Gmail and Calendar APIs.
@ai:AgentTool
isolated function readUnreadEmails() returns gmail:Message[]|error {
    gmail:ListMessagesResponse messageList =
        check gmailClient->/users/me/messages(q = "label:INBOX is:unread");
    gmail:Message[]? messages = messageList.messages;

    if messages is () {
        return [];
    }

    gmail:Message[] completeMessages = from gmail:Message message in messages
        select check gmailClient->/users/me/messages/[message.id](format = "full");
    return completeMessages;
}

@ai:AgentTool
isolated function sendEmail(string[] to, string subject, string body) 
        returns gmail:Message|error {
    return gmailClient->/users/me/messages/send.post({to, subject, bodyInText: body});
}

@ai:AgentTool
isolated function getCalendarEvents() 
        returns stream<calendar:Event, error?>|error {
    return calendarClient->getEvents(userEmail);
}

@ai:AgentTool
isolated function createCalendarEvent(calendar:InputEvent event) 
        returns calendar:Event|error {
    return calendarClient->createEvent(userEmail, event);
}

final ai:Agent personalAssistantAgent = check new (
    systemPrompt = {
        role: "Personal Assistant",
        instructions: string `You are an intelligent personal AI assistant 
            designed to help users stay organized and efficient. You have 
            access to the user's email and calendar through secure API 
            integrations.
            
            Your tasks may require reading and summarizing unread emails,
            sending emails on behalf of the user, helping schedule meetings, 
            and managing calendar events.

            When interacting with the user, always adhere to the following:
            - Respond in a natural and professional tone.
            - Always confirm before making changes to the user's calendar or 
                sending emails.
            - Provide concise summaries when retrieving information unless the 
                user requests details.
            - Prioritize clarity, efficiency, and user convenience in all tasks.`
    },
    // Use the default model provider (with configuration added via a 
    // Ballerina VS Code command).
    model = check ai:getDefaultModelProvider(),
    // Specify the tools the agent can use.
    tools = [readUnreadEmails, sendEmail, getCalendarEvents, createCalendarEvent]
);

public function main() returns error? {
    while true {
        string userInput = io:readln("User (or 'exit' to quit): ");
        if userInput == "exit" {
            break;
        }
        // Pass the user input to the agent and get a response.
        string response = check personalAssistantAgent.run(userInput);
        io:println("Agent: ", response);
    }
}
