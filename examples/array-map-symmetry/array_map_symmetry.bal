import ballerina/io;

public function main() {
    // List constructors are used to construct list values.
    string[] list = ["foo", "bar"];

    // Mapping constructors are used to construct map values.
    map<int> 'map = {x: 1, y: 2};

    // Indexing in arrays and maps is used to access elements.
    string listIndex = list[0];
    io:println(listIndex);

    // Mappings are indexed by strings.
    int? mapIndex = 'map["x"];
    io:println(mapIndex);

    // A tuple type can be used to define per-index member types in a list.
    [int, string, boolean] _ = [1, "John", true];

    // A record type can be used to define per-index member types in a mapping.
    record {
        int id;
        string name;
        boolean checked;
    } _ = {id: 1, name: "John", checked: true};

    // Declares an open type as a tuple type.
    [int, string, boolean...] openList = [1, "John", true, false];
    io:println(openList);

    // Declares an open type as a record type.
    record {|
        int id;
        string name;
        boolean...;
    |} openRecord = {id: 1, name: "John"};
    
    io:println(openRecord);
}
