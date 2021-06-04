import ballerina/io;

type Employee record {
    string firstName;
    string lastName;
    decimal salary;
};

public function main() {
    Employee[] employees = [
        {firstName: "Jones", lastName: "Welsh", salary: 1000.00},
        {firstName: "Anne", lastName: "Frank", salary: 5000.00},
        {firstName: "Michael", lastName: "Cain", salary: 10000.00},
        {firstName: "Tom", lastName: "Hiddleston", salary: 2000.00}
    ];

    Employee[] top3 = from var e in employees
                      order by e.salary descending
                      // The `limit` clause limits the number of output items to 3.
                      limit 3


                      select e;

    foreach var emp in top3 {
        io:println(emp);
    }
}
