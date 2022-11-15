import ballerina/io;
import ballerina/serdes;

// Define a type, which is a subtype of anydata.
type Student record {
    int id;
    string name;
    decimal fees;
};

public function main() returns error? {

    // Assign the value to the variable.
    Student studentValue = {
        id: 7894,
        name: "Liam",
        fees: 24999.99
    };

    // Create a serialization object by passing the typedesc.
    // This creates an underlying protocol buffer schema for the typedesc.
    serdes:Proto3Schema serdes = check new (Student);

    // Serialize the record value to bytes.
    byte[] serializedValue = check serdes.serialize(studentValue);

    // Print serialized byte array.
    io:println(serializedValue);
}
