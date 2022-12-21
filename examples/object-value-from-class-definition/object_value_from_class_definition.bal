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

    // Object initialized using default value in the `init` method.
    Engineer engineer1 = new Engineer();
    io:println(engineer1.getName());

    // Object initialized using given argument to new expression.
    Engineer engineer2 = new Engineer("Walter White");
    io:println(engineer2.getName());

    // Object initialized using given argument to new expression.
    Engineer engineer3 = new Engineer(name = "Jesse Pinkman");
    io:println(engineer3.getName());

    // Implicit new expression.

    // Object initialized using default value in the `init` method.
    Engineer engineer4 = new;
    io:println(engineer4.getName());

    // Object initialized using given argument to new expression.
    Engineer engineer5 = new ("Walter White");
    io:println(engineer5.getName());

    // Object initialized using a given named argument to the new expression.
    Engineer engineer6 = new (name = "Jesse Pinkman");
    io:println(engineer6.getName());
}
