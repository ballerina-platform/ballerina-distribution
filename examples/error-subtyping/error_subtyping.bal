import ballerina/io;

// `distinct` creates a new subtype.
type XErr distinct error;
type YErr distinct error;

type Err XErr|YErr;

// The name of the distinct type can be used with the error
// constructor to create an `error` value of that type.
// `err` holds an `error` value of type `XErr`.
Err err = error XErr("Whoops!");

function desc(Err err) returns string {
    // The `is` operator can be used to distinguish distinct subtypes.
    return err is XErr ? "X" : "Y";

}

public function main() {
    io:println(desc(err));
}
