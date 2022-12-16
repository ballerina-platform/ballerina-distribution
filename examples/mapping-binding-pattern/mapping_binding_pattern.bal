import ballerina/io;

type Person record {|
    int id;
    string fname;
    string lname;
|};

public function main() {
    // `_` is used to ignore the value of the `id` field.
    // The values of the `fname` and `lname` fields are bound to `firstName` and
    // `lastName` variable names.
    Person {id: _, fname: firstName, lname: lastName} = getPerson();
    io:println(firstName + " " + lastName);

    // `fname` and `lname` fields do not have explicitly defined variable names.
    // `{fname, lname}` is the same as `{fname: fname, lname: lname}`.
    // The `id` field is ignored as it is not bound to a variable.
    Person {fname, lname} = getPerson();
    io:println(fname + " " + lname);

    string givenName;
    string surname;

    // This destructures and assigns the values of the fields in the destructed record
    // to variable references.
    // The values of the `fname` and `lname` fields are assigned to `givenName` and
    // `surname` variables.
    {fname: givenName, lname: surname} = getPerson();
    io:println(givenName + " " + surname);
}

function getPerson() returns Person {
    Person person = {id: 1001, fname: "Anne", lname: "Frank"};
    return person;
}
