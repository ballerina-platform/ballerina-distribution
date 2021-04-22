import ballerina/io;

type Coordinates record {|
    decimal latitude;
    decimal longitude;
|};

// The initialization expression of an `isolated` variable
// has to be an isolated expression, which itself will be
// an isolated root.
// E.g., expressions with an immutable static type,
// simple literals, constructor expressions
// in which all the subexpressions are isolated expressions, etc.
isolated map<Coordinates> cities = {};

function add(string city, Coordinates coordinates) {
    lock {
        // An `isolated` variable can be accessed within a `lock` statement.
        if cities.hasKey(city) {
            io:println("An entry already exists for ", city);
            return;
        }

        // Any values transferred into the `lock` statement also need to be
        // isolated expressions ensuring that the variable will continue
        // to be an isolated root.
        cities[city] = coordinates.clone();
    }

    io:println("Added coordinates for ", city);
}

function getCoordinates(string city) returns Coordinates? {
    lock {
        // Similarly, transferring values out of the `lock` statement
        // either using a `return` statement or by assigning to a variable
        // defined outside the `lock` statement is also
        // constrained. The expressions that transfer values out need to be
        // isolated expressions.
        return cities[city].clone();
    }
}

function getAllCoordinates() returns string[] {
    lock {
        // A function/method call within a `lock` statement that accesses an
        // `isolated` variable should call a function/method that is
        // `isolated`.
        return formatCoordinates(cities).clone();
    }
}

isolated function formatCoordinates(map<Coordinates> cities) returns string[] {
    string[] formattedCoordinates = [];

    foreach [string, Coordinates] [city, coords] in cities.entries() {
        formattedCoordinates.push(
            string `${city} - ${coords.latitude}° N, ${coords.longitude}° E`);
    }

    return formattedCoordinates;
}

public function main() {
    add("Colombo", {latitude: 6.9271, longitude: 79.8612});
    add("Kandy", {latitude: 7.2906, longitude: 80.6337});

    io:println(getAllCoordinates());
}
