import ballerina/mime;
import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEP1 = check new("localhost:9090");
    http:Client httpEP2 = check new("localhost:9092");

    string response1 = check httpEP1->get("/multiparts/decoder");
    test:assertEquals(response1, "Body Parts Received!");

    http:Response response2 = check httpEP2->get("/multiparts/encoder");
    mime:Entity[] parentParts = check response2.getBodyParts();
    mime:Entity[] childParts = check parentParts[0].getBodyParts();
    json jsonValue = check childParts[0].getJson();
    test:assertEquals(jsonValue.toString(), "{\"name\":\"wso2\"}");
    xml xmlValue = check childParts[1].getXml();
    xml element1 = xmlValue.selectDescendants("version");
    test:assertEquals(element1.data(), "0.963");
    xml element2 = xmlValue.selectDescendants("test");
    test:assertEquals(element2.data(), "test xml file to be used as a file part");
}
