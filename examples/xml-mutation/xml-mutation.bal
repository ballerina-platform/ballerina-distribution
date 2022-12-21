import ballerina/io;

public function main() returns error? {
    xml:Element x1 = xml `<details>
                            <author>Sir Arthur Conan Doyle</author>
                            <language>English</language>
                        </details>`;

    // Sets the children of an xml element.
    // This panics if it would result in the element structure becoming cyclic.
    x1.setChildren(xml `<language>French</language>`);
    io:println(x1);

    // Changes the name of an XML element.
    x1.setName("updatedDetails");
    io:println(x1);

}