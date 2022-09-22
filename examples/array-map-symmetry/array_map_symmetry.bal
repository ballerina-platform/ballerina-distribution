import ballerina/io;

public function main() {
    // List constructors are used to construct list values.
    // Arrays are lists with a uniform member type.
    string[] list = ["foo", "bar"];

    // Mapping constructors are used to construct mapping values.
    // Maps are mappings with a uniform member type.
    map<int> mapping = {x: 1, y: 2};

    // Indexing is used with lists and mappings to access members.
    // Index type of lists is `int`.
    string listMember = list[0];
    io:println(listMember);

    // Index type of mappings is `string`.
    int? mapIndex = mapping["x"];
    io:println(mapIndex);

    // A tuple type can be used to define per-index member types in a list.
    [int, string, boolean] tuple = [1, "John", true];

    int firstTupleMember = tuple[0];
    string secondTupleMember = tuple[1];
    boolean thirdTupleMember = tuple[2];

    io:println(`Tuple [${firstTupleMember}, ${secondTupleMember}, ${thirdTupleMember}]`);

    // A record type can be used to define per-index member types in a mapping.
    record {
        int id;
        string name;
        boolean checked;
    } rec = {id: 1, name: "John", checked: true};

    int id = rec.id;
    string name = rec.name;
    boolean checked = rec.checked;

    io:println(`record {id: ${id}; name: ${name}; checked: ${checked}}`);

    // Declares a tuple type as an open type.
    // Tuple type with zero or more boolean values after the first two members.
    [int, string, boolean...] openList = [1, "John"];
    io:println(openList);

    [int, string, boolean...] openList2 = [1, "John", true, false];
    io:println(openList2);

    // Declares a record type as an open type.
    // Record type with zero or more boolean fileds after the first two fields.
    record {|
        int id;
        string name;
        boolean...;
    |} openRecord = {id: 1, name: "John"};
    io:println(openRecord);

    record {|
        int id;
        string name;
        boolean...;
    |} openRecord2 = {id: 1, name: "John", "checked": true};
    io:println(openRecord2);
}
