// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/io;
import ballerina/tcp;

listener http:Listener echoEP = new(58291);

service /echo on echoEP {
    
    resource function post .(http:Caller caller, http:Request req) {
        tcp:Client socketClient = new({ host: "localhost", port: 59152, callbackService: ClientService });
        var payload = req.getTextPayload();
        http:Response resp = new;
        if (payload is string) {
            byte[] payloadByte = payload.toBytes();
            var writeResult = socketClient->write(payloadByte);
            if (writeResult is int) {
                io:println("Number of bytes written: ", writeResult);
                checkpanic caller->accepted();
            } else {
                io:println("Write error!!!");
                resp.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                resp.setPayload(<@untainted> writeResult.message());
                var responseError = caller->respond(resp);
                if (responseError is error) {
                    io:println("Error sending response: ", responseError.message());
                }
            }
        } else {
            resp.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            resp.setPayload(<@untainted> payload.message());
            var responseError = caller->respond(resp);
            if (responseError is error) {
                io:println("Error sending response: ", responseError.message());
            }
        }
    }
}

service object {} ClientService = service object {

    remote function onConnect(tcp:Caller caller) {
        io:println("connect: ", caller.remotePort);
    }

    remote function onReadReady(tcp:Caller caller) {
        io:println("New content received for callback");
        var result = caller->read();
        if (result is [byte[], int]) {
            var [content, length] = result;
            if (length > 0) {
                var str = <@untainted> getString(content, 15);
                if (str is string) {
                    io:println(<@untainted>str);
                } else {
                    io:println(str.message());
                }
                var closeResult = caller->close();
                if (closeResult is error) {
                    io:println(closeResult.message());
                } else {
                    io:println("Client connection closed successfully.");
                }
            } else {
                io:println("Client close: ", caller.remotePort);
            }
        } else {
            io:println(<error> result);
        }
    }

    remote function onError(tcp:Caller caller, error er) {
        io:println(er.message());
    }
};
