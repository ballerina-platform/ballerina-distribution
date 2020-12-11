/*
 * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.MAVEN_VERSION;
import static org.ballerinalang.distribution.utils.TestUtils.RESOURCES_PATH;

/**
 * OpenAPI Tests related to artifact generation.
 */
public class OpenAPIArtifactBuildTest {
    public static final String WHITESPACE_PATTERN = "\\s+";
    public static final String distributionFileName = "ballerina-" + MAVEN_VERSION;

    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(distributionFileName + ".zip"));
    }

    @Test( description = "Check openapi to ballerina generator command")
    public void buildOpenAPIToBallerinaTest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/openapi");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("petstore.yaml");
        boolean successful = TestUtils.executeOpenAPI(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("petstore-service.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("petstore-client.bal")));
        TestUtils.deleteGeneratedFiles("petstore");
    }

    @Test(description = "Check openapi to ballerina generator command with service file only.")
    public void buildOpenAPIToBallerinaServiceFileGenerationTest() throws IOException,
            InterruptedException {
        Path testResource = Paths.get("/openapi");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("petstore.yaml");
        buildArgs.add("--mode");
        buildArgs.add("service");
        boolean successful = TestUtils.executeOpenAPI(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("petstore-service.bal")));
        TestUtils.deleteGeneratedFiles("petstore");
    }

    @Test(description = "Check openapi to ballerina generator command for given tags")
    public void buildOpenAPIToBallerinaWithFilterTagsTest() throws IOException,
            InterruptedException {
        Path testResource = Paths.get("/openapi");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("petstoreTags.yaml");
        buildArgs.add("--tags");
        buildArgs.add("list");
        boolean successful = TestUtils.executeOpenAPI(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);

        Path expectedServiceFile = RESOURCES_PATH.resolve("openapi/expected/filteredTags.bal");
        Stream<String> expectedServiceLines = Files.lines(expectedServiceFile);
        String expectedService = expectedServiceLines.collect(Collectors.joining("\n"));

        if (Files.exists(RESOURCES_PATH.resolve("openapi/petstoretags-service.bal"))) {
            Path generatedServiceFile = TestUtils.getResource(testResource).resolve("petstoretags-service.bal");
            Stream<String> serviceLines = Files.lines(generatedServiceFile);
            String generatedService = serviceLines.collect(Collectors.joining("\n"));
            serviceLines.close();
            expectedService = replaceContractPath(expectedServiceLines, expectedService, generatedService);

            expectedService = (expectedService.trim()).replaceAll(WHITESPACE_PATTERN, "");
            generatedService = (generatedService.trim()).replaceAll(WHITESPACE_PATTERN, "");

            if (expectedService.equals(generatedService)) {
                Assert.assertTrue(true);
            } else {
                Assert.fail("Expected content and actual generated content is mismatched for: petstoreTags.yaml");
            }
            //Clean the generated files
            TestUtils.deleteGeneratedFiles("petstoretags");
        }
    }

    @Test(description = "Check ballerina to openapi generator command", enabled = false)
    public void buildBallerinaToOpenAPITest() throws IOException, InterruptedException {
        Path testResource = Paths.get("/openapi");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("petstore.bal");
        boolean successful = TestUtils.executeOpenAPI(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("hello-openapi.yaml")));
        TestUtils.deleteGeneratedFiles("hello-openapi.yaml");
    }

    //OpenAPI integration tests
    @Test(description = "Test for openapi validator off", enabled = false)
    public void buildOpenAPIValidatorOffTest() throws IOException, InterruptedException {

        Path testResource = Paths.get("/openapi/integration-tests/testFiles");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("openapi-validator-off.bal");
        InputStream outputs = TestUtils.executeOpenapiBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        String msg = "WARNING [openapi-validator-off.bal:(14:1,26:2)] Couldn't find a Ballerina service resource for the" +
                " path";
        try (BufferedReader br = new BufferedReader(new InputStreamReader(outputs))) {

            Stream<String> logLines = br.lines();
            String generatedLog = logLines.collect(Collectors.joining("\n"));
            logLines.close();

            generatedLog = (generatedLog.trim()).replaceAll(WHITESPACE_PATTERN, "");
            msg = (msg.trim()).replaceAll(WHITESPACE_PATTERN, "");
            if (generatedLog.contains(msg)) {
                Assert.assertTrue(true);
            } else {
                Assert.fail("OpenAPIValidator Off execution fail.");
            }
        }
    }

    @Test(description = "Tests for openapi validator on", enabled = false)
    public void buildOpenAPIValidatorONTest() throws IOException, InterruptedException {

        Path testResource = Paths.get("/openapi/integration-tests/testFiles");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("openapi-validator-on.bal");
        InputStream outputs = TestUtils.executeOpenapiBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        String msg = "ERROR [openapi-validator-on.bal:(13:9,25:10)] Couldn't find a Ballerina service resource for " +
                "the path";
        try (BufferedReader br = new BufferedReader(new InputStreamReader(outputs))) {

            Stream<String> logLines = br.lines();
            String generatedLog = logLines.collect(Collectors.joining("\n"));
            logLines.close();

            generatedLog = (generatedLog.trim()).replaceAll(WHITESPACE_PATTERN, "");
            msg = (msg.trim()).replaceAll(WHITESPACE_PATTERN, "");
            if (generatedLog.contains(msg)) {
                Assert.assertTrue(true);
            } else {
                Assert.fail("OpenAPIValidator On execution fail.");
            }
        }
    }
    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }

    //Replace contract file path in generated service file with common URL.
    public String replaceContractPath(Stream<String> expectedServiceLines, String expectedService,
                                      String generatedService) {
        Pattern pattern = Pattern.compile("\\bcontract\\b: \"(.*?)\"");
        Matcher matcher = pattern.matcher(generatedService);
        matcher.find();
        String contractPath = "contract: " + "\"" + matcher.group(1) + "\"";
        expectedService = expectedService.replaceAll("\\bcontract\\b: \"(.*?)\"",
                Matcher.quoteReplacement(contractPath));
        expectedServiceLines.close();
        return expectedService;
    }
}
