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
    int precipitation_chance;
    int wind_speed;
|};

type WeatherForecast record {|
    string location;
    ForecastItem[] forecast;
|};

// Define an MCP service attached to the MCP listener on port 9090.
listener mcp:Listener mcpListener = new (9090);

service mcp:Service /mcp on mcpListener {

    // The remote methods defined in this service become MCP tools.
    // The MCP listener handles listing and calling the tools on MCP requests.
    // The tool descriptions and schema are generated from the method signatures 
    // and the documentation.
    # Get current weather for a city.
    # 
    # + city - City name (e.g., "New York", "Tokyo")
    # + return - Current weather data for the specified city
    remote function getCurrentWeather(string city) returns Weather|error {
        Weather mockWeather = {
            condition: "Sunny",
            humidity: check random:createIntInRange(30, 70),
            location: city,
            pressure: check random:createIntInRange(1000, 1025),
            temperature: <decimal> check random:createIntInRange(15, 30),
            timestamp: time:utcToString(time:utcNow())
        };
        log:printInfo(string `Weather data retrieved for ${
                        city}: ${mockWeather.condition}, ${mockWeather.temperature}°C`);
        return mockWeather;
    };

    # Get weather forecast for upcoming days.
    #
    # + location - City name or coordinates (e.g., "London", "40.7128,-74.0060") 
    # + days - Number of days to forecast (1 - 7)
    # + return - Weather forecast for the specified location and days
    remote function getWeatherForecast(string location, int days) returns WeatherForecast|error {
        WeatherForecast mockForecast = {
            forecast: check getMockForecastItems(days), 
            location
        };
        log:printInfo(string `Forecast generated for ${location}: ${days} days with random data`);
        return mockForecast;
    }
}

function getMockForecastItems(int days) returns ForecastItem[]|error {
    string[] conditions = ["Sunny", "Cloudy", "Rainy", "Windy", "Stormy", "Snowy"];
    return from int i in 1 ... days
        select {
            condition: conditions[check random:createIntInRange(0, conditions.length() - 1)],
            date: time:utcToString(time:utcAddSeconds(time:utcNow(), i * 86400)),
            high: check random:createIntInRange(20, 30),
            low: check random:createIntInRange(10, 20),
            precipitation_chance: check random:createIntInRange(10, 50),
            wind_speed: check random:createIntInRange(5, 20)
        };
}
