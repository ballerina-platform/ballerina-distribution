import ballerina/io;

class Engineer {
    // The `public` field is accessible outside the module as well.
    public string name;

    // The `private` field is only accessible within the class.
    private decimal salary;

    // The `init` method initializes the object.
    function init(string name) {
        self.name = name;
        self.salary = 0;
    }

    // The default method is only accessible within the module.
    function getName() returns string {
        return self.name;
    }

    // The `private` method is only accessible within the class definition.
    private function addBonus(decimal salary) returns decimal {
        return salary + 100;
    }

    // The `public` method is accessible outside the module as well.
    public function getSalary() returns decimal {
        return self.addBonus(self.salary);
    }

    public function setSalary(decimal salary) {
        self.salary = salary;
    }
}

public function main() {
    // Arguments to `new` are passed as arguments to `init`.
    Engineer engineer = new Engineer("Alice");
    engineer.setSalary(1000);

    io:println(engineer.name);
    io:println(engineer.getName());
    io:println(engineer.getSalary());
}
