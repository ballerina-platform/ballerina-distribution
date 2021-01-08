import ballerina/io;
 
type Student record {
    string firstName;
    string lastName?;
};

type AdmissionDate record {
    string year = "2020";
    string month = "Jan";
    never admissionNo?;
};

type Grades record {|
    never math?;
    never physics?;
    int...;
|};

// Adding `*` before the parameter name marks the parameter as an included record parameter.
// The names of the fields in the record type of an included record parameter must be distinct 
// from each other and also from the names of the other parameters, unless it is an optional field of type never. 
// If not it create a compilation error.
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
    int count = grades.length() + 2;
 
    foreach int grade in grades {
        totalMarks += grade;
    }
 
    io:println("Average Marks: ", totalMarks/count);
}
 
public function main() {

    Student student = {
        firstName: "Anna",
        lastName: "Christeena"
    };
    
    // Call the function by passing a positional argument to the `student` included record parameter.
    printStudentDetails(1001, student);

    // Call the function by passing values for the fields of included record parameter. 
    // Need to supply values for required fields without explicit default values.
    // Unless accessing undefined key will result in a compilation error.
    printStudentDetails(1002, firstName = "Anne", lastName = "Doe");

    // Call the function by passing values only for the required fields of included record parameter.
    // The `lastName` field of included record parameter default to `()`. 
    printStudentDetails(1003, firstName = "Peter");

    // Call the function by passing only for the `admissionNo` parameter.
    // The fields `year` and `month` of the `date` included record parameter default to `2020` and `Jan` respectively.
    printAdmissionDate(1004);

    // The type of included record parameter allows additional fields if the following two conditions are satisfied. 
    // *. In the parameter list, there should be only one included record parameter that is of an open record type.
    // *. The open record type must disallow fields of the same names as the other parameters and individual field descriptors
    //    of the other included record parameters, by including optional individual field descriptors of the type never. 
    //    In addition to these optional individual field descriptors, there should not be any other field descriptors in this record type.
    // `chemistry` and `zoology` are additional fields for the `grades` included record parameter.
    printAverage(75, 85, chemistry = 90, zoology = 80);
}
