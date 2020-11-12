import ballerina/java;
import ballerina/test;

@test:Config {
}
function testFunction() {
    test:assertEquals(<string>java:toString(testAcceptNothingButReturnString()), "This is a test string value !!!");
    test:assertEquals(sayHello(), "Hello John!");
}
