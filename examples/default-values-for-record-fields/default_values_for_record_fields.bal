import ballerina/io;

type X record {
    string str = "default string";
};

type Y record {
    *X;
};

public function main() returns error? {
    X x1 = {};
    io:println(x1);

    // Calling the `value:cloneWithType()` function with `X` will make use of default values in `X`.
    json x2 = check x1.cloneWithType();
    io:println(x2);

    // `*X` copies the default values.
    Y y1 = {};
    io:println(y1);
}
