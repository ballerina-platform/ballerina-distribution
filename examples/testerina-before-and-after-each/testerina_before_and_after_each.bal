import ballerina/io;
import ballerina/test;

// The `BeforeEach` function is executed before each test function.
@test:BeforeEach
function beforeEachFunc() {
    io:println("I'm the before each function!");
}

// The `AfterEach` function is executed after each test function.
@test:AfterEach
function afterEachFunc() {
    io:println("I'm the after each function!");
}

// A test function.
@test:Config { }
function testFunction1() {
    io:println("I'm in test function 1!");
    test:assertTrue(true, msg = "Failed!");
}

// Another test function.
@test:Config { }
function testFunction2() {
    io:println("I'm in test function 2!");
    test:assertTrue(true, msg = "Failed!");
}
