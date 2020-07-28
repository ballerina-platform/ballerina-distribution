import ballerina/io;

type Person record {
    string name;
    int age;
    string country;
};

type Country record {
    string name;
    Capital capital;
};

type Capital record {|
    string name;
|};

public function main() {
    // This record-typed binding pattern will destructure a `record` of the type `Person` and create three variables as follows:
    // The value of the field `name` in the `Person` record will be set to a new `string` variable `firstName`.
    // The value of the field `age` in the `Person` record will be set to a new `int` variable `personAge`.
    // `...otherDetails` is a rest parameter. Since `Person` is an open record, a new `map<anydata|error>` variable
    // `otherDetails` will be created (with the remaining fields that have not been matched) in the record binding pattern.
    Person {name: firstName, age: personAge, ...otherDetails} = getPerson();
    io:println("First Name: ", firstName);
    io:println("Person Age: ", personAge);
    io:println("Other Details: ", otherDetails);

    // If a field name is not given, the name of the variable will be considered the field name as well.
    // i.e, `Person {name, age}` is same as Person `{name: name, age: age}`.
    // Since a rest parameter is not given, all remaining fields are ignored.
    Person {name, age} = getPerson();
    io:println("Name: ", name);
    io:println("Age: ", age);

    // Record-typed binding patterns can be used with `var` to infer the type from the right hand side.
    // Since the types of the new variables are based on the type of the type binding pattern, using `var` will
    // infer the types from the right hand side.
    var {name: firstName2, age: personAge2, ...otherDetails2} = getPerson();
    // The type of `vFirstName` is inferred as `string`.
    io:println("First Name 2: ", firstName2);
    // The type of `vPersonAge` is inferred as `int`.
    io:println("Person Age 2: ", personAge2);
    // The type of `vOtherDetails` will be `map<anydata|error>`.
    io:println("Other Details 2: ", otherDetails2);

    // Binding patterns are recursive in nature. `capital`, which is a field of the type `Capital` in `Country` can also be
    // destructured as as shown here.
    var {name: countryName, capital: {name: capitalName}} = getCountry();
    io:println("Country Name: ", countryName);
    io:println("Capital Name: ", capitalName);
}

function getPerson() returns Person {
    Person person = {
        name: "Peter",
        age: 28,
        country: "Sri Lanka",
        "occupation": "Software Engineer"
    };
    return person;
}

function getCountry() returns Country {
    Capital capital = {name: "Colombo"};
    Country country = {name: "Sri Lanka", capital: capital};
    return country;
}
