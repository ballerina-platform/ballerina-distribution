import ballerina/io;

public function main() {
    string[] names = ["Ana", "Alice", "Bob"];

    // Create an object value using object constructor.
    var engineer = object {
        string name = "";

        function setName(string name) {
            // Access variable `names` as closure within the `setName` method in object constructor.
            names.push(name);
            self.name = name;
        }
    };

    engineer.setName("Walter");
    io:println(names);
}
