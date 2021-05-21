import ballerina/io;
import ballerina/test;

// Executed before all the test functions in the module.
@test:BeforeSuite
function beforeSuit() {
    io:println("I'm the before suite function!");
}

// A Test function.
@test:Config { }
function testFunction1() {
    io:println("I'm in test function 1!");
    test:assertTrue(true, msg = "Failed");
}

// A Test function.
@test:Config { }
function testFunction2() {
    io:println("I'm in test function 2!");
    test:assertTrue(true, msg = "Failed");
}

// Executed after all the test functions in the module.
@test:AfterSuite { }
function afterSuite() {
    io:println("I'm the after suite function!");
}
