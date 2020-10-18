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

// NOTE: All the tokens/credentials used in this test are dummy tokens/credentials and used only for testing purposes.

import ballerina/http;
import ballerina/test;

@test:Config {}
public function testWithoutTokenPropagation() {
    http:Client clientEP = new("https://localhost:20104", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP->get("/passthrough", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testTokenPropagationWithBasicAuthInbound() {
    http:Client clientEP = new("https://localhost:20106", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });
    http:Request req = new;
    req.setHeader("Authorization", "Basic Y2hhbmFrYToxMjM=");
    var response = clientEP->get("/passthrough", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testTokenPropagationWithJwtAuthInbound() {
    http:Client clientEP = new("https://localhost:20108", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3M" +
               "iOiJleGFtcGxlMSIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjh" +
               "jYTIzM2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEiLCJiYWxsZXJpbmEub3JnIiwiYmFsbGVyaW5hLmlvIl0sInNjb3B" +
               "lIjoiaGVsbG8ifQ.W_lvdp_o3o7MBVWeumg2fvIVSFWoGl9OFv2qyAz_g2afJwUWrFYOUd-1rj9lebZrQzqTd6RRX65MVF3G" +
               "ksSeIT9McZxjPiSX1FR-nIUTcJ9anaoQVEKo3OpkIPzd_4_95CpHXF1MaW18ww5h_NShQnUrN7myrBfc-UbHsqC1YEBAM2M-" +
               "3NMs8jjgcZHfZ1JjomZCjd5eUXz8R5Vl46uAlSbFAmxAfY1T-31qUB93eCL2iJfDc70OK2txohryntw9h-OePwQULJN0Eiwp" +
               "oI60HQFFlgC1g_crPIDakBTiEITrbO3OzrNeCQFBN-Ji4BTXq97TulCIRNneDLCUBSRE1A");
    var response = clientEP->get("/passthrough", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

@test:Config {}
public function testTokenPropagationWithJwtAuthInboundAndTokenReissuing() {
    http:Client clientEP = new("https://localhost:20110", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3M" +
               "iOiJleGFtcGxlMSIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjh" +
               "jYTIzM2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEiLCJiYWxsZXJpbmEub3JnIiwiYmFsbGVyaW5hLmlvIl0sInNjb3B" +
               "lIjoiaGVsbG8ifQ.W_lvdp_o3o7MBVWeumg2fvIVSFWoGl9OFv2qyAz_g2afJwUWrFYOUd-1rj9lebZrQzqTd6RRX65MVF3G" +
               "ksSeIT9McZxjPiSX1FR-nIUTcJ9anaoQVEKo3OpkIPzd_4_95CpHXF1MaW18ww5h_NShQnUrN7myrBfc-UbHsqC1YEBAM2M-" +
               "3NMs8jjgcZHfZ1JjomZCjd5eUXz8R5Vl46uAlSbFAmxAfY1T-31qUB93eCL2iJfDc70OK2txohryntw9h-OePwQULJN0Eiwp" +
               "oI60HQFFlgC1g_crPIDakBTiEITrbO3OzrNeCQFBN-Ji4BTXq97TulCIRNneDLCUBSRE1A");
    var response = clientEP->get("/passthrough", req);
    if (response is http:Response) {
        assertOK(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}

public function testTokenPropagationWithJwtAuthInboundAndTokenReissuingNegative() {
    http:Client clientEP = new("https://localhost:20112", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3M" +
               "iOiJleGFtcGxlMSIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjh" +
               "jYTIzM2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEiLCJiYWxsZXJpbmEub3JnIiwiYmFsbGVyaW5hLmlvIl0sInNjb3B" +
               "lIjoiaGVsbG8ifQ.W_lvdp_o3o7MBVWeumg2fvIVSFWoGl9OFv2qyAz_g2afJwUWrFYOUd-1rj9lebZrQzqTd6RRX65MVF3G" +
               "ksSeIT9McZxjPiSX1FR-nIUTcJ9anaoQVEKo3OpkIPzd_4_95CpHXF1MaW18ww5h_NShQnUrN7myrBfc-UbHsqC1YEBAM2M-" +
               "3NMs8jjgcZHfZ1JjomZCjd5eUXz8R5Vl46uAlSbFAmxAfY1T-31qUB93eCL2iJfDc70OK2txohryntw9h-OePwQULJN0Eiwp" +
               "oI60HQFFlgC1g_crPIDakBTiEITrbO3OzrNeCQFBN-Ji4BTXq97TulCIRNneDLCUBSRE1A");
    var response = clientEP->get("/passthrough", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else if (response is error) {
        test:assertFail(msg = "Test Failed! " + <string>response.message());
    }
}
