import ballerina/io;

// The `SwitchStatus` type is a union type of two singleton types
// defined using string literals, which are simple constant expressions.
type SwitchStatus "on"|"off";

// The `shouldToggleSwitch` function has two parameters of the `SwitchStatus` type,
// restricting the arguments to be either "on" or "off". Trying to pass as an argument 
// a value that cannot be guaranteed to be either "on" or "off"  will result
// in a compile-time error.
function shouldToggleSwitch(SwitchStatus currentStatus, SwitchStatus newStatus) 
        returns boolean {
    return currentStatus != newStatus;
}

// The type of the `STATUS_OFF` constant is the singleton type containing only 
// the "off" value.
const STATUS_OFF = "off";

// The type of the `DEFAULT_CONFIG` constant is the singleton type containing only 
// an immutable mapping value with exactly two fields: a `name` field with the value 
// "default" and a `status` field with the value "off".
const DEFAULT_CONFIG = {
    name: "default",
    status: STATUS_OFF
};

public function main() {
    // The `shouldToggleSwitch` function can be called only with "on" or "off" as arguments.
    boolean b1 = shouldToggleSwitch("on", "off");
    io:println(b1);

    // The type of `arg1` is the singleton type containing only the "off" value.
    "off" arg1 = "off";

    // A constant can be used as a singleton type.
    // The type of `arg2` is also the singleton type containing only the "off" value.
    // On the left-hand side, `STATUS_OFF` is used as a type.
    // On the right-hand side, `STATUS_OFF` is used as a value.
    STATUS_OFF arg2 = STATUS_OFF;

    boolean b2 = shouldToggleSwitch(arg1, arg2);
    io:println(b2);

    // An immutable mapping value that has exactly the same fields as the
    // `DEFAULT_CONFIG` constant.
    map<json> & readonly mv1 = {
        name: "default",
        status: "off"
    };

    // An immutable mapping value that is not the same as the `DEFAULT_CONFIG`
    // value since it has "on" as the value for the `status` field.
    map<json> & readonly mv2 = {
        name: "default",
        status: "on"
    };

    // The `DEFAULT_CONFIG` constant is used as a type in the `is` check.
    // Since it is a singleton type, the `is` check will evaluate to true
    // only for an immutable value that has exactly the same fields.
    io:println(mv1 is DEFAULT_CONFIG);
    io:println(mv2 is DEFAULT_CONFIG);
}
