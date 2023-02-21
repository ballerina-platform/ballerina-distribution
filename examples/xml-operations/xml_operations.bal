import ballerina/io;

public function main() {
    xml x1 = xml `<name>Sherlock Holmes</name>`;
    xml:Element x2 = 
        xml `<details>
                <author>Sir Arthur Conan Doyle</author>
                <language>English</language>
            </details>`;

    //   '+' or `x1.concat(x2)` can be used for concatenation.
    xml x3 = x1 + x2;
    io:println(x3);

    xml x4 = xml `<name>Sherlock Holmes</name>
                    <details>
                        <author>Sir Arthur Conan Doyle</author>
                        <language>English</language>
                    </details>`;

    // `==` does a deep equality check.
    boolean eq = x3 == x4;
    io:println(eq);

}
