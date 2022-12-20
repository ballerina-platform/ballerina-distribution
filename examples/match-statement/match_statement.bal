import ballerina/io;

const switchStatus = "ON";

function matchValue(any val) returns string {
    // The value of the `val` variable is matched against the given value match patterns.
    match val {
        1 => {
            return "Move forward";
        }
        // use | to match more than one value
        2|3 => {
            return "Turn";
        }
        "STOP" => {
            return "STOP";
        }
        switchStatus => {
            return "Switch ON";
        }
        // use _ to match type any
        _ => {
            return "Invalid instruction";
        }
    }

}

public function main() {
    io:println(matchValue(1));
    io:println(matchValue(2));
    io:println(matchValue("STOP"));
    io:println(matchValue(switchStatus));
    io:println(matchValue("default"));
}
