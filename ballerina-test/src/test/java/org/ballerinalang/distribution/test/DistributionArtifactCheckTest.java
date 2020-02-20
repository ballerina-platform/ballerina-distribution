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

import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.MAVEN_VERSION;
import static org.ballerinalang.distribution.utils.TestUtils.TEST_DISTRIBUTION_PATH;

/**
 * Check if necessary files exists to build in distribution.
 */
public class DistributionArtifactCheckTest {
    
    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        String distName = "jballerina-" + MAVEN_VERSION;
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(distName + ".zip"));
    }
    
    @Test
    public void dockerAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("0.0.0")
                .resolve("docker.bir");
    
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("docker.jar");
        
        Path pluginPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("docker-extension-" + MAVEN_VERSION + ".jar");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(jarPath));
        Assert.assertTrue(Files.exists(pluginPath));
    }
    
    @Test
    public void kubernetesAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("0.0.0")
                .resolve("kubernetes.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("kubernetes.jar");
        
        Path pluginPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("kubernetes-extension-" + MAVEN_VERSION + ".jar");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(jarPath));
        Assert.assertTrue(Files.exists(pluginPath));
    }
    
    @Test
    public void istioAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("0.0.0")
                .resolve("istio.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("istio.jar");
        
        Path pluginPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("kubernetes-extension-" + MAVEN_VERSION + ".jar");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(jarPath));
        Assert.assertTrue(Files.exists(pluginPath));
    }
    
    @Test
    public void openshiftAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("0.0.0")
                .resolve("openshift.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("openshift.jar");
        
        Path pluginPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("kubernetes-extension-" + MAVEN_VERSION + ".jar");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(jarPath));
        Assert.assertTrue(Files.exists(pluginPath));
    }
    
    @Test
    public void knativeAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("0.0.0")
                .resolve("knative.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("knative.jar");
        
        Path pluginPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("kubernetes-extension-" + MAVEN_VERSION + ".jar");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(jarPath));
        Assert.assertTrue(Files.exists(pluginPath));
    }
    
    @Test
    public void awsLambdaAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerinax")
                .resolve("awslambda")
                .resolve("0.0.0")
                .resolve("awslambda.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve("bir-cache")
                .resolve("ballerinax")
                .resolve("awslambda")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
        
        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("awslambda.jar");
        
        Path pluginPath = TEST_DISTRIBUTION_PATH
                .resolve("bre")
                .resolve("lib")
                .resolve("awslambda-extension-" + MAVEN_VERSION + ".jar");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(jarPath));
        Assert.assertTrue(Files.exists(pluginPath));
    }
    
    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
