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
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.MAVEN_VERSION;

/**
 * Tests related to artifact generation.
 */
public class OpenAPIArtifactBuildTest {

    @DataProvider(name = "distribution-provider")
    public Object[][] distributionNameProvider() {
        return new Object[][]{
                {"ballerina-" + MAVEN_VERSION}
        };
    }

    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        for (Object[] dist : distributionNameProvider()) {
            String distName = (String) dist[0];
            TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(distName + ".zip"));
        }
    }

    @Test(dataProvider = "distribution-provider", description = "check openapi to ballerina generator command")
    public void buildOpenAPIToBallerinaTest(String distributionFileName) throws IOException, InterruptedException {
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

    @Test(dataProvider = "distribution-provider", description = "check openapi to ballerina generator command with " +
            "service file only.")
    public void buildOpenAPIToBallerinaServiceFileGenerationTest(String distributionFileName) throws IOException,
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

    @Test(dataProvider = "distribution-provider", description = "check ballerina to openapi generator command")
    public void buildBallerinaToOpenAPITest(String distributionFileName) throws IOException, InterruptedException {
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

    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
