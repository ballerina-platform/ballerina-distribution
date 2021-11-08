public function main() {
    // Creates a `byte` array using the `base64` byte array literal.
    byte[] _ = base64`yPHaytRgJPg+QjjylUHakEwz1fWPx/wXCW41JSmqYW8=`;

    // Creates an `int` using a hexadecimal numeral.
    int x = 0xDEADBEEF;

    // `byte & int` will be `byte`.
    byte _ = x & 0xFF;

}
