import ballerina/log;
import ballerina/mcp;
import ballerina/random;
import ballerina/time;

type Weather record {|
    string location;
    decimal temperature;
    int humidity;
    int pressure;
    string condition;
    string timestamp;
|};

type ForecastItem record {|
    string date;
    int high;
    int low;
    string condition;
    int precipitationChance;
    int windSpeed;
|};

type WeatherForecast record {|
    string location;
    ForecastItem[] forecast;
|};

// Define an MCP service attached to the MCP listener on port 9090.
listener mcp:Listener mcpListener = new (9090);

// Note how the service is declared with the `mcp:AdvancedService` type.
service mcp:AdvancedService /mcp on mcpListener {

    isolated remote function onListTools() returns mcp:ListToolsResult|mcp:ServerError => {
        tools: [
            {
                name: "getCurrentWeather",
                description: "Get current weather conditions for a location",
                inputSchema: {
                    "type": "object",
                    "properties": {
                        "city": {
                            "type": "string",
                            "description": "City name or coordinates (e.g., 'London', '40.7128,-74.0060')"
                        }
                    },
                    "required": ["city"]
                }
            },
            {
                name: "getWeatherForecast",
                description: "Get a 5-day weather forecast for a location",
                inputSchema: {
                    "type": "object",
                    "properties": {
                        "city": {
                            "type": "string",
                            "description": "City name or coordinates (e.g., 'London', '40.7128,-74.0060')"
                        },
                        "days": {
                            "type": "integer",
                            "description": "Number of days to forecast",
                            "minimum": 1,
                            "maximum": 7
                        }
                    },
                    "required": ["city", "days"]
                }
            }
        ]
    };

    isolated remote function onCallTool(mcp:CallToolParams params, mcp:Session? session) 
            returns mcp:CallToolResult|mcp:ServerError {
        string name = params.name;
        do {
            if name == "getCurrentWeather" {
                // Attempt parsing the `arguments` field as a mapping consisting 
                // with fields for each parameter type.
                record {| string city; |} arguments = check params.arguments.cloneWithType();
                // Use the arguments in the function call.
                Weather weather = check getCurrentWeather(arguments.city);
                return {content: [{'type: "text", text: weather.toJsonString()}]};
            } 
            
            if name == "getWeatherForecast" {
                record {| string location; int days; |} {location, days} = check params.arguments.cloneWithType();
                WeatherForecast forecast = check getWeatherForecast(location, days);
                return {content: [{'type: "text", text: forecast.toJsonString()}]};
            }
        } on fail {
            return error("Invalid arguments");
        }
        
        return error("Unknown tool: " + name);
    }
}

isolated function getCurrentWeather(string city) returns Weather|error {
    Weather mockWeather = check getMockWeather(city);
    log:printInfo(string `Weather data retrieved for ${
                    city}: ${mockWeather.condition}, ${mockWeather.temperature}°C`);
    return mockWeather;
}

isolated function getWeatherForecast(string location, int days) returns WeatherForecast|error {
    WeatherForecast mockForecast = {
        forecast: check getMockForecastItems(days), 
        location
    };
    log:printInfo(string `Forecast generated for ${location}: ${days} days with random data`);
    return mockForecast;
}

isolated function getMockWeather(string city) returns Weather|error => {    
    condition: "Sunny",
    humidity: check random:createIntInRange(30, 70),
    location: city,
    pressure: check random:createIntInRange(1000, 1025),
    temperature: <decimal> check random:createIntInRange(15, 30),
    timestamp: time:utcToString(time:utcNow())
};

isolated function getMockForecastItems(int days) returns ForecastItem[]|error {
    string[] conditions = ["Sunny", "Cloudy", "Rainy", "Windy", "Stormy", "Snowy"];
    return from int i in 1 ... days
        select {
            condition: conditions[check random:createIntInRange(0, conditions.length() - 1)],
            date: time:utcToString(time:utcAddSeconds(time:utcNow(), i * 86400)),
            high: check random:createIntInRange(20, 30),
            low: check random:createIntInRange(10, 20),
            precipitationChance: check random:createIntInRange(10, 50),
            windSpeed: check random:createIntInRange(5, 20)
        };
}
