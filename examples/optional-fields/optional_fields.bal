import ballerina/io;

type FullName record {
    string firstName;
    string lastName;

    // The `title` and `middleName` fields are optional.
    string title?;
    string middleName?;
};

public function main() {

    FullName name = {
        title: "Mr",
        firstName: "John",
        lastName: "Doe"
    };

    // Use the `?.` operator to access the optional field.
    io:println("Title: ", name?.title);

    // A variable of type `string?` is used to construct an optional field.
    string? middleName = name["middleName"];
    io:println("Middle name: ", middleName);

    // Remove the optional `title` field by assigning `()`.
    name.title = ();
    io:println(name.hasKey("title"));

    // When destructuring the record `name`, if the `title` field is absent,
    // then, its value becomes nil.
    var {title, firstName: _, lastName: _} = name;
    io:println(title is ());
}
