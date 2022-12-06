import ballerina/mime;
import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEP = check new("localhost:9090");
    mime:Entity jsonBodyPart = new;
    jsonBodyPart.setJson({ "name": "ballerina" });
    mime:Entity[] bodyParts = [jsonBodyPart];
    http:Request request = new;
    request.setBodyParts(bodyParts, contentType = mime:MULTIPART_FORM_DATA);
    http:Response response1 = check httpEP->post("/multiparts/decoder", request);
    mime:Entity[] result = check response1.getBodyParts();
    json jsonValue = check result[0].getJson();
    test:assertEquals(jsonValue.toJsonString(), "{\"name\":\"ballerina\"}");


    http:Response response2 = check httpEP->get("/multiparts/encoder");
    result = check response2.getBodyParts();
    jsonValue = check result[0].getJson();
    test:assertEquals(jsonValue.toString(), "{\"name\":\"wso2\"}");
    xml xmlValue = check result[1].getXml();
    xml element1 = xmlValue.selectDescendants("version");
    test:assertEquals(element1.data(), "0.963");
    xml element2 = xmlValue.selectDescendants("test");
    test:assertEquals(element2.data(), "test xml file to be used as a file part");
}
