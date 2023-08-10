import ballerina/io;

// `err` is an error type constructed from named arguments to add some details to the error value.
error err = error("Whoops", httpCode = 27);

// The `HttpDetail` type is a record type that defines the`httpCode` field  of type `int`.
type HttpDetail record {
    int httpCode;
};

// When included in the declaration of the `error<HttpDetail>` error type, it uses the
// `HttpDetail` record type as the error detail record.
error<HttpDetail> httpError = error("Whoops", httpCode = 27);

// The `error:detail()` lang library function facilitates extracting the detail value
// out of the error.
HttpDetail d = httpError.detail();

public function main() {
    io:println(d);
}
