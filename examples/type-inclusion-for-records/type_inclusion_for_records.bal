import ballerina/io;

type Date record {
    int year;
    int month;
    int day;
};

type TimeOfDay record {
    int hour;
    int minute;
    decimal seconds;
};

// `Time` record has all the fields of `Date` and `TimeOfDay`.
type Time record {
    *Date;
    *TimeOfDay;
};

public function main() {
    Time time = {year: 2022, month: 8, day: 20, hour: 8, minute: 12, seconds: 3};
    io:println(time);
}
