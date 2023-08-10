public function main() {
    // Since the basic type of the value returned by `getInt()` is `int`
    // which belongs to `any` type, this will not cause an assignment.
    int _ = getInt();

    // The type of the wildcard binding pattern is  derived as `any`
    // since it results in a successful match.
    _ = 3;
}

function getInt() returns int {
    return 0;
}

