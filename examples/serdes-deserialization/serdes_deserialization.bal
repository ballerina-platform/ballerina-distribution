import ballerina/io;
import ballerina/serdes;

// Define a type, which is a subtype of anydata.
type Student record {
    int id;
    string name;
    decimal fees;
};

public function main() returns error? {

    // Create a deserialization object by passing the typedesc.
    // This creates an underlying protocol buffer schema for the typedesc.
    serdes:Proto3Schema serdes = check new (Student);

    // Obtain the previously serialized byte array.
    byte[] serializedValue = [10, 9, 8, 2, 16, 7, 26, 3, 38, 37, 159, 16, 172, 123, 26, 4, 76, 105, 97, 109];

    // Deserialize the record value to Student type value. 
    Student deserializedValue = check serdes.deserialize(serializedValue);

    // Print deserialized data.
    io:println(deserializedValue);
}
