import ballerina/constraint;

// Constraint on `int` type.
@constraint:Int {
    minValue: 18
}
type Age int;

type Student record {|
    // Constraint on `string` typed record field.
    @constraint:String {
        length: 7
    }
    string id;
    string name;
    // Constrainted type used as a record field.
    Age age;
    // Constraint on `string[]` typed record field;
    @constraint:Array {
        minLength: 1,
        maxLength: 10
    }
    string[] subjects;
|};

public function main() returns error? {
    Student student = {
        id: "200146B",
        name: "David John",
        age: 25,
        subjects: ["Maths", "Science", "English"]
    };
    // To validate the constraints on `Student` record, the `validate` function should be 
    // called explicitly. If the validation is successful then this function returns the type 
    // descriptor of the value which is validated.
    student = check constraint:validate(student);

    // Set the student's age to 17 which will violate the `minValue` constraint on `Age`.
    student.age = 17;

    // When the validation fails, the `validate` function returns a `constraint:Error`.
    student = check constraint:validate(student);
}
