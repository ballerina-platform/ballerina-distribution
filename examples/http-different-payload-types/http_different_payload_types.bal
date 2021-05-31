import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;

//[Client](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client) endpoint.
http:Client clientEP = check new ("http://localhost:9091/backEndService");

//Service to test HTTP client remote functions with different payload types.
service /actionService on new http:Listener(9090) {

    resource function 'default messageUsage()
            returns string|http:InternalServerError|error? {
        //[GET](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#get) remote function without any payload.
        string greetingMessage = check clientEP->get("/greeting");
        handleResponse(greetingMessage);

        //[POST](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#post) remote function without any payload.
        http:Response response = check clientEP->post("/echo", ());
        handleResponse(response);

        //[POST](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#post) remote function with
        //text as the payload.
        string textResponse = check clientEP->post("/echo", "Sample Text");
        handleResponse(textResponse);

        //[POST](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#post) remote function with
        //`xml` as the payload.
        xml xmlResponse = check clientEP->post("/echo", xml `<yy>Sample Xml</yy>`);
        handleResponse(xmlResponse);

        //POST remote function with `json` as the payload.
        json jsonResponse = check clientEP->post("/echo", {name: "apple", color: "red"});
        handleResponse(jsonResponse);

        //[POST](https://docs.central.ballerina.io/ballerina/http/latest/clients/Client#post) remote function with
        //`byte[]` as the payload.
        string textVal = "Sample Text";
        byte[] binaryValue = textVal.toBytes();
        response = check clientEP->post("/echo", binaryValue);
        handleResponse(response);

        //Get a byte stream to a given file.
        var bStream = io:fileReadBlocksAsStream("/home/ayesh/projects/ballerina-platform/ballerina-distribution/new-examples/http-different-payload-types/files/logo.png");

        if (bStream is stream<byte[], io:Error?>) {
            //Make a POST request with a byte stream as the payload. Since the file path is static `<@untainted>` is used to denote that the byte stream is trusted.
            response = check clientEP->post("/image", <@untainted>bStream);
            handleResponse(response);

            //[Create a JSON body part](https://docs.central.ballerina.io/ballerina/mime/latest/classes/Entity#setJson).
            mime:Entity part1 = new;
            part1.setJson({"name": "Jane"});

            //[Create a text body part](https://docs.central.ballerina.io/ballerina/mime/latest/classes/Entity#setText).
            mime:Entity part2 = new;
            part2.setText("Hello");

            //Make a POST request with body parts as the payload.
            mime:Entity[] bodyParts = [part1, part2];
            response = check clientEP->post("/echo", bodyParts);
            handleResponse(response);

            return "Client actions successfully executed!";
        } else {
            return {body:bStream.message()};
        }
    }
}

//Back end service that send out different payload types as response.
service /backEndService on new http:Listener(9091) {

    resource function get greeting() returns string {
        return "Hello";
    }

    resource function post echo(http:Caller caller, http:Request req) returns error? {
        if (req.hasHeader("content-type")) {
            string baseType = getBaseType(req.getContentType());
            // filter requests based on content-type
            match (baseType) {
                mime:TEXT_PLAIN => {
                    string textValue = check req.getTextPayload();
                    check caller->respond(<@untainted>textValue);
                }
                mime:APPLICATION_XML => {
                    xml xmlValue = check req.getXmlPayload();
                    check caller->respond(<@untainted>xmlValue);
                }
                mime:APPLICATION_JSON => {
                    json jsonValue = check req.getJsonPayload();
                    check caller->respond(<@untainted>jsonValue);
                }
                mime:APPLICATION_OCTET_STREAM => {
                    byte[] blobValue = check req.getBinaryPayload();
                    check caller->respond(<@untainted>blobValue);
                }
                mime:MULTIPART_FORM_DATA => {
                    mime:Entity[] bodyParts = check req.getBodyParts();
                    check caller->respond(<@untainted>bodyParts);
                }
                _ => {
                    string message = "Could not find the requested content type";
                    http:Response res = new;
                    res.setTextPayload(message);
                    res.statusCode = 404;
                    check caller->respond(res);
                }
            }
        } else {
            check caller->respond(());
        }
    }

    resource function post image(http:Caller caller, http:Request req) returns error? {
        byte[] bytes = check req.getBinaryPayload();
        http:Response response = new;
        response.setBinaryPayload(<@untainted>bytes,
                                        contentType = mime:IMAGE_PNG);
        check caller->respond(response);
    }
}

//Handle response data received from HTTP client remote functions.
function handleResponse(string|xml|json|http:Response|error response) {
    if (response is string) {
        log:printInfo("Text data: " + response);
    } else if (response is xml) {
        log:printInfo("Xml data: " + response.toString());
    } else if (response is json) {
        log:printInfo("Json data: " + response.toJsonString());
    } else if (response is http:Response) {
        if (response.hasHeader("content-type")) {
            string baseType = getBaseType(response.getContentType());
            match (baseType) {
                mime:APPLICATION_OCTET_STREAM => {
                    string|http:ClientError payload = response.getTextPayload();
                    if (payload is string) {
                        log:printInfo("Response contains binary data: " + payload);
                    } else {
                        log:printError("Error in parsing binary data",
                                                    'error = payload);
                    }
                }
                mime:MULTIPART_FORM_DATA => {
                    log:printInfo("Response contains body parts: ");
                    var payload = response.getBodyParts();
                    if (payload is mime:Entity[]) {
                        handleBodyParts(payload);
                    } else {
                        log:printError("Error in parsing multipart data",
                                                    'error = payload);
                    }
                }
                mime:IMAGE_PNG => {
                    log:printInfo("Response contains an image");
                }
            }
        }
    } else {
        log:printError(response.message(), 'error = response);
    }
}

//Get the base type from a given content type.
function getBaseType(string contentType) returns string {
    var result = mime:getMediaType(contentType);
    if (result is mime:MediaType) {
        return result.getBaseType();
    } else {
        panic result;
    }
}

//Loop through body parts and print its content.
function handleBodyParts(mime:Entity[] bodyParts) {
    foreach var bodyPart in bodyParts {
        string baseType = getBaseType(bodyPart.getContentType());
        if (mime:APPLICATION_JSON == baseType) {
            var payload = bodyPart.getJson();
            if (payload is json) {
                log:printInfo("Json Part: " + payload.toJsonString());
            } else {
                log:printError(payload.message(), 'error = payload);
            }
        }
        if (mime:TEXT_PLAIN == baseType) {
            var payload = bodyPart.getText();
            if (payload is string) {
                log:printInfo("Text Part: " + payload);
            } else {
                log:printError(payload.message(), 'error = payload);
            }
        }
    }
}
