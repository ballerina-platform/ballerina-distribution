import ballerina/io;

public function main() returns error? {
    xml x1 = xml `<name>Sherlock Holmes</name>`;
    xml:Element x2 = 
        xml `<details>
                <author>Sir Arthur Conan Doyle</author>
                <language>English</language>
            </details>`;

    // `+` does concatenation.
    xml x3 = x1 + x2;

    io:println(x3);

    xml x4 = xml `<name>Sherlock Holmes</name><details>
                        <author>Sir Arthur Conan Doyle</author>
                        <language>English</language>
                  </details>`;
    // `==` does deep equals.
    boolean eq = x3 == x4;

    io:println(eq);

    // `foreach` iterates over each item.
    foreach var item in x4 {
        io:println(item);
    }

    // `x[i]` gives i-th item (empty sequence if none).
    io:println(x3[0]);

    // `x.id` accesses required attribute named `id`:
    // result is `error` if there is no such attribute
    // or if `x` is not a singleton.
    xml x5 = xml `<para id="greeting">Hello</para>`;
    string id = check x5.id;

    io:println(id);

    // `x?.id` accesses optional attribute named `id`:
    // result is `()` if there is no such attribute.
    string? name = check x5?.name;

    io:println(name is ());

    // Mutate an element using `e.setChildren(x)`.
    x2.setChildren(xml `<language>French</language>`);

    io:println(x2);
    io:println(x3);
}
