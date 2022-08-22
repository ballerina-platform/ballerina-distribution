public function main() {
    // Creates a `byte` array using the `base64` byte array literal.
    byte[] _ = base64 `yPHaytRgJPg+QjjylUHakEwz1fWPx/wXCW41JSmqYW8=`;

    // Creates a `byte` using a hexadecimal numeral.
    byte x = 0xA;

    // `byte & int` will be `byte`.
    byte _ = x & 0xFF;
}
