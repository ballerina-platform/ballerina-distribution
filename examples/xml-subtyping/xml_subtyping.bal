import ballerina/io;

// An `xml` value belongs to `xml:Element` if it consists of just an element
// item. 
xml:Element element = xml `<p>Hello</p>`;

// Similarly for `xml:Comment` and `xml:ProcessingInstruction`.
xml:Comment comment = xml `<!--This is a comment-->`;
xml:ProcessingInstruction procInst = xml `<?target data?>`;

public function main() {
    // An `xml` value belongs to the `xml:Text` if it consists of a text item or is empty.
    xml:Text _ = xml ``;
    xml:Text _ = xml `Hello World`;

    string hello = "Hello";
    string world = "World";
    xml:Text c = stringToXml(hello + " " + world);
    io:println(c);

    xml:Element otherElement = xml `<q>World</q>`;

    xml d = element + otherElement;
    xml e = xml `<p>hello</p>World`;
    // An `xml` value belongs to the type `xml<T>` if each of its members belong 
    // to `T`.
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
