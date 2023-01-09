import ballerina/io;

string[] students = ["John", "Mike", "Mia"];
 
public function main() {
    int[] studentIds = [0, 1, 2];
    // `getStudentAPI()` is not invoked at the time of the stream creation.
    var studentsStream = stream from var id in studentIds
                            select getStudentAPI(id);
 
    // `getStudentAPI()` is invoked when calling the `next()` method of the constructed stream.
    var student = studentsStream.next();
    // `next()` will return an error if an evaluation of a query clause result in an error.
    while (student !is error?) {
        io:println(student.value);
        student = studentsStream.next();
    }
}
 
function getStudentAPI(int studentId) returns string {
    io:println("request to get student name API");
    return students[studentId];
}
