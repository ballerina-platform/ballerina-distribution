
import ballerina/io;

type Time record {
    int hours;
    int minutes;
};

type Day record {
    Time t;
};

function matchTime1(Time pair) {
    match pair {
        // The binding pattern below matches the mappings that contain at least the fields with 
        // the `hours` and `seconds` keys. The values of these fields can be accessed via the 
        // `hours` and `seconds` variables within this block.
        var {hours, minutes} => {
            io:println(hours, ", ", minutes);
        }
    }
}

function matchTime2(Time time) {
    match time {
        // The binding pattern below  has a rest binding pattern to capture the additional 
        // fields that may be specified in the open record value assigned to the `time` variable.
        // Type of the `rest` variable can be considered a map of `anydata`. However, it cannot 
        // contain the `hours` or `minutes` keys.
        var {hours, minutes, ...rest} => {
            io:println(hours, ", ", minutes, ", ", rest);
        }
    }
}

function matchTime3(Day day) {
    match day {
        // The pattern below matches a mapping that has a field with the `t`key
        // and a value, which is another mapping that contains at least the fields 
        // with the `hours` and `minutes` keys.
        var {t: {hours, minutes}} => {
            io:println(hours, ", ", minutes);
        }
    }
}

public function main() {
    Time time = {hours: 3, minutes: 20, "seconds": 40, "milli-seconds": 500};
    matchTime1(time);
    matchTime2(time);

    Day day = {t: time};
    matchTime3(day);
}
