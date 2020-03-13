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
import java.util.Objects;

import static org.ballerinalang.distribution.utils.TestUtils.DISTRIBUTIONS_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.MAVEN_VERSION;
import static org.ballerinalang.distribution.utils.TestUtils.TEST_DISTRIBUTION_PATH;

/**
 * Check if necessary files exists to build in the platform specific distributions.
 */
public class PlatformDistributionArtifactCheckTest {
    
    @DataProvider(name = "distribution-provider")
    public Object[][] distributionNameProvider() {
        return new Object[][]{
                {"ballerina-" + MAVEN_VERSION},
                {"ballerina-linux-" + MAVEN_VERSION},
                {"ballerina-macos-" + MAVEN_VERSION},
                {"ballerina-windows-" + MAVEN_VERSION}
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
    public void dockerAnnotationExistsTest(String distributionFileName) {
        Path distributionsPath = TEST_DISTRIBUTION_PATH.resolve(distributionFileName).resolve("distributions");
        String jballerinaFileName = TestUtils.findFileOrDirectory(distributionsPath, "jballerina-");
        Objects.requireNonNull(jballerinaFileName);
    
        Path birPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("0.0.0")
                .resolve("docker.bir");
    
        Path tomlPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("docker")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("docker.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "docker-extension-"));
    }
    
    @Test(dataProvider = "distribution-provider")
    public void kubernetesAnnotationExistsTest(String distributionFileName) {
        Path distributionsPath = TEST_DISTRIBUTION_PATH.resolve(distributionFileName).resolve("distributions");
        String jballerinaFileName = TestUtils.findFileOrDirectory(distributionsPath, "jballerina-");
        Objects.requireNonNull(jballerinaFileName);
    
        Path birPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("0.0.0")
                .resolve("kubernetes.bir");
        
        Path tomlPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("kubernetes")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("kubernetes.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test(dataProvider = "distribution-provider")
    public void istioAnnotationExistsTest(String distributionFileName) {
        Path distributionsPath = TEST_DISTRIBUTION_PATH.resolve(distributionFileName).resolve("distributions");
        String jballerinaFileName = TestUtils.findFileOrDirectory(distributionsPath, "jballerina-");
        Objects.requireNonNull(jballerinaFileName);
    
        Path birPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("0.0.0")
                .resolve("istio.bir");
        
        Path tomlPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("istio")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("istio.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test(dataProvider = "distribution-provider")
    public void openshiftAnnotationExistsTest(String distributionFileName) {
        Path distributionsPath = TEST_DISTRIBUTION_PATH.resolve(distributionFileName).resolve("distributions");
        String jballerinaFileName = TestUtils.findFileOrDirectory(distributionsPath, "jballerina-");
        Objects.requireNonNull(jballerinaFileName);
    
        Path birPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("0.0.0")
                .resolve("openshift.bir");
        
        Path tomlPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("openshift")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("openshift.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    @Test(dataProvider = "distribution-provider")
    public void knativeAnnotationExistsTest(String distributionFileName) {
        Path distributionsPath = TEST_DISTRIBUTION_PATH.resolve(distributionFileName).resolve("distributions");
        String jballerinaFileName = TestUtils.findFileOrDirectory(distributionsPath, "jballerina-");
        Objects.requireNonNull(jballerinaFileName);
    
        Path birPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("0.0.0")
                .resolve("knative.bir");
        
        Path tomlPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerina")
                .resolve("knative")
                .resolve("0.0.0")
                .resolve("Ballerina.toml");
    
        Path breLibPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(tomlPath));
        Assert.assertTrue(Files.exists(breLibPath.resolve("knative.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "kubernetes-extension-"));
    }
    
    
    @Test(dataProvider = "distribution-provider")
    public void awsLambdaAnnotationExistsTest(String distributionFileName) {
        Path distributionsPath = TEST_DISTRIBUTION_PATH.resolve(distributionFileName).resolve("distributions");
        String jballerinaFileName = TestUtils.findFileOrDirectory(distributionsPath, "jballerina-");
        Objects.requireNonNull(jballerinaFileName);
        
        Path birPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bir-cache")
                .resolve("ballerinax")
                .resolve("awslambda")
                .resolve("0.0.0")
                .resolve("awslambda.bir");
        
        Path breLibPath = distributionsPath
                .resolve(jballerinaFileName)
                .resolve("bre")
                .resolve("lib");
    
        Assert.assertTrue(Files.exists(birPath));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "awslambda-extension-"));
    }
    
    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
