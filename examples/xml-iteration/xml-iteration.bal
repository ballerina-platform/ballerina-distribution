import ballerina/io;

public function main() {
    xml x1 = xml `<name>Sherlock Holmes</name><details>
                        <author>Sir Arthur Conan Doyle</author>
                        <language>English</language>
                  </details>`;

    // `foreach` iterates over each item.
    foreach var item in x1 {
        io:println(item);
    }

    // forEach() function available in the lang.xml iterates over each item
    x1.forEach((e) => io:println(e));

}
