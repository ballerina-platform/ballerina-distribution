int[] iv = [1, 2, 3];

// Assigning `int[]` to `any[]` is allowed.
// The set of values allowed by `int` is a subset of set of values allowed by `any`
// The set of values allowed by `int[]` is a subset of set of values allowed by `any[]`
any[] av = iv;

public function main() {
    // A runtime error or else `iv[0]` would have the wrong type.
    av[0] = "str";
}
