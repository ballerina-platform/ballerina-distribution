import ballerina/io;

// An `xml` value belongs to `xml:Element` if it consists of just an element item. 
xml:Element element = xml `<p>Hello</p>`;

// Similarly, a value belongs to `xml:Comment` or `xml:ProcessingInstruction` if it 
// consists of just a comment item or a processing instruction item.
xml:Comment comment = xml `<!--This is a comment-->`;
xml:ProcessingInstruction procInst = xml `<?target data?>`;

// An `xml` value belongs to `xml:Text` if it consists of only a text item or is empty.
xml:Text empty = xml ``;
xml:Text text = xml `Hello World`;

public function main() {
    string hello = "Hello";
    string world = "World";

    // The return type of `stringToXml` is `xml:Text`, which indicates that it will
    // return an XML text item.
    xml:Text c = stringToXml(hello + " " + world);
    io:println(c);

    xml:Element otherElement = xml `<q>World</q>`;

    // Concatenating multiple items results in a sequence of items (`xml<T>`).
    // The concatenation below will result in a sequence of XML elements (`xml<xml:Element>`).
    xml d = element + otherElement;

    xml e = xml `<p>hello</p>World`;

    // An `xml` value belongs to the `xml<T>` type if each of its members belongs to type `T`.
    io:println(element is xml<xml:Element>);
    io:println(d is xml<xml:Element>);
    io:println(e is xml<xml:Element>);

    io:println(d);
    rename(d, "q", "r");
    io:println(d);
}

function stringToXml(string s) returns xml:Text {
    return xml:createText(s);
}

// Functions in lang.xml use subtyping to provide safe and convenient typing.
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
