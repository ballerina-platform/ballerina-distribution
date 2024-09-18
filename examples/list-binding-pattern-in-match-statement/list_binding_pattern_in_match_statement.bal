import ballerina/io;

function matchCommand(any commands) {
    match commands {
        var [show] => {
            io:println(show);
        }
        // The list binding pattern below binds lists that contain three list items.
        var [remove, all, _] => {
            io:println(remove, " ", all);
        }
        // The list binding pattern below binds lists that contain two list items,
        // in which the second list item is also a list of two items.
        var [copy, [file1, file2]] => {
            io:println(copy, " ", file1, " into ", file2);
        }
        _ => {
            io:println("Unrecognized command.");
        }
    }
}

function matchWithMatchGuard(any lst) {
    match lst {
        // The list binding pattern below binds lists that contain two members
        // of the types `string` and `int` respectively.
        var [s, i] if s is string && i is int => {
            io:println("First member is a string and second member is an int: ", lst);
        }
        // The list binding pattern below binds lists that contain two members
        // where the type of the first memeber is `float`.
        var [s, _] if s is float => {
            io:println("First member is a float: ", lst);
        }
        // This pattern check is for a single variable of the type `float`.
        var s if s is float => {
            io:println("Value is a float: ", lst);
        }
    }
}

public function main() {
    matchCommand(["Show"]);
    matchCommand(["Remove", "*", true]);
    matchCommand(["Copy", ["a.bal", "b.bal"]]);
    matchCommand(1);

    matchWithMatchGuard(["Hello", 45]);
    matchWithMatchGuard([4.5, true]);
    matchWithMatchGuard(5.6);
}
