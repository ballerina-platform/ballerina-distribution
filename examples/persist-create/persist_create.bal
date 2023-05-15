import ballerina/io;
import rainier.store;
import ballerina/persist;

store:Client sClient = check new ();

public function main() returns error? {
    store:EmployeeInsert employee1 = {
        id: uuid:createType4AsString(),
        firstName: "John",
        lastName: "Doe",
        gender: "Male",
        birthDate: {
            year: 1987,
            month: 7,
            day: 23
        },
        hireDate: {
            year: 2020,
            month: 10,
            day: 10
        }
    };

    store:EmployeeInsert employee2 = {
        id: uuid:createType4AsString(),
        firstName: "Jane",
        lastName: "Doe",
        gender: "Female",
        birthDate: {
            year: 1989,
            month: 7,
            day: 11
        },
        hireDate: {
            year: 2020,
            month: 10,
            day: 10
        }
    };

    string[] employeeIds = check sClient->/employees.post([employee1, employee2]);
    io:println(string `Inserted employee id: ${employeeIds.toString()}`);
}
