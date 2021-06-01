import ballerina/io;

type Headers record {
   string 'from;
   string to;

   // Records can have optional fields
   string subject?;

};

Headers h = {
  'from: "John",
  to: "Jill"
};

//Use ?. operator to access optional field
string? subject = h?.subject;

public function main() {
    io:println("Header value: ", h);
    io:println("Subject value:", subject);
}
