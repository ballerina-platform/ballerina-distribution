import ballerina/ai;
import ballerina/http;
import ballerina/io;

// The credentials that identify this agent to the authorization server.
configurable string agentId = ?;
configurable string agentSecret = ?;

// The authorization server and the OAuth 2.0 client of the application.
configurable string baseAuthUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string redirectUri = ?;

final http:Client calendarApi = check new ("http://localhost:9090/calendar");

# Lists the meetings scheduled for a given date.
# + context - The context that carries the access token obtained for this tool
# + date - The date in the YYYY-MM-DD format
# + return - The scheduled meetings, or an error if the call fails
@ai:AgentTool {
    // Before this tool is invoked, the agent obtains an access token from the authorization
    // server using its own credentials, for the scopes listed here. The call to the external
    // service is therefore made as the agent, not with a shared long-lived key.
    auth: {
        baseAuthUrl,
        clientId,
        clientSecret,
        redirectUri,
        scopes: ["calendar_read"]
    }
}
isolated function listMeetings(ai:Context context, string date) returns json|error {
    // The agent puts the token it obtained for this tool into the context, under the tool name.
    string accessToken = check context.getAccessToken("listMeetings");
    return calendarApi->get(string `/meetings?date=${date}`,
            {Authorization: string `Bearer ${accessToken}`});
}

final ai:Agent schedulingAgent = check new ({
    systemPrompt: {
        role: "Scheduling Assistant",
        instructions: "You answer questions about the meetings on the user's calendar. Keep answers brief."
    },
    model: check ai:getDefaultModelProvider(),
    tools: [listMeetings],
    // The identity of the agent. Tool calls that require authorization are authorized against
    // this identity, so the actions of each agent can be authorized and audited separately.
    credential: {id: agentId, secret: agentSecret}
});

public function main() returns error? {
    string response = check schedulingAgent.run("What meetings do I have on 2026-09-24?");
    io:println(response);
}
