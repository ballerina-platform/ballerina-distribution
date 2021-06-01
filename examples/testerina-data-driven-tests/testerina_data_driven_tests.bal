import ballerina/io;
import ballerina/test;

// The `dataProvider` attribute is used to specify a data-provider function for the test.
@test:Config { 
    dataProvider: stringDataProvider
}
// Data is passed to the function as function parameters.
function testAddingValues(string fValue, string sValue, string result) returns error? {
    int value1 = check 'int:fromString(fValue);
    int value2 = check 'int:fromString(sValue);
    int result1 = check 'int:fromString(result);
    io:println("Input : [" + fValue + "," + sValue + "," + result + "]");
    test:assertEquals(value1 + value2, result1, msg = "Incorrect Sum");
}

// The data provider function, which returns a `string` value-set.
function stringDataProvider() returns (string[][]) {
    return [["1", "2", "3"], ["10", "20", "30"], ["5", "6", "11"]];
}
