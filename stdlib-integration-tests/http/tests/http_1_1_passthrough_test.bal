// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/mime;
import ballerina/stringutils;
import ballerina/test;

listener http:Listener passthroughEP1 = new(9113);

@http:ServiceConfig { basePath: "/passthrough" }
service passthroughService on passthroughEP1 {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    resource function passthrough(http:Caller caller, http:Request clientRequest) {
        http:Client nyseEP1 = new("http://localhost:9113");
        var response = nyseEP1->get("/nyseStock/stocks", <@untainted> clientRequest);
        if (response is http:Response) {
            checkpanic caller->respond(response);
        } else {
            checkpanic caller->respond({ "error": "error occurred while invoking the service" });
        }
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/forwardMultipart"
    }
    resource function forwardMultipart(http:Caller caller, http:Request clientRequest) {
        http:Client nyseEP1 = new("http://localhost:9113");
        var response = nyseEP1->forward("/nyseStock/stocksAsMultiparts", clientRequest);
        if (response is http:Response) {
            checkpanic caller->respond(response);
        } else {
            checkpanic caller->respond({ "error": "error occurred while invoking the service" });
        }
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/forward"
    }
    resource function accessInboundEntity(http:Caller caller, http:Request clientRequest) {
        http:Client nyseEP1 = new("http://localhost:9113");
        var response = nyseEP1->forward("/nyseStock/entityCheck", clientRequest);
        if (response is http:Response) {
            var entity = response.getEntity();
            if (entity is mime:Entity) {
                json|error payload = entity.getText();
                if (payload is string) {
                    checkpanic caller->ok(<@untainted> (payload + ", " + entity.getHeader("X-check-header")));
                } else {
                    checkpanic caller->internalServerError(<@untainted> payload.toString());
                }
            } else {
                checkpanic caller->internalServerError(<@untainted> entity.toString());
            }
        } else {
            checkpanic caller->internalServerError(<@untainted> (<error>response).toString());
        }
    }
}

@http:ServiceConfig { basePath: "/nyseStock" }
service nyseStockQuote1 on passthroughEP1 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/stocks"
    }
    resource function stocks(http:Caller caller, http:Request clientRequest) {
        checkpanic caller->respond({ "exchange": "nyse", "name": "IBM", "value": "127.50" });
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/stocksAsMultiparts"
    }
    resource function stocksAsMultiparts(http:Caller caller, http:Request clientRequest) {
        var bodyParts = clientRequest.getBodyParts();
        if (bodyParts is mime:Entity[]) {
            checkpanic caller->respond(<@untainted> bodyParts);
        } else {
            checkpanic caller->respond(<@untainted> bodyParts.message());
        }
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/entityCheck"
    }
    resource function accessInboundRequestEntity(http:Caller caller, http:Request clientRequest) {
        http:Response res = new;
        var entity = clientRequest.getEntity();
        if (entity is mime:Entity) {
            json|error textPayload = entity.getText();
            if (textPayload is string) {
                mime:Entity ent = new;
                ent.setText(<@untainted> ("payload :" + textPayload + ", header: " + entity.getHeader("Content-type")));
                ent.setHeader("X-check-header", "entity-check-header");
                res.setEntity(ent);
                checkpanic caller->ok(res);
            } else {
                checkpanic caller->internalServerError("Error while retrieving from entity");
            }
        } else {
            checkpanic caller->internalServerError({ message: "Error while retrieving from request" });
        }
    }
}

@test:Config {}
public function testPassthroughServiceByBasePath() {
    http:Client httpClient = new("http://localhost:9113");
    var resp = httpClient->get("/passthrough");
    if (resp is http:Response) {
        string contentType = resp.getHeader("content-type");
        test:assertEquals(contentType, "application/json");
        var body = resp.getJsonPayload();
        if (body is json) {
            test:assertEquals(body.toJsonString(), "{\"exchange\":\"nyse\", \"name\":\"IBM\", \"value\":\"127.50\"}");
        } else {
            test:assertFail(msg = "Found unexpected output: " + body.message());
        } 
    } else {
        test:assertFail(msg = "Found unexpected output: " +  (<error>resp).message());
    }
}

@test:Config {}
public function testPassthroughServiceWithMimeEntity() {
    http:Client httpClient = new("http://localhost:9113");
    var resp = httpClient->post("/passthrough/forward", "Hello from POST!");
    if (resp is http:Response) {
        string contentType = resp.getHeader("content-type");
        test:assertEquals(contentType, "text/plain");
        var body = resp.getTextPayload();
        if (body is string) {
            test:assertEquals(body, "payload :Hello from POST!, header: text/plain, entity-check-header");
        } else {
            test:assertFail(msg = "Found unexpected output: " + body.message());
        } 
    } else {
        test:assertFail(msg = "Found unexpected output: " +  (<error>resp).message());
    }
}

@test:Config {}
public function testPassthroughWithMultiparts() {
    http:Client httpClient = new("http://localhost:9113");
    mime:Entity textPart1 = new;
    textPart1.setText("Part1");
    textPart1.setHeader("Content-Type", "text/plain; charset=UTF-8");

    mime:Entity textPart2 = new;
    textPart2.setText("Part2");
    textPart2.setHeader("Content-Type", "text/plain");

    mime:Entity[] bodyParts = [textPart1, textPart2];
    http:Request request = new;
    request.setBodyParts(bodyParts, contentType = mime:MULTIPART_FORM_DATA);
    var resp = httpClient->post("/passthrough/forwardMultipart", request);
    if (resp is http:Response) {
        string contentType = resp.getHeader("content-type");
        test:assertTrue(stringutils:contains(contentType, "multipart/form-data"));
        var respBodyParts = resp.getBodyParts();
        if (respBodyParts is mime:Entity[]) {
            test:assertEquals(respBodyParts.length(), 2);
            string|error textPart = respBodyParts[0].getText();
            if (textPart is string) {
                test:assertEquals(textPart, "Part1");
            } else {
                test:assertFail(msg = "Found an unexpected output: " + textPart.message());
            }
            string|error txtPart2 = respBodyParts[1].getText();
            if (txtPart2 is string) {
                test:assertEquals(txtPart2, "Part2");
            } else {
                test:assertFail(msg = "Found an unexpected output: " + txtPart2.message());
            }
        }         
    } else {
        test:assertFail(msg = "Found unexpected output: " +  (<error>resp).message());
    }
}
