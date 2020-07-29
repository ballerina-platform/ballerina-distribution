import ballerina/io;

public function main() {

    // This is a simple binding pattern, which involves only a single variable.
    [boolean, float] a1 = [true, 0.4];
    io:println("a1: ", a1);

    // The same variable definition can be written using a tuple-binding pattern
    // with separate variables.
    [boolean, float] [b1, b2] = [true, 0.4];
    io:println("b1: ", b1, " b2: ", b2);

    // The binding patterns are recursive in nature. These examples show
    // how to write complex recursive variable definitions.
    [[string, int], float] [[c1, c2], c3] = [["Ballerina", 4], 6.7];
    io:println("c1: ", c1, " c2: ", c2, " c3: ", c3);

    [[string, int], [boolean, float]] [[d1, d2], [d3, d4]] =
                        [["Ballerina", 34], [true, 6.7]];
    io:println("d1: ", d1, " d2: ", d2, " d3: ", d3, " d4: ", d4);

    // Tuple variables can also be defined using tuple-type expressions.
    [[string, [int, [boolean, byte]]], [float, int]] e1 =
                        [["Ballerina", [3, [true, 34]]], [5.6, 45]];
    io:println("e1: ", e1);
    [[string, [int, [boolean, byte]]],
                        [float, int]] [[f1, [f2, [f3, f4]]], [f5, f6]] = e1;
    io:println("f1: ", f1, " f2: ", f2, " f3: ", f3, " f4: ", f4, " f5: ", f5, " f6: ", f6);

    // Tuple variable definitions can also take union types.
    [string|int|float, [string|float, int]] [g1, [g2, g3]] = ["Ballerina", [3.4, 456]];
    io:println("g1: ", g1, " g2: ", g2, " g3: ", g3);
}
