import ballerina/io;

public function main() {
    string[] names = ["Ana", "Alice", "Bob"];

    // Create an object value using an object constructor.
    var engineer = object {
        string name = "";

        function setName(string name) {
            // Access `names` variable as a closure within the `setName` method in the object constructor.
            names.push(name);
            self.name = name;
        }
    };

    engineer.setName("Walter");
    io:println(names);
}
