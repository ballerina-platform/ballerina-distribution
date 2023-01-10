import ballerina/io;

type Coord record {
    float x;
    float y;
};

type Book record {
    xml book;
    float price;
};

public function main() returns error? {
    json j = {x: 1, y: 2};

    // Argument is a `typedesc` value.
    // The static return type depends on the argument.
    // Even if `x` and `y` are `int` in `j`, they will automatically convert to `float`.
    Coord c = check j.cloneWithType(Coord);
    io:println(c.x);

    // Argument defaulted from the context.
    Coord d = check j.cloneWithType();
    io:println(d.x);

    Book book = {book: xml `<book> The Treasure Island </book>`, price: 200.0};

    json bookJson = book.toJson();
    io:println(bookJson);

    // `fromJsonWithType()` can be used to reverse the conversions done by `toJson()`.
    book = check bookJson.fromJsonWithType();
    io:println(book);

    // The below will result in an error because the type of the `book` field in `bookJson` is `string`.
    Book|error result = bookJson.cloneWithType();
    if result is error {
        io:println(result.message());
    }
}
