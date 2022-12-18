
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
        // The binding pattern below matches mappings that contain at least the fields with 
        // keys `hours` and `seconds`. The values of these fields can be accessed via the 
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

function matchTime3(Day r) {
    match r {
        // The pattern below matches a mapping that has a field with key `t` and a value that 
        // is another mapping that contains at least the fields with keys `hours` and `minutes`.
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
