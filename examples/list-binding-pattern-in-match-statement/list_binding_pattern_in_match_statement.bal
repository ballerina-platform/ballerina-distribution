import ballerina/io;

const string show = "show";
const string remove = "remove";
const string all = "*";

function matchCommand(string[] commands) {
    match commands {
        // The list binding pattern below matches lists that contain two list items
        // in which the first list item matches with the `show` constant.
        [show, _] => {
            io:println("List all files.");
        }
        [remove, all] => {
            io:println("Remove all files.");
        }
        // The list binding pattern below matches lists in which the first list item
        // matches with the `remove` constant and the remaining values are matched with
        // the `...files` rest binding pattern.
        [remove, ...var files] => {
            io:println("Remove files: ", files);
        }
        [var command, var file] => {
            io:println(command, ": ", file);
        }
        _ => {
            io:println("Unrecognized command.");
        }
    }
}

public function main() {
    matchCommand(["show", "*"]);
    matchCommand(["remove", "*"]);
    matchCommand(["remove", "a.bal", "b.bal"]);
    matchCommand(["move", "a.bal"]);
    matchCommand(["1", "2", "3", "4"]);
}
