// Uninitialized integer variable `value`.
int value;

// Uninitialized final string variable `name`.
final string name;

function init() returns error? {
    // Initialize the variable `value` to 5.
    value = 5;
    // Initialize the final variable greeting to `James`.
    name = "James";
    
    if value > 3 {
        return error(string `${name}: The value should be less than 3, but it set to ${value}`);
    }
}
