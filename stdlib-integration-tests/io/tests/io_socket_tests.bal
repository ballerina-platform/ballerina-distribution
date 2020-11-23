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

import ballerina/io;
import ballerina/test;
import ballerina/socket;
import ballerina/log;
import ballerina/lang.'string as langstring;

@test:Config {}
public function testSocketChannelReadBytes() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "Hello Ballerina World!!!!";
    socketWrite(socketClient, payload);

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadBytes(byteChannel);
                if (content is byte[]) {
                    test:assertEquals(content, payload.toBytes());
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadBytes"]}
public function testSocketChannelReadBytesAsStream() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "Hello Ballerina World Again!!!!";
    socketWrite(socketClient, payload);
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadBlocksAsStream(byteChannel, 1);
                if (content is stream<io:Block>) {
                    _ = content.forEach(function(io:Block val) {
                                           foreach byte b in val {
                                               byteArr.push(b);
                                           }
                                       });
                    string|error returnedString = langstring:fromBytes(byteArr);
                    if (returnedString is string) {
                        log:printInfo(returnedString);
                        log:printInfo(payload);
                        test:assertEquals(returnedString, payload);
                    } else {
                        test:assertFail(msg = returnedString.message());
                    }
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadBytesAsStream"]}
public function testSocketChannelReadString() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "Hello Ballerina World Again!!!!";
    socketWrite(socketClient, payload);
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadString(byteChannel);
                if (content is string) {
                    test:assertEquals(content, payload);
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadString"]}
public function testSocketChannelReadLines() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "F.R.I.E.N.D.S \n The Big Bang Theory \n LOST";
    string[] expected = ["F.R.I.E.N.D.S", "The Big Bang Theory", "LOST"];
    socketWrite(socketClient, payload);
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadLines(byteChannel);
                if (content is string[]) {
                    int i = 0;
                    foreach string s in content {
                        test:assertEquals(langstring:trim(s), expected[i]);
                        i += 1;
                    }
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadLines"]}
public function testSocketChannelReadLinesAsStream() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "F.R.I.E.N.D.S \n The Big Bang Theory \n LOST";
    string[] expected = ["F.R.I.E.N.D.S", "The Big Bang Theory", "LOST"];
    socketWrite(socketClient, payload);
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadLinesAsStream(byteChannel);
                if (content is stream<string>) {
                    int i = 0;
                    _ = content.forEach(function(string s) {
                                           test:assertEquals(langstring:trim(s), expected[i]);
                                           i += 1;
                                       });
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadLinesAsStream"]}
public function testSocketChannelReadJson() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    json payload = {"name": "Sheldon Cooper", "occupation": "Physicist", "age": 32};
    socketWrite(socketClient, payload.toString());
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadJson(byteChannel);
                if (content is json) {
                    test:assertEquals(content, payload);
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadJson"]}
public function testSocketChannelReadXml() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });

    xml payload = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                   </CATALOG>`;
    socketWrite(socketClient, payload.toString());
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadXml(byteChannel);
                if (content is xml) {
                    test:assertEquals(content, payload);
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadXml"]}
public function testSocketChannelReadCsv() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "Anne Hamiltom, Software Engineer, Microsoft, 26 years, New York \n " +
    "John Thomson, Software Architect, WSO2, 38 years, Colombo \n " +
    "Mary Thompson, Banker, ABC Bank, 30 years, Colombo";

    string[][] expectedContent = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], [
    "John Thomson", "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "ABC Bank",
    "30 years", "Colombo"]];
    socketWrite(socketClient, payload);
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadCsv(byteChannel);
                if (content is string[][]) {
                    int i = 0;
                    foreach string[] rec in content {
                        test:assertEquals(langstring:trim(rec[0]), expectedContent[i][0]);
                        test:assertEquals(langstring:trim(rec[1]), expectedContent[i][1]);
                        test:assertEquals(langstring:trim(rec[2]), expectedContent[i][2]);
                        test:assertEquals(langstring:trim(rec[3]), expectedContent[i][3]);
                        test:assertEquals(langstring:trim(rec[4]), expectedContent[i][4]);
                        i += 1;
                    }
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

@test:Config {dependsOn: ["testSocketChannelReadCsv"]}
public function testSocketChannelReadCsvAsStream() {
    socket:Client socketClient = new ({
        host: "localhost",
        port: 61599
    });
    string payload = "Anne Hamiltom, Software Engineer, Microsoft, 26 years, New York \n " +
    "John Thomson, Software Architect, WSO2, 38 years, Colombo \n " +
    "Mary Thompson, Banker, ABC Bank, 30 years, Colombo";

    string[][] expectedContent = [["Anne Hamiltom", "Software Engineer", "Microsoft", "26 years", "New York"], [
    "John Thomson", "Software Architect", "WSO2", "38 years", "Colombo"], ["Mary Thompson", "Banker", "ABC Bank",
    "30 years", "Colombo"]];
    socketWrite(socketClient, payload);
    byte[] byteArr = [];

    var result = socketClient->read();
    if (result is [byte[], int]) {
        var [reply, length] = result;
        if (length > 0) {
            var byteChannel = io:createReadableChannel(reply);
            if (byteChannel is io:ReadableByteChannel) {
                var content = io:channelReadCsvAsStream(byteChannel);
                if (content is stream<string[]>) {
                    int i = 0;
                    _ = content.forEach(function(string[] rec) {
                                           test:assertEquals(langstring:trim(rec[0]), expectedContent[i][0]);
                                           test:assertEquals(langstring:trim(rec[1]), expectedContent[i][1]);
                                           test:assertEquals(langstring:trim(rec[2]), expectedContent[i][2]);
                                           test:assertEquals(langstring:trim(rec[3]), expectedContent[i][3]);
                                           test:assertEquals(langstring:trim(rec[4]), expectedContent[i][4]);
                                           i += 1;
                                       });
                } else {
                    test:assertFail(msg = content.message());
                }
            } else {
                test:assertFail(msg = byteChannel.message());
            }
        }
    } else {
        test:assertFail(msg = result.message());
    }

    var closeResult = socketClient->close();
    if (closeResult is error) {
        test:assertFail(msg = closeResult.message());
    }
}

function socketWrite(socket:Client socketClient, string payload) {
    byte[] payloadByte = payload.toBytes();

    int i = 0;
    int arrayLength = payloadByte.length();
    while (i < arrayLength) {
        var writeResult = socketClient->write(payloadByte);
        if !(writeResult is error) {
            i = i + writeResult;
            payloadByte = payloadByte.slice(writeResult, arrayLength);
        } else {
            log:printError("Unable to write the content to socket: " + payload, writeResult);
        }
    }
}
