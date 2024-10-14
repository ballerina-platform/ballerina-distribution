import ballerina/io;

type InputErrorDetail record {|
    int|string value;
|};

type NumericErrorDetail record {|
    int|float value;
|};

type InputError error<InputErrorDetail>;

type NumericError error<NumericErrorDetail>;

type DistinctInputError distinct error<InputErrorDetail>;

type DistinctNumericError distinct error<NumericErrorDetail>;

// `NumericInputError` has detail type, `record {| int value |}`.
type NumericInputError InputError & NumericError;

// `DistinctNumericInputError` has type ids of both `DistinctInputError` and `DistinctNumericError`.
type DistinctNumericInputError DistinctInputError & DistinctNumericError;

function createNumericInputError(int value) returns NumericInputError {
    return error("Numeric input error", value = value);
}

function createDistinctNumericInputError(int value) returns DistinctNumericInputError {
    return error("Distinct numeric input error", value = value);
}

public function main() {
    NumericInputError e1 = createNumericInputError(5);
    // `e1` belong to `InputError` since its detail type is a subtype of `InputErrorDetail`.
    io:println(e1 is InputError);

    // `e1` doesn't belong to `DistinctInputError` since it doesn't have the type id of `DistinctInputError`.
    io:println(e1 is DistinctInputError);

    DistinctNumericInputError e2 = createDistinctNumericInputError(5);
    // `e2` belong to `InputError` since it's detail type is a subtype of `InputErrorDetail`.
    io:println(e2 is InputError);

    // `e2` belong to `DistinctInputError` since it's type id set include the type id of `DistinctInputError`.
    io:println(e2 is DistinctInputError);
}
