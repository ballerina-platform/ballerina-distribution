import ballerina/io;

type Department record {|
   int id;
   string name;
|};

type Person record {|
   int id;
   string fname;
   string lname;
|};

type DeptPerson record {|
   string fname;
   string? dept;
|};

public function main() {
    Person p1 = {id: 1, fname: "Alex", lname: "George"};
    Person p2 = {id: 2, fname: "John", lname: "Fonseka"};
    Person p3 = {id: 3, fname: "Ted", lname: "Perera"};

    Department d1 = {id: 1, name:"HR"};
    Department d2 = {id: 2, name:"Operations"};

    Person[] personList = [p1, p2, p3];
    Department[] deptList = [d1, d2];

    DeptPerson[] deptPersonList =
       from Person person in personList
       // The `outer join` clause performs a left outer equijoin.
       // For the records for which there is no matching record
       // on the `deptList`, the resulting record will contain `nil` fields.
       outer join var dept in deptList
       on person.id equals dept?.id
       select {
           fname : person.fname,
           dept : dept?.name
       };

    io:println(deptPersonList);
}
