import ballerina/io;

type RecordOne record {
    string a;
};

type RecordTwo record {|
    string a;
    int b;
|};

type RecordThree record {
    string a;
    RecordTwo b;
};

public function main() {
    RecordOne rec1 = {a: "Hello", "b": 150};
    RecordOne rec2 = {a: "Hello", "b": true};
    RecordOne rec3 = {a: "Hello", "b": 150, "c": true};
    RecordOne rec4 = {a: "Hello"};

    basicMatch(rec1);
    basicMatch(rec2);
    basicMatch(rec3);
    basicMatch(rec4);

    RecordTwo tRec1 = {a: "Ballerina", b: 500};
    RecordThree tRec2 = {a: "Language", b: tRec1};

    matchWithTypeGuard(tRec1);
    matchWithTypeGuard(tRec2);
    matchWithTypeGuard(true);
}

// This method uses mapping match patterns with different fields. The given `match` expression will
// be checked for the `isLike` relationship and will be matched during runtime.
function basicMatch(any a) {
    match a {
        // This pattern checks for a mapping value with three fields `a`, `b`, and `c` and types will
        // be `any` in the pattern block.
        {a: var var1, b: var var2, c: var var3} => {
            io:println("Matched with three vars : ", var1, ", ", var2, ", ",
                       var3);
        }
        // This pattern checks for a mapping value with two fields `a`, `b`, and the types will be `any` in
        // the pattern block.
        {a: var var1, b: var var2} => {
            io:println("Matched with two vars : ", var1, ", ", var2);
        }
        // This pattern checks for a mapping value with a single field `a` and type will be `any` in the pattern block.
        {a: var var1} => {
            io:println("Matched with single var : ", var1);
        }
    }
}

// This method uses structured record match patterns with different fields
// along with type guards. The expression used with the matching will be evaluated to
// check if it `is like` any of the match patterns. For a successful match, an additional
// check will also be performed against the specified type guard.
function matchWithTypeGuard(any matchExpr) {
    // All the patterns except the last one will check for a mapping value with two fields `var1` and `var2`
    // with a given type guard.
    match matchExpr {
        // This pattern will only match if `var2` is of the type `string`.
        {a: var var1, b: var var2} if var2 is string => {
            io:println("Matched with string typeguard");
        }
        // This pattern will only match if `var1` is of the type `int` and `var2` is of the type `int`.
        {a: var var1, b: var var2} if (var1 is int && var2 is int) => {
            io:println("Matched with int and int typeguard : ", var1);
        }
        // This pattern will only match if `var1` is of the type `string` and `var2` is of the type `int`.
        {a: var var1, b: var var2} if (var1 is string && var2 is int) => {
            io:println("Matched with string and int typeguard : ", var1);
        }
        // This pattern will only match if `var1` is of the type `int` and `var2` is of the type `RecordTwo`.
        {a: var var1, b: var var2} if (var1 is int && var2 is RecordTwo) => {
            io:println("Matched with int and RecordTwo typeguard : ", var1);
        }
        // This pattern will only match if `var1` is of the type `string` and `var2` is of the type `RecordTwo`.
        {a: var var1, b: var var2} if (var1 is string && var2 is RecordTwo) => {
            io:println("Matched with string and RecordTwo typeguard : ",
                       var2.a);
        }
        // A pattern with a single identifier can be used as the last match pattern and all values will
        // be matched to this.
        var x => {
            io:println("Matched with Default");
        }
    }
}
