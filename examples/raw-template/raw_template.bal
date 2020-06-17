import ballerina/lang.'object;
import ballerina/io;

public function main() {
    string name = "Ballerina";
    // Create a raw template with the `name` variable interpolated in the
    // literal.
    'object:RawTemplate template = `Hello ${name}!!!`;
    // The string literal portions of the raw template are accessible
    // through the `strings` field. The `strings` field is a list of
    // `string` values. The string literal portions of the raw template
    // are separated by the interpolations. If there are `n` insertions,
    // there will be `n+1` strings.
    io:println(template.strings);
    // The `insertions` field holds the values obtained by evaluating
    // the expressions specified in the interpolations of the raw template.
    // In this case, there is just one interpolation: a reference to the
    // variable, `name`.
    io:println(template.insertions[0]);

    Person[] people = [
        {name: "John Doe", age: 25},
        {name: "Jane Doe", age: 20}
    ];

    Query[] queries = [];
    int i = 0;

    foreach var p in people {
        queries[i] = (`INSERT INTO Details VALUES (${p.name}, ${p.age})`);
        i += 1;
    }

    io:println(buildQuery(queries[0]));
    io:println(buildQuery(queries[1]));
}

// A user can define their own raw template types as well. To define a
// raw template type,<br>
// 1) The type should be an abstract subtype of `object:RawTemplate` type<br>
// 2) It should only have the two fields `strings` and `insertions`<br>
// 3) It should not have method declarations
type Query abstract object {
    public string[] strings;
    // The type of the fields can be used to constrain the raw template
    // in ways such as limiting the number of interpolations/strings
    // that can be specified, ensuring that the interpolations are of
    // correct types etc.
    public [string, int] insertions;
};

type Person record {|
    string name;
    int age;
|};

function buildQuery(Query qu) returns string {
    // We can do additional checks/verifications on the raw template.
    // Here we're just building a concrete string query from the
    // components.
    return io:sprintf("%s%s%s%s%s", qu.strings[0], qu.insertions[0],
                        qu.strings[1], qu.insertions[1], qu.strings[2]);
}
