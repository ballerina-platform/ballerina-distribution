import ballerina/mime;
import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEP1 = check new("http://localhost:9090");
    http:Client httpEP2 = check new("http://localhost:9092");

    string response1 = check httpEP1->get("/multiparts/decoder");
    test:assertEquals(response1, "Body Parts Received!");

    http:Response|error response2 = httpEP2->get("/multiparts/encoder");
    if response2 is http:Response {
       var parentParts = response2.getBodyParts();
       if parentParts is mime:Entity[] {
           var childParts = parentParts[0].getBodyParts();
           if childParts is mime:Entity[] {
               var jsonValue = childParts[0].getJson();
               if jsonValue is json {
                   test:assertEquals(jsonValue.toString(), "{\"name\":\"wso2\"}");
               } else {
                   test:assertFail(msg = "Invalid json");
               }
               var xmlValue = childParts[1].getXml();
               if xmlValue is xml {
                   xml element1 = xmlValue.selectDescendants("version");
                   test:assertEquals(element1.data(), "0.963");
                   xml element2 = xmlValue.selectDescendants("test");
                   test:assertEquals(element2.data(), "test xml file to be used as a file part");
               } else {
                   test:assertFail(msg = "Invalid xml");
               }
           } else if childParts is error {
               test:assertFail(msg = "Invalid child parts");
           }
       } else if parentParts is error {
           test:assertFail(msg = "Invalid parent parts");
       }
    } else {
       test:assertFail(msg = "Error in calling multipart encoder");
    }
}
