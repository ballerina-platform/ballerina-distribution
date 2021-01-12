//// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
////
//// WSO2 Inc. licenses this file to you under the Apache License,
//// Version 2.0 (the "License"); you may not use this file except
//// in compliance with the License.
//// You may obtain a copy of the License at
////
//// http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing,
//// software distributed under the License is distributed on an
//// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//// KIND, either express or implied.  See the License for the
//// specific language governing permissions and limitations
//// under the License.
//
//import ballerina/auth;
//import ballerina/io;
//import ballerina/http;
//
//listener Listener persistenceWebsubEP = new Listener(23383);
//
//auth:OutboundBasicAuthProvider persistenceBasicAuthProvider = new({
//    username: "tom",
//    password: "1234"
//});
//
//http:BasicAuthHandler persistenceBasicAuthHandler = new(persistenceBasicAuthProvider);
//
//@SubscriberServiceConfig {
//    path: "/websub",
//    target: "http://localhost:23080/publisher/discover",
//    leaseSeconds: 3600,
//    secret: "Kslk30SNF2AChs2",
//    hubClientConfig: {
//        auth: { authHandler: persistenceBasicAuthHandler }
//    }
//}
//service persistenceWebsubSubscriber on persistenceWebsubEP {
//    resource function onNotification (Notification notification) returns @tainted error? {
//        json payload = check notification.getJsonPayload();
//        io:println("WebSub Notification Received by One: " + payload.toJsonString());
//    }
//}
//
//@SubscriberServiceConfig {
//    path: "/websubTwo",
//    subscribeOnStartUp: true,
//    target: "http://localhost:23080/publisherTwo/discover",
//    leaseSeconds: 1200,
//    hubClientConfig: {
//        auth: { authHandler: persistenceBasicAuthHandler }
//    }
//}
//service persistenceWebsubSubscriberTwo on persistenceWebsubEP {
//    resource function onNotification (Notification notification) returns @tainted error? {
//        json payload = check notification.getJsonPayload();
//        io:println("WebSub Notification Received by Two: " + payload.toJsonString());
//    }
//}
