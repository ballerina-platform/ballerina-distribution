import ballerina/io;
import ballerina/lang.value as value;

// Define a variable of type `json` that holds a mapping value.
json j = {
    x: {
        y: {
            z: "ballerina"
        }
    }
};

// Field access is allowed on the `json`-typed variable. However, the return
// type would be a union of `json` and `error`.
json v = check j.x.y;
string s1 = check v.z;

// `ensureType` method can also be used to perform conversions.
string s2 = check value:ensureType(v.z, string);

public function main() {
    io:println("Value of s1: " + s1);
    io:println("Value of s2: " + s2);
}
