/*
 * Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.ballerinalang.distribution.test;

import org.ballerinalang.distribution.utils.TestUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.RESOURCES_PATH;
import static org.ballerinalang.distribution.utils.TestUtils.WHITESPACE_PATTERN;
import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerinalang.distribution.utils.TestUtils.getStringFromGivenBalFile;

public class GrpcToolingTest {

    private String helpCommandOutput = "NAMEballerina-grpc-GenerateBallerinasourcesforthegivenProtocolBufferdefinitionSYNOPSISbalgrpc--input<proto-file-path>[--output<path>][--modemode][--proto-path<path>]DESCRIPTIONGeneratetheBallerinagRPCclient/servicesourcesforagivengRPCprotocolbuffer(Protobuf)definition.OPTIONS--input<path>Pathtoa'.proto'fileoradirectorycontainingmultiple'.proto'files.--output<path>LocationofthegeneratedBallerinasourcefiles.Iftheoutputpathisnotspecified,theoutputwillbewrittentoadirectorycorrespondingtothepackageintheprotocolbufferdefinition.Ifapackageisnotspecified,theoutputwillbewrittentoa'temp'directoryinthecurrentlocation.--modemodeSetthe'client'or'service'modetogeneratesamplecode.Ifnotspecified,onlythestubfileisgenerated.--proto-path<path>Pathtoadirectoryinwhichtolookfor'.proto'fileswhenresolvingimportdirectives.EXAMPLESGeneratetheBallerinagRPCstubfile(forthegiven'.proto'file)ina'stub'directory.$balgrpc--inputchat.proto--outputstubGeneratetheBallerinagRPCstubfileandclientsamplecode(forthegiven'.proto'file)ina'client'directory.$balgrpc--inputchat.proto--outputclient--modeclientGeneratetheBallerinagRPCstubfileandservicesamplecode(forthegiven'.proto'file)ina'service'directory.$balgrpc--inputchat.proto--outputservice--modeservice";

    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DISTRIBUTION_FILE_NAME + ".zip"));
    }

    @Test
    public void grpcCommandWithoutInputOptionTest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/grpc");
        List<String> buildArgs = new LinkedList<>();
        InputStream result = TestUtils.executeGrpcCommand(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs, true);
        String expectedMsg = "ballerina:missingrequiredoption'--input=<protoPath>'Run'balhelp'forusage.";
        Assert.assertEquals(readOutputFromStreamAsString(result), expectedMsg);
    }

    @Test
    public void grpcCommandWithoutInputValueTest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/grpc");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("--input");
        InputStream result = TestUtils.executeGrpcCommand(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs, true);
        String expectedMsg = "ballerina:flag'--input'(<protoPath>)needsanargumentRun'balhelp'forusage.";
        Assert.assertEquals(readOutputFromStreamAsString(result), expectedMsg);
    }

    @Test
    public void grpcCommandWithValidInputTest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/grpc");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("--input");
        buildArgs.add("proto-files/route_guide.proto");
        buildArgs.add("--output");
        buildArgs.add(TestUtils.getResource(testResource).toString());
        InputStream result = TestUtils.executeGrpcCommand(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs, true);
        Assert.assertEquals(readOutputFromStreamAsString(result), "");
        String generatedTypes = getStringFromGivenBalFile(TestUtils.getResource(testResource)
                .resolve("route_guide_pb.bal"));
        String expectedTypes = getStringFromGivenBalFile(RESOURCES_PATH
                .resolve("grpc/expected-files/route_guide_pb.bal"));
        Assert.assertEquals(generatedTypes, expectedTypes);
    }

    @Test
    public void grpcHelpCommandTest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/grpc");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("--help");
        InputStream result = TestUtils.executeGrpcCommand(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs, false);
        Assert.assertEquals(readOutputFromStreamAsString(result), helpCommandOutput);
    }

    @Test
    public void grpcHCommandTest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/grpc");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-h");
        InputStream result = TestUtils.executeGrpcCommand(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs, false);
        Assert.assertEquals(readOutputFromStreamAsString(result), helpCommandOutput);
    }

    private String readOutputFromStreamAsString(InputStream result) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(result))) {
            Stream<String> logLines = br.lines();
            String generatedLog = logLines.collect(Collectors.joining("\n"));
            logLines.close();
            generatedLog = (generatedLog.trim()).replaceAll(WHITESPACE_PATTERN, "");
            return generatedLog;
        }
    }

    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
