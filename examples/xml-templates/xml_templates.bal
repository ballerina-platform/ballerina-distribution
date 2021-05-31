import ballerina/io;

string url = "https://ballerina.io";

xml content = 
    // `xml` values can be constructed using an XML template expression.
    // Attribute values can have `string` values as interpolated expressions.
    xml `<a href="${url}">Ballerina</a> is an <em>exciting</em> new language!`;

// Interpolated expressions can also be in content (`xml` or `string` values).
xml p = xml `<p>${content}</p>`;

public function main() {
    io:println(content);
    io:println(p);
}
