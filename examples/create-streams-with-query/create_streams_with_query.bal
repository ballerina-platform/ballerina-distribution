import ballerina/io;
 
string[] studentNames = ["John", "Mike", "Mia"];
 
public function main() {
    int[] studentId = [0, 1, 2];
    // `getStudentNameAPI` is not invoked at the time of the stream creation.
    var studentNameStream = stream from var id in studentId
                            select getStudentNameAPI(id);
 
    // `getStudentNameAPI` is invoked when calling the `next()` method of the consturcted stream.
    var studentName = studentNameStream.next();
    // `next()` will return an error if an evaluation of a query clause result in an error.
    while (studentName !is error?) {
        io:println(studentName.value);
        studentName = studentNameStream.next();
    }
}
 
function getStudentNameAPI(int studentId) returns string {
    io:println("request to get student name API");
    return studentNames[studentId];
}
