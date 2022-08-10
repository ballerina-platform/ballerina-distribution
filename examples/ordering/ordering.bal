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
        {firstName: "Rocky", lastName: "Irving", salary: 6000.00},
        {firstName: "Anne", lastName: "Perera", salary: 3000.00},
        {firstName: "Jermaine", lastName: "Perera", salary: 4000.00},
        {firstName: "Miya", lastName: "Bauer", salary: 9000.00},
        {firstName: "Rocky", lastName: "Puckett", salary: 6000.00},
        {firstName: "Jermaine", lastName: "Kent", salary: 4000.00}
    ];

    Employee[] sorted = from var e in employees
                        // The `order by` clause sorts the output items based on the
                        // given `order-key` and `order-direction`. The `order-key`
                        // must be an `ordered` type. The `order-direction` is `ascending`
                        // if not specified explicitly.
                        order by e.firstName ascending, e.lastName descending


                        select e;

    foreach Employee e in sorted {
        io:println(e.firstName, " ", e.lastName);
    }
}
