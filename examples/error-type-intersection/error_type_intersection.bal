import ballerina/io;

type InputErrorDetail record {|
    int|string value;
|};

type NumericErrorDetail record {|
    int|float value;
|};

type InputError error<InputErrorDetail>;

type NumericError error<NumericErrorDetail>;

// `NumericInputError` has detail type, `record {| int value |}`.
type NumericInputError InputError & NumericError;

type DistinctInputError distinct error<InputErrorDetail>;

type DistinctNumericError distinct error<NumericErrorDetail>;

// `DistinctNumericInputError` has type IDs of both `DistinctInputError` and `DistinctNumericError`.
type DistinctNumericInputError DistinctInputError & DistinctNumericError;

public function main() {
    NumericInputError e1 = error("Numeric input error", value = 5);
    // `e1` belongs to `InputError` since its detail type is a subtype of `InputErrorDetail`.
    io:println(e1 is InputError);

    // `e1` doesn't belong to `DistinctInputError` since it doesn't have the type ID of `DistinctInputError`.
    io:println(e1 is DistinctInputError);

    DistinctNumericInputError e2 = error("Distinct numeric input error", value = 5);
    // `e2` belongs to `InputError` since its detail type is a subtype of `InputErrorDetail`.
    io:println(e2 is InputError);

    // `e2` belongs to `DistinctInputError` since its type ID set includes the type id of `DistinctInputError`.
    io:println(e2 is DistinctInputError);
}
