import ballerina/http;
import ballerina/log;
import ballerina/mime;

http:Client clientEP = check new ("http://localhost:9090");

//Binds the listener to the service.
service /multiparts on new http:Listener(9090) {

    resource function post decoder(http:Request request)
            returns http:Response|http:InternalServerError|error {
        http:Response response = new;
        // Extracts body parts from the request.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Request#getBodyParts.
        var bodyParts = check request.getBodyParts();
        foreach var part in bodyParts {
            handleContent(part);
        }
        response.setPayload(bodyParts);
        return response;
    }

    resource function get encoder(http:Request req) returns
            http:Response|http:InternalServerError|error {
        //Create a `json` body part.
        mime:Entity jsonBodyPart = new;
        jsonBodyPart.setContentDisposition(getContentDispositionForFormData("json part"));
        jsonBodyPart.setJson({"name": "wso2"});
        //Create an `xml` body part as a file upload.
        mime:Entity xmlFilePart = new;
        xmlFilePart.setContentDisposition(getContentDispositionForFormData("xml file part"));
        // This file path is relative to where Ballerina is running.
        // If your file is located outside,
        // give the absolute file path instead.
        xmlFilePart.setFileAsEntityBody("./files/test.xml", contentType = mime:APPLICATION_XML);
        // Create an array to hold all the body parts.
        mime:Entity[] bodyParts = [jsonBodyPart, xmlFilePart];
        http:Request request = new;
        // Set the body parts to the request.
        // For details, see https://lib.ballerina.io/ballerina/http/latest/classes/Request#setBodyParts.
        // Here the content-type is set as multipart form data.
        // This also works with any other multipart media type.
        // E.g., `multipart/mixed`, `multipart/related` etc.
        // You need to pass the content type that suits your requirement.
        request.setBodyParts(bodyParts, contentType = mime:MULTIPART_FORM_DATA);
        http:Response returnResponse = check clientEP->/multiparts/decoder.post(request);
        return returnResponse;
    }
}

// The content logic that handles the body parts vary based on your requirement.
function handleContent(mime:Entity bodyPart) {
    // Get the media type from the body part retrieved from the request.
    // For details, see https://lib.ballerina.io/ballerina/mime/latest/functions#getMediaType.
    var mediaType = mime:getMediaType(bodyPart.getContentType());
    if mediaType is mime:MediaType {
        string baseType = mediaType.getBaseType();
        if (mime:APPLICATION_XML == baseType || mime:TEXT_XML == baseType) {
            // Extracts `xml` data from the body part.
            // For details, see https://lib.ballerina.io/ballerina/mime/latest/classes/Entity#getXml.
            var payload = bodyPart.getXml();
            if payload is xml {
                log:printInfo(payload.toString());
            } else {
                log:printError(payload.message());
            }
        } else if (mime:APPLICATION_JSON == baseType) {
            // Extracts `json` data from the body part.
            // For details, see https://lib.ballerina.io/ballerina/mime/latest/classes/Entity#getJson.
            var payload = bodyPart.getJson();
            if payload is json {
                log:printInfo(payload.toJsonString());
            } else {
                log:printError(payload.message());
            }
        } else if (mime:TEXT_PLAIN == baseType) {
            // Extracts text data from the body part.
            // For details, see https://lib.ballerina.io/ballerina/mime/latest/classes/Entity#getText.
            var payload = bodyPart.getText();
            if payload is string {
                log:printInfo(payload);
            } else {
                log:printError(payload.message());
            }
        }
    }
}

function getContentDispositionForFormData(string partName) returns (mime:ContentDisposition) {
    mime:ContentDisposition contentDisposition = new;
    contentDisposition.name = partName;
    contentDisposition.disposition = "form-data";
    return contentDisposition;
}
