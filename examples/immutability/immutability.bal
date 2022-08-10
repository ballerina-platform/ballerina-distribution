import ballerina/io;

type Student record {|
    int grade;
    string name;
    map<int> marks;
|};

public function main() {
    // Creates an immutable `Student` value using an intersection
    // type with `readonly`.
    Student & readonly student = {

        grade: 12,
        name: "John",
        // The applicable contextually-expected type for `marks`
        // is now `map<int> & readonly`. Thus, the value for `marks`
        // will be constructed as an immutable map.
        marks: {
            "Maths": 75,
            "English": 90
        }

    };
    boolean x = student["marks"] is map<int> & readonly;
    io:println(x);
}
