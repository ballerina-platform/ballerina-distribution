import ballerina/io;
 
// Closed type.
type ClosedCoord record {|
    string name;
    [float, float] cords;
|};
 
// Open type can have additional `anydata` fields.
type OpenCoord record {
    string name;
    [float, float] cords;
};
 
public function main() {
    ClosedCoord a = {name: "Colombo", cords: [6.95, 79.84]};
    // The conversion happens automatically because `a` is a subtype of `anydata`.
    json j = a;
    io:println(j);
    
    OpenCoord b = {name: "Colombo", cords: [6.94, 79.83], "area": "03"};
    // Use `toJson()` to convert `anydata` to `json`.
    // Usually happens automatically with closed records.
    json k = b.toJson();
    io:println(k);
}
