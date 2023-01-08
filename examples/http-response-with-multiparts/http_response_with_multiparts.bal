import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;

service /multiparts on new http:Listener(9092) {

    resource function get encoder() returns http:Response {
        // Creates an enclosing entity to hold the child parts.
        mime:Entity parentPart = new;
        mime:Entity childPart1 = new;
        childPart1.setJson({"name": "wso2"});
        mime:Entity childPart2 = new;
        // This file path is relative to where the Ballerina is running.
        // If your file is located outside, give the absolute file path instead.
        childPart2.setFileAsEntityBody("./files/test.xml", contentType = mime:TEXT_XML);
        mime:Entity[] childParts = [childPart1, childPart2];
        parentPart.setBodyParts(childParts, contentType = mime:MULTIPART_MIXED);
        // Creates an array to hold the parent part and set it to the response.
        mime:Entity[] immediatePartsToResponse = [parentPart];
        http:Response outResponse = new;
        outResponse.setBodyParts(immediatePartsToResponse, contentType = mime:MULTIPART_FORM_DATA);
        return outResponse;
    }
}

service /multiparts on new http:Listener(9090) {

    // This resource accepts multipart responses.
    resource function get decoder() returns string|http:InternalServerError|error {
        http:Client httpClient = check new ("localhost:9092");
        http:Response returnResult = check httpClient->/multiparts/encoder;
        mime:Entity[] parentParts = check returnResult.getBodyParts();
        foreach var parentPart in parentParts {
            handleNestedParts(parentPart);
        }
        return "Body Parts Received!";
    }
}

function handleNestedParts(mime:Entity parentPart) {
    string contentTypeOfParent = parentPart.getContentType();
    if contentTypeOfParent.startsWith("multipart/") {
        var childParts = parentPart.getBodyParts();
        if childParts is mime:Entity[] {
            log:printInfo("Nested Parts Detected!");
            foreach var childPart in childParts {
                handleContent(childPart);
            }
        } else {
            log:printError("Error retrieving child parts! " + childParts.message());
        }
    }
}

function handleContent(mime:Entity bodyPart) {
    string baseType = getBaseType(bodyPart.getContentType());
    if mime:APPLICATION_XML == baseType || mime:TEXT_XML == baseType {
        var payload = bodyPart.getXml();
        if payload is xml {
            log:printInfo("XML data: " + payload.toString());
        } else {
            log:printError("Error in parsing XML data", 'error = payload);
        }
    } else if mime:APPLICATION_JSON == baseType {
        var payload = bodyPart.getJson();
        if payload is json {
            log:printInfo("JSON data: " + payload.toJsonString());
        } else {
            log:printError("Error in parsing JSON data", 'error = payload);
        }
    } else if mime:TEXT_PLAIN == baseType {
        var payload = bodyPart.getText();
        if payload is string {
            log:printInfo("Text data: " + payload);
        } else {
            log:printError("Error in parsing text data", 'error = payload);
        }
    } else if mime:APPLICATION_PDF == baseType {
        var payload = bodyPart.getByteStream();
        if payload is stream<byte[], io:Error?> {
            // Writes the incoming stream to a file using the `io:fileWriteBlocksFromStream` API by providing the
            // file location to which the content should be written.
            io:Error? result = io:fileWriteBlocksFromStream("./files/ReceivedFile.pdf", payload);
            if result is error {
                log:printError("Error occurred while writing ", 'error = result);
            }
            close(payload);
        } else {
            log:printError("Error in parsing byte channel :", 'error = payload);
        }
    }
}

function getBaseType(string contentType) returns string {
    var result = mime:getMediaType(contentType);
    if result is mime:MediaType {
        return result.getBaseType();
    }
    panic result;
}

function close(stream<byte[], io:Error?> byteStream) {
    var cr = byteStream.close();
    if cr is error {
        log:printError("Error occurred while closing the stream: ", 'error = cr);
    }
}
