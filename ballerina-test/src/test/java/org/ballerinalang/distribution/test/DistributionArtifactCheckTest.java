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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.MAVEN_VERSION;
import static org.ballerinalang.distribution.utils.TestUtils.TEST_DISTRIBUTION_PATH;

/**
 * Check if necessary files exists to build in the distribution.
 */
public class DistributionArtifactCheckTest {
    private static final String DIST_NAME = "jballerina-" + MAVEN_VERSION;
    
    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DIST_NAME + ".zip"));
    }
    
    @Test
    public void dockerAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("0.0.0")
                .resolve("docker.bir");
    
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina.docker.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "docker-extension-"));
    }
    
    @Test
    public void kubernetesAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("0.0.0")
                .resolve("kubernetes.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina.kubernetes.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test
    public void istioAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("0.0.0")
                .resolve("istio.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina.istio.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test
    public void openshiftAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("0.0.0")
                .resolve("openshift.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina.openshift.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test
    public void knativeAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("0.0.0")
                .resolve("knative.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina.knative.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test
    public void awsLambdaAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerinax")
                .resolve("awslambda")
                .resolve("0.0.0")
                .resolve("awslambda.bir");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "awslambda-extension-"));
    }
    
    @Test
    public void azureFunctionsAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerinax")
                .resolve("azure.functions")
                .resolve("0.0.0")
                .resolve("azure.functions.bir");
        
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "azurefunctions-extension-"));
    }
    
    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
