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
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;

import java.io.IOException;

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

    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
