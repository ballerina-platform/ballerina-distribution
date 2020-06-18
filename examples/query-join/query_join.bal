import ballerina/io;

type Student record {
    string firstName;
    string lastName;
    int intakeYear;
    int deptId;
};

type Department record {
    int deptId;
    string deptName;
};

type Report record {
    string name;
    string deptName;
    string degree;
    int intakeYear;
};

public function main() {

    Student s1 = {firstName: "Alex", lastName: "George", intakeYear: 2020, deptId: 1};
    Student s2 = {firstName: "Ranjan", lastName: "Fonseka", intakeYear: 2023, deptId: 3};
    Student s3 = {firstName: "John", lastName: "David", intakeYear: 2022, deptId:1};
    Student s4 = {firstName: "Gorge", lastName: "Fernando", intakeYear: 2021, deptId: 2};

    Department d1 = {deptId: 1, deptName:"Physics"};
    Department d2 = {deptId: 2, deptName:"Mathematics"};
    Department d3 = {deptId: 3, deptName:"Chemistry"};

    Student[] studentList = [s1, s2, s3, s4];
    Department[] departmentList = [d1, d2, d3];

    // The `from` clause works similarly to a `foreach` statement.
    // It can be used to iterate any iterable value.
    // The `reportList` is the result of the `query expression`.
    Report[] reportList = from var student in studentList
       // An inner equijoin is performed here.
       // The `join` clause iterates any iterable value similarly to the `from` clause.
       join var department in departmentList
       // The `on` condition is used to match the `student` with `department` based on `deptId`.
       // The iteration skips the following clauses when the condition is not satisfied.
       on student.deptId equals department.deptId
       // The `select` clause is evaluated for each iteration where the `on` condition is satisfied.
       select {
              name: student.firstName,
              deptName: department.deptName,
              degree: "Bachelor of Science",
              intakeYear: student.intakeYear
       }
       // The `limit` clause limits the number of output items.
       limit 3;

    foreach var report in reportList {
        io:println(report);
    }
}
