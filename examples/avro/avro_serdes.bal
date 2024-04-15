import ballerina/avro;
import ballerina/io;

// Define a type, which is a subtype of anydata.
type Student record {
    int id;
    string name;
};

public function main() returns error? {
    // Assign the value to the variable.
    Student student = {
        id: 1,
        name: "John"
    };

    // Create a schema instance by passing the string value of an Avro schema.
    avro:Schema schema = check new (string `{
        "namespace": "example.avro",
        "type": "record",
        "name": "Student",
        "fields": [
            {
                "name": "id", 
                "type": "int"
            },
            {
                "name": "name",
                "type": "string"
            }
        ]
    }`);

    // Serialize the record value to bytes.
    byte[] serializedData = check schema.toAvro(student);

    // Deserialize the record value to bytes. 
    Student studentResult = check schema.fromAvro(serializedData);

    // Print deserialized data.
    io:println("Student ID: ", studentResult.id);
    io:println("Student Name: ", studentResult.name);
}
