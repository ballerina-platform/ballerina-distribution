import ballerina/io;

// Define a class named `Person` with `public`, `private`, and module-level visible fields.
// All the fields have to be initialized either using field initializers (default values) or within the `init`
// method, if present.
class Person {
    public string name;
    public int age;
    public string email = "default@abc.com";

    // Fields with no access modifiers are visible only within the same module.
    string address = "No 20, Palm Grove";

    // Private fields are only visible within the class.
    private boolean employed;

    // If you need to have a field of the same class, you need to make that field's
    // type a union with a different type, in order to set an initial value to the field.
    // Here, the `parent` field does so by defining the field to be of type `Person` or nil.
    public Person? parent = ();

    // The `init` method should initialize any field that does not have an initalizer
    // expression. If the `init` method accepts parameters, arguments have to be passed
    // for parameters when using the `new` expression with the class.
    function init(string name, int age, boolean employed) {
        // Fields of the class are accessed using `self`.
        self.name = name;
        self.age = age;
        self.employed = employed;
    }

    // Methods can access all the fields of the class.
    function isEmployed() returns boolean => self.employed;
}

// Define a class named `Person`. It contains `public`, `private`, and module-level visible fields.
// Initializer expressions are specified for all of the fields and this class does not contain
// an `init` method.
class Employee {
    public string name = "";
    public int age = 0;
    private string email = "default@abc.com";
    string address = "No 20, Palm Grove";

    // Private methods can only be called from within the class;
    private function getDomainName() returns string => "abc.com";

    // Methods can update fields.
    // Module-level visible methods can only be called from within the same module.
    function setEmail(string username) {
        self.email = string `${username}@${self.getDomainName()}`;
    }

    // Public methods can be called from anywhere.
    public function getEmail() returns string => self.email;
}

class Teenager {
    string name;
    int age;

    // An `init` method may return an error.
    function init(string name, int age) returns error? {
        if age > 18 {
            return error(string `${name} is not a teenager!`);
        }

        self.name = name;
        self.age = age;
    }
}

public function main() {
    // If there is no `init` method or the `init` method does not accept parameters,
    // a value can be constructed with just the `new` expression.
    Employee e1 = new;
    io:println(e1.age);

    // Such a value can also be constructed with the `new` expression with empty parentheses.
    Employee e2 = new ();
    io:println(e2.age);

    // Public fields of the class can be accessed and modified anywhere outside the class.
    e2.name = "John";
    e2.age = 20;
    io:println(e2.name);
    io:println(e2.age);

    // Module-level visible fields of the class can be accessed and modified within the same
    // module as the class.
    e2.address = "Colombo, Sri Lanka";
    io:println(e2.address);

    // Module-level visible methods of the class can be called from only within the same
    // module as the class.
    e2.setEmail("john");

    // Public methods of the class can be called from anywhere.
    io:println(e2.getEmail());

    // If there is an `init` method and it accepts parameters, relevant
    // arguments need to be passed to the `new` expression, similar to
    // a normal function call.
    Person p1 = new ("Kara", 26, true);
    io:println(p1.isEmployed());

    // The `new` expression can also explicitly specify the class from which the object value
    // needs to be created. It is a compile-time error if the value created by the `new`
    // expression does not belong to the target type.
    any p2 = new Person("Jim", 33, false);
    io:println(p2 is Person);

    // If the `init` method may return an error, the static type of the `new` expression
    // would also contain error.
    // If the `init` method returns an error, the object is not constructed.
    Teenager|error t1 = new ("Jo", 20);
    io:println(t1 is Teenager);

    if t1 is error {
        io:println(t1);
    }

    // If the `init` method returns `()` (nil), the object is successfully constructed.
    Teenager|error t2 = new ("Amy", 16);
    io:println(t2 is Teenager);
}
