import ballerina/io;

public function main() returns error? {
    xml x1 = xml `<name>Sherlock Holmes</name><details>
                    <author>Sir Arthur Conan Doyle</author>
                    <language>English</language>
                </details>`;

    // `x[i]` or `x.get(i)` gives the `i`-th item.
    io:println(x1[0]);

    // `x.id` accesses a required attribute named `id`: the result is an `error` if there is no such
    // attribute or if `x` is not a singleton.
    xml x2 = xml `<para id="greeting">Hello</para>`;
    string id = check x2.id;
    io:println(id);

    // `x?.id` accesses an optional attribute named `id`: the result is `()` if there is no such
    // attribute.
    string? name = check x2?.name;

    // The following nil check returns true since the attribute `name` does not exist in the `x2`.
    io:println(name is ());

}
