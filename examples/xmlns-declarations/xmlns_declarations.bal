import ballerina/io;

// The identifier followed by the `as` keyword is the prefix bound to the namespace name.
// Here `eg` is bound to `"http://example.com"`.
xmlns "http://example.com" as eg;

public function main() {
    // The prefixes to which namespaces declarations are bound to can be used in XML templates.
    xml x = xml `<eg:doc>Hello</eg:doc>`;

    // `xmlns` declarations are also allowed at block level.
    // The `ex` prefix is also bound to `"http://example.com"`.
    xmlns "http://example.com" as ex;

    // The prefixes can also be used in XML navigation. 
    boolean b = x === x.<ex:doc>;

    // Since both `eg` and `ex` bind to the same namespace URL, the following evaluates to `true`.
    io:println(b);

    // An XML qualified name `ex:doc` evaluates to the string `{http://example.com}doc` where 
    // `http://example.com` is the namespace URL bound to `ex`.
    string exdoc = ex:doc;
    io:println(exdoc);
}
