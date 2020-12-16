import ballerina/io;

// Defines an object type called `Person`. It should only contain fields and the
// method declarations.
type Person object {
    public int age;
    public string firstName;
    public string lastName;

    // Method declarations can be within the object. However, the method cannot
    // have a body.
    function getFullName() returns string;
};

// Defines another object type called `Employee`, which "includes" the `Person` object.
type Employee object {
    // Add an object type (`Person`) inclusion
    // All the member fields and member-method declarations will be copied from the `Person` object.
    *Person;
    public float|string salary;

    function getSalary() returns float|string;
};

class Owner {
    public string status = "";
}

class Manager {
    // Inclusing the `Employee` object transitively includes the `Person` object as well.
    // This will copy all the members in both `Employee` and `Person`.
    // It will be the same as declaring each of those members within this object.
    *Employee;

    // It is possible to have more than one type inclusion as well.
    *Owner;

    public string dpt;

    // Included fields can be overridden in a type-descriptor if the type of the field
    // in the overriding descriptor is a sub-type of the original type of the field.
    public float salary;

    // All the fields included through a type inclusion can be accessed within this object.
    function init(int age, string firstName, string lastName, string status) {
        self.age = age;
        self.firstName = firstName;
        self.lastName = lastName;
        self.status = status;
        self.salary = 2000.0;
        self.dpt = "HR";
    }

    // The member methods coming from the included type should be defined within the object.
    function getFullName() returns string {
        return self.firstName + " " + self.lastName;
    }

    // Included methods can also be overridden as long as the method in the overriding
    // descriptor is a sub-type of the method in the included type.
    function getSalary() returns float {
        return self.salary;
    }
}

public function main() {
    Manager p = new Manager(5, "John", "Doe", "Senior");

    // Accessing the fields that are coming from the included type.
    io:println(p.age);
    io:println(p.dpt);

    // Invoking the methods that are coming from the included type.
    io:println(p.getFullName());
    io:println(p.getSalary());
}
