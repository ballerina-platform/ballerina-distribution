
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
import ballerina/lang.'string as strings;
import ballerina/mime;
import ballerina/test;

listener http:Listener passthroughEP1 = new(9113);

service http:Service /passthrough on passthroughEP1 {

    resource function get .(http:Request clientRequest) returns http:Response|http:InternalServerError|error {
        http:Client nyseEP1 = check new("http://localhost:9113");
        http:Response|error response = nyseEP1->get("/nyseStock/stocks");
        if (response is http:Response) {
            return response;
        } else {
            return { body: "error occurred while invoking the service" };
        }
    }

    resource function post forwardMultipart(http:Request clientRequest) returns http:Response|http:InternalServerError|error {
        http:Client nyseEP1 = check new("http://localhost:9113");
        http:Response|error response = nyseEP1->forward("/nyseStock/stocksAsMultiparts", clientRequest);
        if (response is http:Response) {
            return response;
        } else {
            return { body: "error occurred while invoking the service" };
        }
    }

    resource function post forward(http:Request clientRequest) returns http:Ok|http:InternalServerError|error {
        http:Client nyseEP1 = check new("http://localhost:9113");
        http:Response|error response = nyseEP1->forward("/nyseStock/entityCheck", clientRequest);
        if (response is http:Response) {
            var entity = response.getEntity();
            if (entity is mime:Entity) {
                string|error payload = entity.getText();
                if (payload is string) {
                    http:Ok ok = {body: payload + ", " + checkpanic entity.getHeader("X-check-header")};
                    return ok;
                } else {
                    http:InternalServerError err = {body: payload.toString()};
                    return err;
                }
            } else {
                http:InternalServerError err = {body: entity.toString()};
                return err;
            }
        } else {
            http:InternalServerError err = {body: response.toString()};
            return err;
        }
    }
}

service http:Service /nyseStock on passthroughEP1 {

    resource function get stocks() returns json {
        return { "exchange": "nyse", "name": "IBM", "value": "127.50" };
    }

    resource function post stocksAsMultiparts(http:Caller caller, http:Request clientRequest) returns error? {
        mime:Entity[] bodyParts = check clientRequest.getBodyParts();
        check caller->respond(bodyParts);
    }

    resource function post entityCheck(http:Request clientRequest) returns http:Response|http:InternalServerError|error? {
        http:Response res = new;
        var entity = clientRequest.getEntity();
        if (entity is mime:Entity) {
            json|error textPayload = entity.getText();
            if (textPayload is string) {
                mime:Entity mimeEntity = new;
                mimeEntity.setText("payload :" + textPayload + ", header: " + check entity.getHeader("Content-type"));
                mimeEntity.setHeader("X-check-header", "entity-check-header");
                res.setEntity(mimeEntity);
                return res;
            }
            return {body: "Error while retrieving from entity"};
        }
        return {body: "Error while retrieving from request"};
    }
}

@test:Config {}
public function testPassthroughServiceByBasePath() returns error? {
    http:Client httpClient = check new("http://localhost:9113");
    json resp = check httpClient->get("/passthrough");
    test:assertEquals(resp, {"exchange":"nyse", "name":"IBM", "value":"127.50"});
}

@test:Config {}
public function testPassthroughServiceWithMimeEntity() returns error?  {
    http:Client httpClient = checkpanic new("http://localhost:9113");
    string resp = check httpClient->post("/passthrough/forward", "Hello from POST!");
    test:assertEquals(resp, "payload :Hello from POST!, header: text/plain, entity-check-header");
}

@test:Config {}
public function testPassthroughWithMultiparts() {
    http:Client httpClient = checkpanic new("http://localhost:9113");
    mime:Entity textPart1 = new;
    textPart1.setText("Part1");
    textPart1.setHeader("Content-Type", "text/plain; charset=UTF-8");

    mime:Entity textPart2 = new;
    textPart2.setText("Part2");
    textPart2.setHeader("Content-Type", "text/plain");

    mime:Entity[] bodyParts = [textPart1, textPart2];
    http:Request request = new;
    request.setBodyParts(bodyParts, contentType = mime:MULTIPART_FORM_DATA);
    http:Response|error resp = httpClient->post("/passthrough/forwardMultipart", request);
    if (resp is http:Response) {
        string contentType = checkpanic resp.getHeader("content-type");
        test:assertTrue(strings:includes(contentType, "multipart/form-data"));
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
        test:assertFail(msg = "Found unexpected output: " +  resp.message());
    }
}
