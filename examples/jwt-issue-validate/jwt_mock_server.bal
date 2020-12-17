// This is a mock JWK server, which is to expose the JWK components for testing purpose.
import ballerina/config;
import ballerina/http;

listener http:Listener oauth2Server = new (20000, {
        secureSocket: {
            keyStore: {
                path: config:getAsString("b7a.home") +
                    "/bre/security/ballerinaKeystore.p12",
                password: "ballerina"
            }
        }
    });

service /oauth2 on oauth2Server {

    resource function get jwks(http:Caller caller, http:Request req) {
        http:Response res = new;
        json jwks = {
            "keys": [
                    {
                        "kty": "RSA",
                        "e": "AQAB",
                        "use": "sig",
                        "kid": "NTAxZmMxNDMyZDg3MTU1ZGM0MzEzODJhZWI4NDNlZDU1" +
                            "OGFkNjFiMQ",
                        "alg": "RS256",
                        "n": "AIFcoun1YlS4mShJ8OfcczYtZXGIes_XWZ7oPhfYCqhSIJ" +
                            "nXD3vqrUu4GXNY2E41jAm8dd7BS5GajR3g1GnaZrSqN0w3b" +
                            "jpdbKjOnM98l2-i9-JP5XoedJsyDzZmml8Xd7zkKCuDqZID" +
                            "tZ99poevrZKd7Gx5n2Kg0K5FStbZmDbTyX30gi0_griIZyV" +
                            "CXKOzdLp2sfskmTeu_wF_vrCaagIQCGSc60Yurnjd0RQiMW" +
                            "A10jL8axJjnZ-IDgtKNQK_buQafTedrKqhmzdceozSot231" +
                            "I9dth7uXvmPSjpn23IYUIpdj_NXCIt9FSoMg5-Q3lhLg6GK" +
                            "3nZOPuqgGa8TMPs="
                    }
                ]
        };
        res.setJsonPayload(jwks);
        checkpanic caller->respond(res);
    }
}
