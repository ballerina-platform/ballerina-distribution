import ballerina/io;

type Person record {|
    int id;
    string fname;
    string lname;
|};

public function main() {
    int sum = 0;
    string names = "";
    [string, int][] personInfoList = getPersonInfo();
    Person[] personList = getPersonList();

    // The values in the `personInfoList` is bound to the `[name, age]` list binding for each iteration.
    foreach [string, int] [name, age] in personInfoList {
        names += " " + name;
        sum += age;
    }
    io:println("Average age of", names, ": ", sum / 3);

    // The mapping binding pattern used in the `from` clause binds the record fields with the
    // specified variable names for every value in the `personList`.
    var personInfo = from var {id: personId, fname: firstName, lname: lastName} in personList
        select {
            id: personId,
            name: firstName + " " + lastName
        };
    io:println(personInfo);
}

function getPersonInfo() returns [string, int][] {
    return [["John", 30], ["Anne", 24], ["Mike", 21]];
}

function getPersonList() returns Person[] {
    return [{id: 1001, fname: "Anne", lname: "Frank"}, {id: 1002, fname: "John", lname: "Hardy"}];
}
