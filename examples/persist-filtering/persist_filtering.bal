import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    // Filter Employee records by gender
    stream<store:Employee, persist:Error?> employees = sClient->/employees;
    store:Employee[] filtered = check from var employee in employees
                        where employee.gender == "Male"
                        select employee;
    foreach store:Employee e in filtered {
        io:println(e);
    }

    // Order by Employee records by first name in ascending order, and then by last name in descending order
    stream<EmployeeName, persist:Error?> empNames = sClient->/employees;
    EmployeeName[] sorted = check from var e in empNames
                        order by e.firstName ascending, e.lastName descending
                        select e;
    foreach EmployeeName e in sorted {
        io:println(e.firstName, " ", e.lastName);
    }


    // Limit the results to 2
    employees = sClient->/employees;
    store:Employee[] limited = check from var employee in employees
                            order by employee.age descending
                            limit 2
                            select employee;

    foreach store:Employee e in limited {
        io:println(e);
    }
}

// A record with subset of fields
type EmployeeName record {|
    string id;
    string firstName;
    string lastName;
|};
