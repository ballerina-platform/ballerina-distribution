import ballerina/io;
 
type Student record {|
    string firstName;
    string lastName?;
|};

type AdmissionDate record {|
    string year = "2020";
    string month = "Jan";
    never admissionNo?;
|};

type Grades record {|
    never math?;
    never physics?;
    int...;
|};

// Adding `*` before the type of the parameter marks the parameter as an included record parameter.
// The names of the fields in the record type of an included record parameter must be distinct 
// from each other and also from the names of the other parameters, unless it is an optional field of type `never`. 
// If not, it results in a compilation error.
function printStudentDetails(int admissionNo, *Student student) {
    string name = student.firstName;
 
    string? lastName = student?.lastName;
    if lastName is string {
        name += string ` ${lastName}`;
    }
 
    io:println("Admission No: ", admissionNo, ", Student Name: ", name);
}  

function printAdmissionDate(int admissionNo, *AdmissionDate date) {
    string admissionDate = date.year + "-" + date.month;

    io:println("Admission No: ", admissionNo,
               ", Admission Date: ", admissionDate);
}

function printAverage(int math, int physics, *Grades grades) {
    int totalMarks = math + physics;
    int count = 2;
 
    foreach int grade in grades {
        totalMarks += grade;
        count += 1;
    }
 
    io:println("Average Marks: ", totalMarks/count);
}
 
public function main() {

    Student student = {
        firstName: "Anna",
        lastName: "Christina"
    };
    
    // Call the function by passing a positional argument for the `student` included record parameter.
    printStudentDetails(1001, student);

    // Call the function by passing values for the fields of the included record parameter. 
    // Value need to be supplied for the required fields that do not have default values.
    printStudentDetails(1002, firstName = "Anne", lastName = "Doe");

    // Call the function by passing values only for the required fields of the included record parameter.
    // The `lastName` field of the included record parameter defaults to `()`. 
    printStudentDetails(1003, firstName = "Peter");

    // Call the function by passing only for the `admissionNo` parameter.
    // The `year` and `month` fields of the `date` included record parameter default to `2020` and `Jan` respectively.
    printAdmissionDate(1004);

    // The type of the included record parameter allows additional fields if the following two conditions are satisfied. 
    // *. In the parameter list, there should be only one included record parameter that is of an open record type.
    // *. The open record type must disallow fields with the same name as the other parameters and individual field descriptors
    //    of the other included record parameters, by including optional individual field descriptors of the type `never`. 
    //    In addition to these optional individual field descriptors, there should not be any other field descriptors in this `record` type.
    // `chemistry` and `zoology` are additional fields for the `grades` included record parameter.
    printAverage(75, 85, chemistry = 90, zoology = 80);
}
