import ballerina/io;

public function main() {
    // In this example, four variables are created and they will be matched against
    // the patterns specified in the `match` statement of the `basicMatch()` function.
    [string, int]|[float, string, boolean]|float a1 = 66.6;
    [string, int]|[float, string, boolean]|float a2 = ["Hello", 12];
    [float, boolean]|[float, string, boolean]|float a3 = [4.5, true];
    [string, int]|[float, string, boolean]|float a4 = [6.7, "Test", false];

    basicMatch(a1);
    basicMatch(a2);
    basicMatch(a3);
    basicMatch(a4);

    // In this example, five variables are created and they will be matched
    // against the match-guarded patterns specified in the `match` statement of the 'matchWithMatchGuard()' function.
    [string, int]|[boolean, int]|[int, boolean]|int|float b1 = ["Hello", 45];
    [string, int]|[float, boolean]|[int, boolean]|int|float b2 = [4.5, true];
    [float, boolean]|[boolean, int]|[int, boolean]|int|float b3 = [false, 4];
    [string, int]|[int, boolean]|int|float b4 = [455, true];
    [float, boolean]|[boolean, int]|[int, boolean]|float b5 = 5.6;

    matchWithMatchGuard(b1);
    matchWithMatchGuard(b2);
    matchWithMatchGuard(b3);
    matchWithMatchGuard(b4);
    matchWithMatchGuard(b5);
}

// This method uses tuple match patterns of different sizes. The `match` expression `a`
// will be matched against the given pattern list during runtime based on the
// "is-like" relationship between the expression and a pattern.
function basicMatch(any a) {
    match a {
        // This pattern check is for a tuple of three members of any type.
        [var s, var i, var b] => {
            io:println("Matched with three vars : ", string `${a.toString()}`);
        }
        // This pattern check is for a tuple of two members of any type.
        [var s, var i] => {
            io:println("Matched with two vars : ", string `${a.toString()}`);
        }
        // This pattern check is for a single variable, which can be of type `any`. This has to be the last pattern.
        var s => {
            io:println("Matched with single var : ", string `${a.toString()}`);
        }
    }
}

// This method uses tuple match patterns with different sizes along with match guards. The given
// `match` expression will be checked for the `is-like` relationship and also it will check the match guard for the pattern
// to match during runtime.
function matchWithMatchGuard(any b) {
    match b {
        // This pattern check is for a tuple of two members of the types `string` and `int` respectively.
        [var s, var i] if (s is string && i is int) => {
            io:println("'s' is string and 'i' is int : ",
            string `${b.toString()}`);
        }
        // This pattern check is for a tuple of two members where the first member is of the type `float`.
        [var s, var i] if s is float => {
            io:println("Only 's' is float : ", string `${b.toString()}`);
        }
        // This pattern check is for a tuple of two members, in which the second member is of the type `int`.
        [var s, var i] if i is int => {
            io:println("Only 'i' is int : ", string `${b.toString()}`);
        }
        // This pattern check is for a tuple of two members without any match guard.
        [var s, var i] => {
            io:println("No type guard : ", string `${b.toString()}`);
        }
        // This pattern check is for a single variable of the type `float`.
        var s if s is float => {
            io:println("'s' is float only : ", string `${b.toString()}`);
        }

    }
}
