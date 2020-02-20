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

import org.apache.commons.io.FileUtils;
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
public class ArtifactBuildTest {
    
    @DataProvider(name = "distribution-provider")
    public Object[][] distributionNameProvider() {
        return new Object[][]{
                {"ballerina-" + MAVEN_VERSION},
                {"jballerina-" + MAVEN_VERSION},
                {"ballerina-linux-" + MAVEN_VERSION},
                {"ballerina-macos-" + MAVEN_VERSION}
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
    
    @Test(dataProvider = "distribution-provider")
    public void buildDockerTest(String distributionFileName) throws IOException, InterruptedException {
        Path testResource = Paths.get("/docker");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("hello_world_docker.bal");
        boolean successful = TestUtils.executeBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("docker")));
        Assert.assertTrue(successful);
        FileUtils.deleteDirectory(TestUtils.getResource(testResource).resolve("kubernetes").toFile());
    }
    
    
    @Test(dataProvider = "distribution-provider")
    public void buildKubernetesTest(String distributionFileName) throws IOException, InterruptedException {
        Path testResource = Paths.get("/kubernetes");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("hello_world_k8s.bal");
        boolean successful = TestUtils.executeBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("kubernetes")));
        Assert.assertTrue(successful);
        FileUtils.deleteDirectory(TestUtils.getResource(testResource).resolve("kubernetes").toFile());
    }
    
    @Test(dataProvider = "distribution-provider")
    public void buildIstioTest(String distributionFileName) throws IOException, InterruptedException {
        Path testResource = Paths.get("/istio");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("travel_agency_service.bal");
        boolean successful = TestUtils.executeBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("kubernetes")));
        Assert.assertTrue(successful);
        FileUtils.deleteDirectory(TestUtils.getResource(testResource).resolve("kubernetes").toFile());
    }
    
    @Test(dataProvider = "distribution-provider")
    public void buildOpenshiftTest(String distributionFileName) throws IOException, InterruptedException {
        Path testResource = Paths.get("/openshift");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("hello_world_oc.bal");
        boolean successful = TestUtils.executeBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("kubernetes").resolve("openshift")));
        Assert.assertTrue(successful);
        FileUtils.deleteDirectory(TestUtils.getResource(testResource).resolve("kubernetes").toFile());
    }
    
    @Test(dataProvider = "distribution-provider")
    public void buildKnativeTest(String distributionFileName) throws IOException, InterruptedException {
        Path testResource = Paths.get("/knative");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("hello_world_knative.bal");
        boolean successful = TestUtils.executeBuild(distributionFileName, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("kubernetes")));
        Assert.assertTrue(successful);
        FileUtils.deleteDirectory(TestUtils.getResource(testResource).resolve("kubernetes").toFile());
    }
    
    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
