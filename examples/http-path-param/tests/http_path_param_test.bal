import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    json response = check httpEndpoint->get("/company/empId/23");
    test:assertEquals(response, {empId:23});

    response = check httpEndpoint->get("/company/empName/Adele/Ferguson");
    test:assertEquals(response, {firstName:"Adele", lastName:"Ferguson"});
}
