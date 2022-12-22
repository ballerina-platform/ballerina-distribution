import ballerina/io;

public function main() {
    // Create an object value using object constructor.
    var engineer = object {
        string name;

        // `init` function in the object constructor can not have parameters.
        function init() {
            self.name = "";
        }

        function setName(string name) {
            self.name = name;
        }

        function getName() returns string {
            return self.name;
        }
    };

    engineer.setName("Alice");
    io:println(engineer.getName());
}
