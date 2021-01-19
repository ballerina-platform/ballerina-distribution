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

http:Client clientEndpoint = new("https://localhost:20100", {
    secureSocket: {
        trustStore: {
            path: TRUSTSTORE_PATH,
            password: "ballerina"
        }
    }
});

@test:Config {}
public function testAuthSuccessWithExample1Issuer() {
    // JWT used in the test:
    // {
    //   "sub": "ballerina",
    //   "iss": "example1",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "hello"
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3MiOi" +
                "JleGFtcGxlMSIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjhjYTIzM" +
                "2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEiLCJiYWxsZXJpbmEub3JnIiwiYmFsbGVyaW5hLmlvIl0sInNjb3BlIjoiaGVs" +
                "bG8ifQ.W_lvdp_o3o7MBVWeumg2fvIVSFWoGl9OFv2qyAz_g2afJwUWrFYOUd-1rj9lebZrQzqTd6RRX65MVF3GksSeIT9McZxj" +
                "PiSX1FR-nIUTcJ9anaoQVEKo3OpkIPzd_4_95CpHXF1MaW18ww5h_NShQnUrN7myrBfc-UbHsqC1YEBAM2M-3NMs8jjgcZHfZ1J" +
                "jomZCjd5eUXz8R5Vl46uAlSbFAmxAfY1T-31qUB93eCL2iJfDc70OK2txohryntw9h-OePwQULJN0EiwpoI60HQFFlgC1g_crPI" +
                "DakBTiEITrbO3OzrNeCQFBN-Ji4BTXq97TulCIRNneDLCUBSRE1A");
    var response = clientEndpoint->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testAuthSuccessWithExample2Issuer() {
    // JWT used in the test:
    // {
    //   "sub": "ballerina",
    //   "iss": "example2",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "hello"
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3MiO" +
               "iJleGFtcGxlMiIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjhjYTI" +
               "zM2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEiLCJiYWxsZXJpbmEub3JnIiwiYmFsbGVyaW5hLmlvIl0sInNjb3BlIjoia" +
               "GVsbG8ifQ.AUZp6qiMxPDrlITjyz-WoeDA6VxgV8pwwyQPkuw079BpNMeqIR4LsXUz1YZcFdNeZBfcj25cW7giIvMDRYNZtzEz" +
               "m8qovBmVzzd7vDdgvpvRuNhmFmcv63Jc9KjyoBiA_BDjFy9oTTzP35-PRuekQ0xy3gGjcgqhPcQtmLOyeTUbMhcrpGLB-fYp4x" +
               "9OqRo5ZNtMrm0aOuMj-VbKACc2vBdju5gu_nEtxBGeFWVHd_9l7OqNUTibmFzEV34GXP8rvVl73JZnp5tJesH-GXArsCjvSj1Q" +
               "pvcLBUiAaXFeXPb9t4iHFugJzHY68eQQZcxyIxWVyj2eNV4HmBjvqVLQuA");
    var response = clientEndpoint->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testAuthFailWithExample3Issuer() {
    // JWT used in the test:
    // {
    //   "sub": "ballerina",
    //   "iss": "example3",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "hello"
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3Mi" +
               "OiJleGFtcGxlMyIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjhjY" +
               "TIzM2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEiLCJiYWxsZXJpbmEub3JnIiwiYmFsbGVyaW5hLmlvIl0sInNjb3BlIj" +
               "oiaGVsbG8ifQ.fhWGGF02Sxsk1LAD3bDOOQj2Q7hcfOBE65YSzuX0URf7fNAZfWvzJSzWMdw4_kGAOb8kzZ8LByipzPMmuoAh" +
               "yph3T7JzHGEXGCEXDmACywj58pnVKISsSb5tR8pDaidh-XRrCwE2hXB4X2_3fi9-Mn2U3ZFVb2q8-W9V9bmI1KJK-ALdKFuYu" +
               "Z9BzIq3YfZNyqAyFaQo9TFYhqNRvDbBsfdmjAfcj_SlYfSmbmTMG2FCahr9Tq_S3pMbh3S_6ii1-OqTGUukFdz1c08F5SvIZ9" +
               "t1xdW40dCnDrSR6urqVGys0Zg_Ru0mnPg4dU2JPuwDLuKzj4KzWXShZ2Il5Ol-IA");
    var response = clientEndpoint->get("/echo/test", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}

@test:Config {}
public function testAuthFailWithExample1IssuerAndInvalidAudience() {
    // JWT used in the test:
    // {
    //   "sub": "ballerina",
    //   "iss": "example3",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "hello"
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3Mi" +
               "OiJleGFtcGxlMSIsImV4cCI6MjgxODQxNTAxOSwiaWF0IjoxNTI0NTc1MDE5LCJqdGkiOiJmNWFkZWQ1MDU4NWM0NmYyYjhjY" +
               "TIzM2QwYzJhM2M5ZCIsImF1ZCI6WyJiYWxsZXJpbmEtaW52YWxpZCJdLCJzY29wZSI6ImhlbGxvIn0.MTNqknOdp0ih1NhU7g" +
               "C8gAVWLhdKHpz--qlarhZxzOApUhPaNt5_EdLBddJmB0fn9SYFEhG5GVqmaKnn8QqZJQmeS3M1XuUQVV2Dmm6bIq_p9NySIlk" +
               "BAF35RJVepnoCq5ctdrgzcpYI3B8MSa07Sn00oEpSelzRK3SHPEglzGzOaG2GDWN2N2-TGF2IVSH1Bn3ovjFXsirh_uJZ9kbn" +
               "QhqrnZ2NIIjKaRa8y9RKtvwq3XnEvej2Ki7ddnx5AGSPXkiJ5AZBNtA5sRwEvJiffsff9tmJvI909Atf66WVylaFyP4e6E_Us" +
               "roxJPVxncPTRuewApF-RpXPKdheVEqQ4w");
    var response = clientEndpoint->get("/echo/test", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<http:ClientError>response).message());
    }
}
