import ballerina/io;
import ballerina/test;

// This test function depends on the `testFunction3`.
@test:Config { 
    dependsOn: [testFunction3] }
function testFunction1() {
    io:println("I'm in test function 1!");
    test:assertTrue(true, msg = "Failed!");
}

// This test function depends on the `testFunction1`.
@test:Config { dependsOn: [testFunction1] }
function testFunction2() {
    io:println("I'm in test function 2!");
    test:assertTrue(true, msg = "Failed!");
}

// This will be executed without depending on other functions.
// However, since other functions depend on this function, it will be executed first.
@test:Config { }
function testFunction3() {
    io:println("I'm in test function 3!");
    test:assertTrue(true, msg = "Failed!");
}
