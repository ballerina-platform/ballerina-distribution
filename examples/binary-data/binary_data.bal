import ballerina/io;
 
public function main() {
    // Creates a `byte` array using the `base16` byte array literal.
    byte[] arr1 = base16 `55 EE 66 FF 77 AB`;
    io:println(arr1);
    
    // Creates a `byte` array using the `base64` byte array literal.
    byte[] arr2 = base64 `ABCD pqrs 5678 +/12`;
    io:println(arr2);
}
