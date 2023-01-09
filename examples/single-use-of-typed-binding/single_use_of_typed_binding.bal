import ballerina/io;

type Person record {
    int id;
    string fname;
    string lname;
};

public function main() {
    // A typed list binding followed by `=` in which the values of the list members are bound to
    // `name` and `age` variables in the binding.
    [string, int] [name, age] = getPersonInfo();
    io:println(name, " ", age);

    // The same can be written using `var`.
    var [personName, personAge] = getPersonInfo();
    io:println(personName, " ", personAge);

    // Other binding patterns can also be used as such.
    // Here, a typed mapping binding is followed by `=` in which the values of the record fields
    // are bound to the `id`, `fname`, and `lname` variables of the binding.
    Person {id, fname, lname} = getPerson();
    io:println(id, " ", fname, " ", lname);
}

function getPersonInfo() returns [string, int] {
    return ["John", 30];
}

function getPerson() returns Person {
    return {id: 1001, fname: "Anne", lname: "Frank"};
}
