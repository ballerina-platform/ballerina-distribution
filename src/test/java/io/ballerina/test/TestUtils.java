/*
 * Copyright (c) 2020, WSO2 Inc. (http://wso2.com) All Rights Reserved.
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

package io.ballerina.test;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestUtils {
    private static final Logger log = LoggerFactory.getLogger(TestUtils.class);

    public static String getVersionOutput(String version) {
        return "jBallerina " + version + "\n" +
                "Language specification 2019R3\n" +
                "Ballerina tool 0.8.0\n";
    }

    public static Executor getExecutor(String version) {
        Executor executor;
        String provider = System.getenv("OS_TYPE");

        if (provider == null) {
            log.error("OS_TYPE environment variable is not set");
            return null;
        }

        if (provider.equalsIgnoreCase("ubuntu")) {
            executor = new Ubuntu(version);
        } else if (provider.equalsIgnoreCase("windows")) {
            executor = new Windows(version);
        } else if (provider.equalsIgnoreCase("centos")) {
            executor = new CentOS(version);
        } else {
            log.error(provider + " is not a valid value for OS_TYPE environment variable ");
            return null;
        }

        return executor;
    }
}
