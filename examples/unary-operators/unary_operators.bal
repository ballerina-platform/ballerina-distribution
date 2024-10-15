import ballerina/io;

public function main() {
    int a = 10;

    // Negate the value of `a`.
    int negatedInt = -a;
    io:println(negatedInt);
    
    // Invert the bits of `a`.
    int bitwiseInvertedInt = ~a;
    io:println(bitwiseInvertedInt);

    int:Signed8 b = 127;

    // Negate the value of `b`.
    int negatedSigned8Int = -b;
    io:println(negatedSigned8Int);

    float c = -10.5;

    // Negate the value of `c`.
    float negatedFloat = -c;
    io:println(negatedFloat);
    
    // Using the `+` operator returns the value of its operand expression.
    float unchangedFloat = +c;
    io:println(unchangedFloat);

    boolean d = true;

    // Invert the boolean value of `d`.
    boolean negatedBoolean = !d;
    io:println(negatedBoolean);
}
