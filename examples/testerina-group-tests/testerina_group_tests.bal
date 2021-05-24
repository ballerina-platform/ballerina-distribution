import ballerina/io;
import ballerina/test;

// Belongs to the test group `g1`.
@test:Config { groups: ["g1"] }
function testFunction1() {
    io:println("I'm in test belonging to group g1!");
    test:assertTrue(true, msg = "Failed!");
}

// Belongs to the test groups `g1` and `g2`.
@test:Config { groups: ["g1", "g2"] }
function testFunction2() {
    io:println("I'm in test belonging to groups g1 and g2!");
    test:assertTrue(true, msg = "Failed!");
}

// Does not belong to any test group.
@test:Config { }
function testFunction3() {
    io:println("I'm the ungrouped test");
    test:assertTrue(true, msg = "Failed!");
}
