import ballerina/io;

public function main() {
    // An `xml` value belongs to an `xml:Element` if it consists of just an element item.
    xml:Element firstElement = xml `<p>Hello</p>`;

    // Similarly, a value belongs to the `xml:Comment` or `xml:ProcessingInstruction` if it
    // consists of just a comment item or a processing instruction item.
    xml:Comment comment = xml `<!--This is a comment-->`;
    io:println(comment);

    xml:ProcessingInstruction procInst = xml `<?target data?>`;
    io:println(procInst);

    // An `xml` value belongs to the `xml:Text` if it consists of only a text item or is empty.
    xml:Text empty = xml ``;
    io:println(empty);
    xml:Text text = xml `Hello World`;
    io:println(text);

    string hello = "Hello";
    string world = "World";

    // `xml:createText` can be used to convert a string to `xmlText`.
    xml:Text xmlString = xml:createText(hello + " " + world);
    io:println(xmlString);

    xml:Element secondElement = xml `<q>World</q>`;

    // Concatenating multiple items results in a sequence of items (`xml<T>`).
    // The concatenation below will result in a sequence of XML elements (`xml<xml:Element>`).
    xml resultElement = firstElement + secondElement;

    xml xmlHelloWorld = xml `<p>hello</p>World`;

    // An `xml` value belongs to the `xml<T>` type if each of its members belongs to type `T`.
    io:println(resultElement is xml<xml:Element>);
    io:println(xmlHelloWorld is xml<xml:Element>);

    io:println(resultElement);
    rename(resultElement, "q", "r");
    io:println(resultElement);
}

// Functions in `lang.xml` use subtyping to provide safe and convenient typing.
// For example, `x.elements()` returns element items in `x` as type
// `xml<xml:Element>` and `e.getName()` and `e.setName()` are defined when
// `e` has type `xml:Element`.
function rename(xml x, string oldName, string newName) {
    foreach xml:Element e in x.elements() {
        if e.getName() == oldName {
            e.setName(newName);
        }
        rename(e.getChildren(), oldName, newName);
    }
}
