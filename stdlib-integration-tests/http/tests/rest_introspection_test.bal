// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/openapi;
import ballerina/test;

listener http:Listener restIntrospectionEP = new(9118);

@openapi:ServiceInfo {
  embed: true
}
service /hello on restIntrospectionEP {
    resource function get world() returns string {
        return "Hello, World!";
    }
}

http:Client restApiClient = checkpanic new("http://localhost:9118");

//Test Introspection Resource availability
@test:Config {}
function testIntrospectionResourceAvailability() returns error? {
    http:Response response = check restApiClient->options("/hello");
    test:assertEquals(response.statusCode, 204);
    test:assertTrue(response.hasHeader("Link"), "Could not find the Link header");
    string linkHeader = check response.getHeader("Link");
    test:assertEquals(linkHeader, "</hello/openapi-doc-dygixywsw>;rel=\"service-desc\"");
}

json openApiDocumentation = {
  "openapi" : "3.0.1",
  "info" : {
    "title" : "Hello",
    "version" : "1.0.0"
  },
  "servers" : [ {
    "url" : "{server}:{port}/hello",
    "variables" : {
      "server" : {
        "default" : "http://localhost"
      },
      "port" : {
        "default" : "9118"
      }
    }
  } ],
  "paths" : {
    "/world" : {
      "get" : {
        "operationId" : "operation_get_/world",
        "responses" : {
          "200" : {
            "description" : "Ok",
            "content" : {
              "text/plain" : {
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      }
    }
  },
  "components" : { }
};

//Test REST API Doc
@test:Config {}
function testRestApiDoc() returns error? {
    json receivedApiDoc = check restApiClient->get("/hello/openapi-doc-dygixywsw");
    test:assertEquals(receivedApiDoc, openApiDocumentation);
}

service /disabled on restIntrospectionEP {
    resource function get world() returns string {
        return "Hello, World!";
    }
}

@test:Config {}
function testUnavailableIntrospectionResource() returns error? {
    http:Response response = check restApiClient->options("/disabled");
    test:assertEquals(response.statusCode, 204);
    test:assertFalse(response.hasHeader("Link"), "Found link header in errorneous scenario");
}
