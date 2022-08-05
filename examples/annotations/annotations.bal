import ballerina/io;

// The `@display` annotation is applied to the `transform` function.
@display {
    label: "Transform",
    iconPath: "transform.png"
}
public function transform(string s) returns string {
    return s.toUpperAscii();
}

type AnnotRecord record {|
    string value;
|};

// Declares an annotation tag on type.
annotation AnnotRecord annot on type;

// The `@annot` annotation applies to the `T1` record type.
@annot {
    value: "T1"
}
type T1 record {
    string name;
};

public function main() {
    T1 a = {name: "John"};
    typedesc<any> t = typeof a;
    // Access annotation.
    AnnotRecord? ann = t.@annot;

    io:println(ann);
}
