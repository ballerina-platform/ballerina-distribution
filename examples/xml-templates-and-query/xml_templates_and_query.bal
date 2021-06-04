import ballerina/io;

type Person record {|
    string name;
    string country;
|};

function personsToXml(Person[] persons) returns xml {
    // Uses a template containing a query expression, which also contains a template.
    return xml`<data>${from var {name, country} in persons
           select xml`<person country="${country}">${name}</person>`}</data>`;

}

public function main() {
    Person[] persons = [
        {name: "Jane", country: "USA"},
        {name: "Mike", country: "Germany"}
    ];
    io:println(personsToXml(persons));
}
