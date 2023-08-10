import ballerina/io;

type Person record {|
    string name;
    int age;
|};

public function main() {
    Person[] teamA = [{name: "Alex", age: 23}, {name: "John", age: 24}];
    Person[] teamB = [{name: "Ranjan", age: 30}, {name: "Bob", age: 28}];

    var battles = from var personA in teamA
                  from var personB in teamB
                  select string `${personA.name} vs ${personB.name}`;
    io:println(battles);
}
