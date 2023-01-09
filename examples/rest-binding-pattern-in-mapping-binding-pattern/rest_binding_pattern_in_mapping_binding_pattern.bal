import ballerina/io;

type Person record {
    int id;
    string fname;
    string lname;
};

public function main() {
    // The value of the `id` field is ignored using `_`.
    // The value of the `fname` field is matched with the `firstName` variable.
    // `...otherDetails` is a rest parameter. The remaining fields that have not been matched
    // are matched with `...otherDetails`.
    Person {id: _, fname: firstName, ...otherDetails} = getPerson();
    io:println(firstName);

    // The type of `otherDetails` is a `record` holding the remaining fields.
    record {|string lname; anydata...;|} details = otherDetails;
    io:println(details);

    string fname;
    record {|string lname; anydata...;|} otherInfo;

    // The values of the fields in the destructed record are assigned to the variable references.
    // The value of the `fname` field is assigned to the `fname` variable.
    // The remaining field values that have not been matched are assigned to `...otherInfo`.
    {fname, ...otherInfo} = getPerson();
    io:println(fname);
    io:println(otherInfo);
}

function getPerson() returns Person {
    Person person = {id: 1001, fname: "Anne", lname: "Frank", "age": 24, "country": "UK"};
    return person;
}
