import ballerina/test;
import ballerina/io;

@test:Config {}
function testFunction() {
    io:println("I'm in test function!");
    test:assertEquals(10, 10);
}
