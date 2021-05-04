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
 * Check if necessary openAPI files exists to build in the distribution.
 */
public class OpenAPIDistributionArtifactCheck {
    private static final String DIST_NAME = "ballerina-" + SHORT_VERSION;

    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DIST_NAME + ".zip"));
    }

    @Test
    public void openapiAnnotationExistsTest() {
        Path birPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("repo")
                .resolve("cache")
                .resolve("ballerina")
                .resolve("openapi")
                .resolve("0.9.0-beta.1")
                .resolve("bir");

        Path jarPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("repo")
                .resolve("cache")
                .resolve("ballerina")
                .resolve("openapi")
                .resolve("0.9.0-beta.1")
                .resolve("java11");

        Path balaPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("repo")
                .resolve("bala")
                .resolve("ballerina")
                .resolve("openapi")
                .resolve("0.9.0-beta.1")
                .resolve("java11")
                .resolve("platform")
                .resolve("java11");

        Path breLibPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("bre")
                .resolve("lib");

        Path bbePath01 = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("openapi-to-ballerina");

        Path bbePath02 = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("examples")
                .resolve("ballerina-to-openapi");

        Path docsPath = TEST_DISTRIBUTION_PATH
                .resolve(DIST_NAME)
                .resolve("docs")
                .resolve("ballerina")
                .resolve("openapi");

        Assert.assertTrue(Files.exists(birPath));
        Assert.assertTrue(Files.exists(balaPath));
        Assert.assertTrue(Files.exists(jarPath.resolve("openapi.jar")));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "openapi-cli-"));
        Assert.assertNotNull(TestUtils.findFileOrDirectory(breLibPath, "openapi-validator-"));
        Assert.assertTrue(Files.exists(bbePath01));
        Assert.assertTrue(Files.exists(bbePath02));
        Assert.assertTrue(Files.exists(docsPath));
    }

    @AfterClass
    public void cleanUp() throws IOException {
//        TestUtils.cleanDistribution();
    }
}
