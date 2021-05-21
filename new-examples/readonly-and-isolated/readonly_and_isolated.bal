import ballerina/io;

type Entry map<json>;
type RoMap readonly & map<Entry>;

final RoMap m = loadMap();

function loadMap() returns RoMap {
    readonly & Entry entry1 = {
        "munich": {latitude: "48.1351N", longtitude: "11.5820E"},
        "berlin": {latitude: "52.5200N", longtitude: "13.4050E"}
    };
    readonly & Entry entry2 = {
        "bordeaux": {latitude: "44.8378N", longtitude: "0.5792W"},
        "paris": {latitude: "48.8566N", longtitude: "2.3522E"}
    };
    RoMap roMap = {"germany": entry1, "france": entry2};
    return roMap;
}

isolated function lookup(string s) returns readonly & Entry? {
    // Accesses `m` directly without locking.
    return m[s];
}

public function main() {
    io:println(lookup("france"));
}

