import ballerina/io;

class Engineer {
    string name;

    function init(string name = "Null") {
        self.name = name;
    }

    function getName() returns string {
        return self.name;
    }
}

public function main() {
    // Explicit new expression.
    // Object is initialized using the default value in the `init` method.
    Engineer engineer1 = new Engineer();
    io:println(engineer1.getName());

    // Object is initialized by passing an argument to the class descriptor with the new expression.
    Engineer engineer2 = new Engineer("Alice");
    io:println(engineer2.getName());

    // Object is initialized by passing a named argument to 
    // the class descriptor with the new expression.
    Engineer engineer3 = new Engineer(name = "Bob");
    io:println(engineer3.getName());

    // Implicit new expression.
    // Object is initialized using the default value in the `init` method.
    Engineer engineer4 = new;
    io:println(engineer4.getName());

    // Object is initialized by passing an argument to the new expression.
    Engineer engineer5 = new ("Alice");
    io:println(engineer5.getName());

    // Object is initialized by passing a named argument to the new expression.
    Engineer engineer6 = new (name = "Bob");
    io:println(engineer6.getName());
}
