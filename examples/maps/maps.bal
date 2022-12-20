import ballerina/io;

public function main() {
    // Creates a `map` constrained by the `int` type.
    map<int> age = {
        "Tom": 23,
        "Jack": 34
    };

    // Gets the entry for `Tom`.
    int? v = age["Tom"];
    io:println(v);

    // Adds a new entry for `Anne`.
    age["Anne"] = 19;

    // Since there exists an entry for `Tom`, it can be accessed using `map:get()` method. 
    // Using `age["Tom"]` wouldn't work here because its type would be `int?` and  not `int`.
    age["Anne"] = age.get("Jack");

    // `map:hasKey()` method checks whether the map `age` has a member with `Jack` as the key.
    if age.hasKey("Jack") {
        // The member with the key `Jack` can be removed using `map:remove()`.
        _ = age.remove("Jack");
    }

    // `map:keys()` returns the keys as an array of strings.
    foreach string name in age.keys() {
        io:println(name, " : ", age[name]);
    }
}
