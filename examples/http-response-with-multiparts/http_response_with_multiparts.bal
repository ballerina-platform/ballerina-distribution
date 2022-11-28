import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;

service /multiparts on new http:Listener(9092) {

    resource function get encoder() returns http:Response {
        // Creates an enclosing entity to hold the child parts.
        mime:Entity parentPart = new;

        // Creates a child part with the JSON content.
        mime:Entity childPart1 = new;
        childPart1.setJson({"name": "wso2"});
        // Creates another child part with a file.
        mime:Entity childPart2 = new;
        // This file path is relative to where the Ballerina is running.
        //If your file is located outside, give the
        //absolute file path instead.
        childPart2.setFileAsEntityBody("./files/test.xml", contentType = mime:TEXT_XML);
        // Creates an array to hold the child parts.
        mime:Entity[] childParts = [childPart1, childPart2];
        // Sets the child parts to the parent part.
        parentPart.setBodyParts(childParts,
            contentType = mime:MULTIPART_MIXED);
        // Creates an array to hold the parent part and set it to the response.
        mime:Entity[] immediatePartsToResponse = [parentPart];
        http:Response outResponse = new;
        outResponse.setBodyParts(immediatePartsToResponse, contentType = mime:MULTIPART_FORM_DATA);
        return outResponse;
    }
}

// Binds the listener to the service.
service /multiparts on new http:Listener(9090) {

    // This resource accepts multipart responses.
    resource function get decoder() returns string|http:InternalServerError|error {
        http:Client httpClient = check new ("localhost:9092");
        http:Response returnResult = check httpClient->/multiparts/encoder;
        // Extracts the body parts from the response.
        mime:Entity[] parentParts = check returnResult.getBodyParts();
        //Loops through body parts.
        foreach var parentPart in parentParts {
            handleNestedParts(parentPart);
        }
        return "Body Parts Received!";
    }
}

// Gets the child parts that are nested within the parent.
function handleNestedParts(mime:Entity parentPart) {
    string contentTypeOfParent = parentPart.getContentType();
    if (contentTypeOfParent.startsWith("multipart/")) {
        var childParts = parentPart.getBodyParts();
        if (childParts is mime:Entity[]) {
            log:printInfo("Nested Parts Detected!");
            foreach var childPart in childParts {
                handleContent(childPart);
            }
        } else {
            log:printError("Error retrieving child parts! " + childParts.message());
        }
    }
}

//The content logic that handles the body parts
//vary based on your requirement.
function handleContent(mime:Entity bodyPart) {
    string baseType = getBaseType(bodyPart.getContentType());
    if (mime:APPLICATION_XML == baseType || mime:TEXT_XML == baseType) {
        // Extracts XML data from the body part.
        var payload = bodyPart.getXml();
        if (payload is xml) {
             log:printInfo("XML data: " + payload.toString());
        } else {
             log:printError("Error in parsing XML data", 'error = payload);
        }
    } else if (mime:APPLICATION_JSON == baseType) {
        // Extracts JSON data from the body part.
        var payload = bodyPart.getJson();
        if (payload is json) {
            log:printInfo("JSON data: " + payload.toJsonString());
        } else {
             log:printError("Error in parsing JSON data", 'error = payload);
        }
    } else if (mime:TEXT_PLAIN == baseType) {
        // Extracts text data from the body part.
        var payload = bodyPart.getText();
        if (payload is string) {
            log:printInfo("Text data: " + payload);
        } else {
            log:printError("Error in parsing text data", 'error = payload);
        }
    } else if (mime:APPLICATION_PDF == baseType) {
        // Extracts the byte stream from the body part and saves it as a file.
        var payload = bodyPart.getByteStream();
        if (payload is stream<byte[], io:Error?>) {
            //Writes the incoming stream to a file using the `io:fileWriteBlocksFromStream` API by providing the file location to which the content should be written.
            io:Error? result = io:fileWriteBlocksFromStream("./files/ReceivedFile.pdf", payload);

            if (result is error) {
                log:printError("Error occurred while writing ", 'error = result);
            }
            close(payload);
        } else {
            log:printError("Error in parsing byte channel :", 'error = payload);
        }
    }
}

//Gets the base type from a given content type.
function getBaseType(string contentType) returns string {
    var result = mime:getMediaType(contentType);
    if (result is mime:MediaType) {
        return result.getBaseType();
    } else {
        panic result;
    }
}

//Closes the byte stream.
function close(stream<byte[], io:Error?> byteStream) {
    var cr = byteStream.close();
    if (cr is error) {
        log:printError("Error occurred while closing the stream: ", 'error = cr);
    }
}
