import ballerina/ai;
import ballerina/io;

# Represents a request to plan a trip.
type TripRequest record {|
    # The destination city
    string destination;
    # The number of days
    int days;
    # The traveller's interests
    string[] interests;
|};

# Represents the plan for a single day.
type DayPlan record {|
    # The day number, starting from 1
    int day;
    # A short title for the day
    string title;
    # The planned activities
    string[] activities;
|};

# Represents a trip itinerary.
type Itinerary record {|
    # The destination city
    string destination;
    # The plan for each day
    DayPlan[] days;
|};

# Gets the weather forecast for a city.
# + city - The city name
# + return - The weather forecast
@ai:AgentTool
isolated function getWeatherForecast(string city) returns string => "Mostly sunny, 22°C to 27°C";

final ai:Agent plannerAgent = check new ({
    systemPrompt: {
        role: "Trip Planner",
        instructions: "You plan trips for travellers based on their interests and the weather."
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    tools: [getWeatherForecast]
});

public function main() returns error? {
    // Typed input: the query can be any `anydata` value, such as a record, in addition to
    // a string or a prompt template. Structured input is serialized for the LLM.
    TripRequest request = {destination: "Kyoto", days: 2, interests: ["temples", "food"]};

    // Typed output: the `run` method is dependently typed. The expected type of the
    // result determines how the agent's final response is bound. The JSON schema of the
    // type is sent to the LLM, and the response is validated against it.
    Itinerary itinerary = check plannerAgent.run(request);
    io:println("Itinerary for ", itinerary.destination);
    foreach DayPlan dayPlan in itinerary.days {
        io:println(string `Day ${dayPlan.day}: ${dayPlan.title}`);
        foreach string activity in dayPlan.activities {
            io:println("  - ", activity);
        }
    }

    // The same agent can return a plain string when that is the expected type.
    string summary = check plannerAgent.run(`Summarize this itinerary in one sentence: ${itinerary}`);
    io:println("\nSummary: ", summary);
}
