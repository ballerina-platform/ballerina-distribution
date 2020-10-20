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
public function testScopeClaim() {
    http:Client clientEP = new("https://localhost:20101", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });

    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina",
    //   "exp": 1910855013,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "test-scope"
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2lkIjoiTlRBeFptTXhORE15WkRnM01U" +
                "VTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpGaU1RIn0.eyJzdWIiOiJiYWxsZXJpbmEiLCAiaXNzIjoiYmFsbGVyaW" +
                "5hIiwgImV4cCI6MTkxMDgzODU0MSwgImp0aSI6ImY1YWRlZDUwNTg1YzQ2ZjJiOGNhMjMzZDBjMmEzYzlkIiwgImF1ZCI6WyJi" +
                "YWxsZXJpbmEiLCAiYmFsbGVyaW5hLm9yZyIsICJiYWxsZXJpbmEuaW8iXSwgInNjb3BlIjoidGVzdC1zY29wZSJ9.XggMwJZ22" +
                "-N9geU-NAJAUrvhdhF2qyKM9grS6On_8dJV1wkHAP6wvFZ6GfFIf4rrrhYHV4aQns5FrlU043iBS-EQOVhgHPcN3Rfcx02zw1Q" +
                "7-kem63PSIf_D5jlFlRc4noIT5AsK4D5oFSNDIoEeUHxwQyJBjojlTnF8fH8DZD7xEJvFRRGabHB20DVR5NgWzdu6h--dVNd1k" +
                "HrsKQ6v1WGA-GIt2r9TGHFt3vq8KYTUH7eU3ZGyoyvgKoFepMOYg0RsxNqJPINZH5c-RX-Bdf7B2bEsbZA2mhNXkDP1QQEtcso" +
                "pYdoCyY76k14gctA8Nf4R0R9JMwDlm0E_7Nj9tA");
    var response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testScpClaim() {
    http:Client clientEP = new("https://localhost:20101", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });

    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina",
    //   "exp": 1910855013,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scp": ["test-scp"]
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2lkIjoiTlRBeFptTXhORE15WkRnM01U" +
                "VTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpGaU1RIn0.eyJzdWIiOiJiYWxsZXJpbmEiLCAiaXNzIjoiYmFsbGVyaW" +
                "5hIiwgImV4cCI6MTkxMDg1NjY0MCwgImp0aSI6ImY1YWRlZDUwNTg1YzQ2ZjJiOGNhMjMzZDBjMmEzYzlkIiwgImF1ZCI6WyJi" +
                "YWxsZXJpbmEiLCAiYmFsbGVyaW5hLm9yZyIsICJiYWxsZXJpbmEuaW8iXSwgInNjcCI6WyJ0ZXN0LXNjcCJdfQ.WVFSmImmUT4" +
                "fUPV3RMzEF3n7ZLmjoFCCUip2u3kFyvfbK60c1zNfy-OXlIVIRR56xCDa3ZHgHuEGRL_giBVpSCn0NYZdJdDia7EQV6n8rW6pt" +
                "PHsUbftmDMYictz0qXGnQYRT9IxAoSBYCSKv5aRJpYbIF6Uk1saIUl6gQ4CiHstFFDDW3cR_BUcJsZcC05OtZteKMGp_LEwLKa" +
                "z_vgyQZbbBlInSfww2ZOhLk9ijZFkP6KygU9JRpk8LnSwhACW-aIBhGMRxHdZc8C_-wRqiuTggPSkoJmpctq4650PYJJh9KTKf" +
                "YJRbbwSDq0g7eubb2y09Iy9Q7ZehIbhwTokmQ");
    var response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testScopeAndScpClaim() {
    http:Client clientEP = new("https://localhost:20101", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });

    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina",
    //   "exp": 1910855013,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "test-scope",
    //   "scp": ["test-scp"]
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2lkIjoiTlRBeFptTXhORE15WkRnM01U" +
                "VTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpGaU1RIn0.eyJzdWIiOiJiYWxsZXJpbmEiLCAiaXNzIjoiYmFsbGVyaW" +
                "5hIiwgImV4cCI6MTkxMDg1NjYyMSwgImp0aSI6ImY1YWRlZDUwNTg1YzQ2ZjJiOGNhMjMzZDBjMmEzYzlkIiwgImF1ZCI6WyJi" +
                "YWxsZXJpbmEiLCAiYmFsbGVyaW5hLm9yZyIsICJiYWxsZXJpbmEuaW8iXSwgInNjb3BlIjoidGVzdC1zY29wZSIsICJzY3AiOl" +
                "sidGVzdC1zY3AiXX0.GkNICuMBZVhzb-bXu6ti8XbF57N_RRZDZYpb1gX-SFvpGuITQZDw7Xdn-g2EPIon_DJ4o0K75LKrPQq6" +
                "0R1Ms4eLZxIto3D9R2yCortUncCy5r7oZPVq2Z9QQyIwgErLX96pOsYqPqZRO9jRHl9V98YKALUgrq8loZER7sz08MwXKq1Jj7" +
                "4PnceTGYTrB2LEt3AoUNpis0OIriXsx7_dRrI5eotcQ5cCdZJtLUvu4DtgC4S550j33QBbb04ACvWpFhhXA5gPe7pbc20M1yIh" +
                "5LAlLLRvAXkPwiyk4GXAl9mWixSdmG0TldEeGQBKW-fPpC87-PMqV5lXGAds8DvO_g");
    var response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testNoCustomClaim() {
    http:Client clientEP = new("https://localhost:20101", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });

    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina",
    //   "exp": 1910855013,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ]
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJKV1QiLCAia2lkIjoiTlRBeFptTXhORE15WkRnM01U" +
                "VTFaR00wTXpFek9ESmhaV0k0TkRObFpEVTFPR0ZrTmpGaU1RIn0.eyJzdWIiOiJiYWxsZXJpbmEiLCAiaXNzIjoiYmFsbGVyaW" +
                "5hIiwgImV4cCI6MTkxMDg1NTEwNSwgImp0aSI6ImY1YWRlZDUwNTg1YzQ2ZjJiOGNhMjMzZDBjMmEzYzlkIiwgImF1ZCI6WyJi" +
                "YWxsZXJpbmEiLCAiYmFsbGVyaW5hLm9yZyIsICJiYWxsZXJpbmEuaW8iXX0.DRrfOk1iODee7Ek433UW1aPgrJL905-IdfqdjE" +
                "qJk1x6J_skvxRNYSuQDJmiORrUmQjpirQaIx6wJKc70JHig1xKlgdwGZnfCQHbrYgdybp3nrFmk7dTurxybGui0i9lbmeSE2JV" +
                "RUFjuEBgPyd0khF9tIcbyZFStV8fEl9bGZeRntT6L3IRVmjxt_zP_fLr8zdj9r035VwWgq-D6-W9Go9j465cxVb_waFI4AsxNP" +
                "oQ_v__xIFUV5T5mq_tVpNCPFl8k1VInuMXaCY-XKmImY8HHFKFW2QwfauWpZp4gl4ope6NFqBG3u8Gm6FEysF33ChB37xPfkcH" +
                "omoBL6vziw");
    var response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}

@test:Config {}
public function testAuthzCache() {
    http:Client clientEP = new("https://localhost:20101", {
        secureSocket: {
            trustStore: {
                path: TRUSTSTORE_PATH,
                password: "ballerina"
            }
        }
    });

    // JWT used in the initial request:
    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "test-scope"
    // }
    http:Request req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3MiO" +
               "iJiYWxsZXJpbmEiLCJleHAiOjI4MTg0MTUwMTksImlhdCI6MTUyNDU3NTAxOSwianRpIjoiZjVhZGVkNTA1ODVjNDZmMmI4Y2E" +
               "yMzNkMGMyYTNjOWQiLCJhdWQiOlsiYmFsbGVyaW5hIiwiYmFsbGVyaW5hLm9yZyIsImJhbGxlcmluYS5pbyJdLCJzY29wZSI6I" +
               "nRlc3Qtc2NvcGUifQ.UHGtfDbR4BS7qyDn2V0R5bzGH7SjLeI0MyhcTA3eyUQRG5wfajH51T0lrTV2jfD0-_92Pn1D4RDKFTIa" +
               "l2aawDBFag_4GJhRd__AxjZemCqAdKs-cqX-JNSWnB8m7cBfA9LOH-y2dmowNqv4VeMuuxKriMe9w-7YpnRPJrs-HIxLMgOdJa" +
               "YsFHEPL1wWDvlpt53wDjCveYw4OgD39S5g-pcemGUflVUMoKB3nti1qjzcIb6nDKdqQiAbnSN2UKEVLXQpZX5WUKe5SuFlKnS9" +
               "z1BbKC2z79eMe15yx8asas3krgJyKVNISUWlgPWvKHxyfh_RoQYgWPn-rhng1_P8Ag");
    var response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertOK(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }

    // JWT used in the second request:
    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "invalid-scope"
    // }
    req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3Mi" +
               "OiJiYWxsZXJpbmEiLCJleHAiOjI4MTg0MTUwMTksImlhdCI6MTUyNDU3NTAxOSwianRpIjoiZjVhZGVkNTA1ODVjNDZmMmI4Y" +
               "2EyMzNkMGMyYTNjOWQiLCJhdWQiOlsiYmFsbGVyaW5hIiwiYmFsbGVyaW5hLm9yZyIsImJhbGxlcmluYS5pbyJdLCJzY29wZS" +
               "I6ImludmFsaWQtc2NvcGUifQ.U6qlFXduTPCkMVbPmhRaqWpKQ3UGf0TXW6ErmrRycW-Jy025nB5Akp9uH7e02TIfSXbSDtSH" +
               "XichRv_y7_VuY-WTm7QBtR5tqpBVAI59SezTE9NqxCIy-ol4RE7rQ7plOr2y80NNQfoWE6PCwsjFNc2v_FdXzR6ADvsnNZbRu" +
               "Z2nhnTpkDkdmgDOyonw4YZPG275ZQCRTJEjyUKnF4yEm9c2cwCtbOVzdThtzuJEmEcrRHAre7zZX857R2ZKo84TZ8Tes3maGY" +
               "dpwoUnOy9aseNB8iy0AAPQwf1MkpbgCUJFGLAWHAQsUBJXPpCPGMKVJ5CYzFiPC_bX_pUrzrXOJw");
    response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertForbidden(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }

    // JWT used in the third request:
    // {
    //   "sub": "ballerina",
    //   "iss": "ballerina1",
    //   "exp": 2818415019,
    //   "iat": 1524575019,
    //   "jti": "f5aded50585c46f2b8ca233d0c2a3c9d",
    //   "aud": [
    //     "ballerina",
    //     "ballerina.org",
    //     "ballerina.io"
    //   ],
    //   "scope": "test-scope"
    // }
    req = new;
    req.setHeader("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYWxsZXJpbmEiLCJpc3MiO" +
               "iJiYWxsZXJpbmExIiwiZXhwIjoyODE4NDE1MDE5LCJpYXQiOjE1MjQ1NzUwMTksImp0aSI6ImY1YWRlZDUwNTg1YzQ2ZjJiOGN" +
               "hMjMzZDBjMmEzYzlkIiwiYXVkIjpbImJhbGxlcmluYSIsImJhbGxlcmluYS5vcmciLCJiYWxsZXJpbmEuaW8iXSwic2NvcGUiO" +
               "iJ0ZXN0LXNjb3BlIn0.YNgu3A0o1S2sDIsJMv3NlV6bD0iGIerglEAxCpAHwq8oDHJ8_AjBfaU75x_lJZIKftp2FLJM99UT1IS" +
               "eO9Kt3EIJHU4njheptz7Qfep_sEyYdq3CvQI5bKxUZw4bA-87AxTv_tFpSAbiBpGhD0rmhYAfkXF7QsWplDts_xFRhMmxHEsel" +
               "RKMg4F9-iX3HQYouJoRzyDJTETyzxC2vFE0FaCxVDrrs5B2KU3YB-etkPUWDFgzaoV13SaHxPBhj-f5arlfRaDk2XtbNnchHgs" +
               "LbLux8FaxyAglgRoDNgBgaCynbhUYAUnpr2JSx72FN8J0CJB5f31EMmmd4FukTtv-8w");
    response = clientEP->get("/echo/test", req);
    if (response is http:Response) {
        assertUnauthorized(response);
    } else {
        test:assertFail(msg = "Test Failed! " + (<error>response).message());
    }
}
