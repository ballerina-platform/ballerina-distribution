import ballerina/io;

type Coordinates record {|
    decimal latitude;
    decimal longitude;
|};

isolated class Cities {

    final string country;

    // The initialization expression of a field of an
    // `isolated` object has to be an isolated expression,
    // which itself will be an isolated root.
    // E.g., expressions with an immutable static type,
    // simple literals, constructor expressions
    // in which all the subexpressions are isolated expressions, etc.
    private map<Coordinates> cities = {};

    function init(string country) {
        self.country = country;
    }

    function add(string city, Coordinates coordinates) {
        lock {
            // Where `self` is being used to access a mutable private
            // field, the access needs to be within a `lock` statement.
            if self.cities.hasKey(city) {
                io:println("An entry already exists for ", city);
                return;
            }

            // Any values transferred into the `lock` statement (and thereby,
            // the object) also need to be isolated expressions ensuring that
            // the object will continue to be an isolated root.
            // A `.clone()` or `.cloneReadOnly()` call is an isolated
            // expression.
            self.cities[city] = coordinates.clone();
        }

        // `self` can be used outside a `lock` statement if it is being
        // used to access a `final` field with a type that is a subtype
        // of `readonly` or `isolated object {}`.
        io:println("Added coordinates for ", city, ", ", self.country);
    }

    function getCoordinates(string city) returns Coordinates? {
        lock {
            // Similarly, transferring values out of the `lock` statement (and
            // thereby, the object) either using a `return` statement or by
            // assigning to a variable defined outside the `lock` statement
            // is also constrained. The expressions that are transferring values
            // out need to be isolated expressions.
            return self.cities[city].clone();
        }
    }

    function getAllCoordinates() returns string[] {
        lock {
            // A method which accesses the `self` variable, other than to
            // access a `final` field of a type that is a subtype of
            // `readonly` or `isolated object {}`, can call another
            // function/method only if that function/method is `isolated`.
            return formatCoordinates(self.cities).clone();
        }
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
    Cities cities = new ("Sri Lanka");

    cities.add("Colombo", {latitude: 6.9271, longitude: 79.8612});
    cities.add("Kandy", {latitude: 7.2906, longitude: 80.6337});

    io:println(cities.getAllCoordinates());
}
