import ballerina/io;

// This tuple type contains a list whose first member is the `string` type
// and the second and third members are the `int` type.
type Id [string, int, int];

type FloatPairArray float[2];

// Ballerina allows defining the same list type of two floats as `FloatPairArray` using a tuple 
// type by specifying the float type twice within the square brackets of the tuple declaration.
type FloatPairTuple [float, float];

public function main () {
    Id id = ["id 1", 0, 1];

    // The individual elements of this tuple can be indexed by using the `id[i]` notation.
    // Tuple indexing starts with zero.
    string s = id[0];
    io:println(s);
    
    int n = id[1];
    io:println(n);
}
