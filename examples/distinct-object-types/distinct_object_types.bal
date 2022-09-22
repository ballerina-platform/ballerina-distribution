import ballerina/io;

// `Person` object type that contains a string field called `name`.
type Person distinct object {
    public string name;
};

// `Engineer` and `Manager` classes are structurally the same but introducing the  
// `distinct` keyword distinguishes them by considering them as nominal types.
distinct class Engineer {
    *Person;
    
    function init(string name) {
        self.name = name;
    }
}

distinct class Manager {
    *Person;
    
    function init(string name) {
        self.name = name;
    }
}

type Employee Engineer|Manager;

function desc(Employee employee) returns string {
    // `is` operator can be used to distinguish distinct subtypes.
    return employee is Engineer ? "Engineer" : "Manager";
}

public function main() {
    Employee employee = new Engineer("James");
    io:println(desc(employee));
}
