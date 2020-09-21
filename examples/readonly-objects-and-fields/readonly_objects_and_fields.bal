import ballerina/io;

type Details record {|
    int id;
    string country;
|};

// An object with both read-only and non-read-only fields.
class Employee {
    string department;
    // `details` is a `readonly` field which cannot be updated once the value is created.
    // `details` also expects an immutable value, and thus the effective contextually expected type for
    // `details` is `Details & readonly`.
    readonly Details details;

    function init(string department, readonly & Details details) {
        self.department = department;
        self.details = details;
    }
}

// An abstract object with non-readonly fields.
type Controller object {
   int id;
   string[] codes;

   function getId() returns string;
};

// A non-abstract object with all read-only fields.
class DefaultController {
    readonly int id;
    readonly string[] codes;

    function init(int id, readonly & string[] codes) {
        self.id = id;
        // The expected type for `codes` is `readonly & string[]`.
        self.codes = codes;
    }

    function getId() returns string {
        return string `Default: ${self.id}`;
    }
}

// A non-abstract `readonly object`.
// If the object type-descriptor includes `readonly` all the fields in the
// object are considered to be `readonly` fields.
readonly class MainController {
    int id;
    string[] codes;

    function init(int id, readonly & string[] codes) {
        self.id = id;
        // The expected type for `codes` is `readonly & string[]`.
        self.codes = codes;
    }

    function getId() returns string {
        return string `Main: ${self.id}`;
    }
}

public function main() {

    // Define an immutable `Details` value.
    Details & readonly immutableDetails = {
        id: 112233,
        country: "Sri Lanka"
    };

    // Use `immutableDetails` as the value for the `readonly` `details` field in `Employee`.
    Employee emp = new ("IT", immutableDetails);

    Details details = emp.details;
    // The `details` field of `emp` is immutable.
    io:println("details is immutable: ", details.isReadOnly());

    // A `readonly` intersection (`T & readonly`) can be used with an object only if it is an abstract object.
    // A non-abstract object can be `readonly` either if all of its fields are `readonly` fields, or if the object
    // is defined as a `readonly` object.
    // In either case the fields cannot be updated once the value is created.
    // Define a value of the non-abstract object type `DefaultController`.
    DefaultController dc = new (1122, ["LC", "AB"]);

    // Since all the fields of `DefaultController` are `readonly` fields, the object value itself is considered
    // to be immutable. Thus, it can be used where a `readonly` value is expected.
    Controller & readonly controllerOne = dc;
    io:println(controllerOne.getId());

    // Define a value of the non-abstract `readonly object` type `MainController`.
    MainController mc = new (4246, ["AB"]);

    // Since the object was defined as a `readonly object`, the object value is considered immutable.
    // Thus, it can be used where a `readonly` value is expected.
    Controller & readonly controllerTwo = mc;
    io:println(controllerTwo.getId());
}
