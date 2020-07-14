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
import static org.ballerinalang.distribution.utils.TestUtils.SHORT_VERSION;
import static org.ballerinalang.distribution.utils.TestUtils.TEST_DISTRIBUTION_PATH;

/**
 * Check if necessary files exists to build in the distribution.
 */
public class DistributionArtifactCheckTest {
    private static final String DIST_NAME = "ballerina-" + SHORT_VERSION;
    
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
                .resolve("1.0.0")
                .resolve("docker.bir");
    
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("1.0.0")
                .resolve("Ballerina.toml");
        
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
        
        Path bbePath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("docker-deployment");
    
        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("docker");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina-docker-1.0.0.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "docker-extension-"));
        Assert.assertTrue(Files.exists(bbePath));
        Assert.assertTrue(Files.exists(docsPath));
    }
    
    @Test
    public void kubernetesAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("1.0.0")
                .resolve("kubernetes.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("1.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Path bbePath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("kubernetes-deployment");
    
        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("kubernetes");
        
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina-kubernetes-1.0.0.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
        Assert.assertTrue(Files.exists(bbePath));
        Assert.assertTrue(Files.exists(docsPath));
    }
    
    @Test
    public void istioAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("1.0.0")
                .resolve("istio.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("1.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("istio");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina-istio-1.0.0.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
        Assert.assertTrue(Files.exists(docsPath));
    }
    
    @Test
    public void openshiftAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("1.0.0")
                .resolve("openshift.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("1.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Path bbePath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("openshift-deployment");
    
        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("openshift");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina-openshift-1.0.0.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
        Assert.assertTrue(Files.exists(bbePath));
        Assert.assertTrue(Files.exists(docsPath));
    }
    
    @Test
    public void knativeAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("1.0.0")
                .resolve("knative.bir");
        
        Path tomlPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("1.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");
    
        Path bbePath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("knative-deployment");
    
        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("knative");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerina-knative-1.0.0.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
        Assert.assertTrue(Files.exists(bbePath));
        Assert.assertTrue(Files.exists(docsPath));
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
    
        Path bbePath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("aws-lambda-deployment");
    
        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("awslambda");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("ballerinax-awslambda-0.0.0.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "awslambda-extension-"));
        Assert.assertTrue(Files.exists(bbePath));
        Assert.assertTrue(Files.exists(docsPath));
    }
    
    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
