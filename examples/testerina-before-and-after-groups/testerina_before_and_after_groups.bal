import ballerina/io;
import ballerina/test;

// The before-groups function, which is executed before
// the first test function belonging to the group `g1`.
@test:BeforeGroups { value:["g1"] }
function beforeGroupsFunc() {
    io:println("I'm the before groups function!");
}

// The after-groups function, which is executed after
// the last test function belonging to the group `g1`.
@test:AfterGroups { value:["g1"] }
function afterGroupsFunc() {
    io:println("I'm the after groups function!");
}

// A test function.
@test:Config { groups: ["g1"]}
function testFunction1() {
    io:println("I'm in test function 1!");
    test:assertTrue(true, msg = "Failed!");
}

// A test function.
@test:Config {}
function testFunction2() {
    io:println("I'm in test function 2!");
    test:assertTrue(true, msg = "Failed!");
}
