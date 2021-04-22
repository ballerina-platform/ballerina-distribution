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

package org.ballerina.devtools.central;

import org.testng.Assert;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Base64;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Utility class for central tests.
 */
public class CentralTestUtils {

    private CentralTestUtils() {
    }

    static final String BALLERINA_HOME_DIR = "BALLERINA_HOME_DIR";
    static final String BALLERINA_DEV_CENTRAL = "BALLERINA_DEV_CENTRAL";
    static final String BALLERINA_TOML = "Ballerina.toml";
    static final String MAIN_BAL = "main.bal";

    /**
     * Generate random package name.
     *
     * @param count number of characters required
     * @return generated name
     */
    static String randomPackageName(int count) {
        String upperCaseAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz";
        String alpha = upperCaseAlpha + lowerCaseAlpha;
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            int character = (int) (Math.random() * alpha.length());
            builder.append(alpha.charAt(character));
        }
        return builder.toString();
    }

    /**
     * Create Settings.toml inside the home repository.
     *
     * @throws IOException i/o exception when writing to file
     */
    static void createSettingToml(Path dirPath) throws IOException {
        String content = "[central]\n accesstoken = \"" + getToken() + "\"";
        Files.write(dirPath.resolve("Settings.toml"), content.getBytes(), StandardOpenOption.CREATE,
                    StandardOpenOption.TRUNCATE_EXISTING);
    }

    /**
     * Get token of ballerina-central-bot required to push the module.
     *
     * @return token required to push the module.
     */
    private static String getToken() {
        // staging and dev both has the same access token
        return System.getenv("devCentralToken");
    }

    /**
     * Get environment variables and add ballerina_home as a env variable the tmp directory.
     *
     * @return env directory variable array
     */
    static Map<String, String> getEnvVariables() {
        Map<String, String> envVarMap = System.getenv();
        Map<String, String> retMap = new HashMap<>();
        envVarMap.forEach(retMap::put);
        return retMap;
    }

    /**
     * Update the file token by changing the guess token.
     *
     * @param filePath    The file path.
     * @param guessToken  The guess token.
     * @param actualToken The guess token.
     * @throws IOException Error when writing to Ballerina.toml
     */
    static void updateFileToken(Path filePath, String guessToken, String actualToken) throws IOException {
        Stream<String> lines = Files.lines(filePath);
        List<String> replaced = lines.map(line -> line.replaceAll(guessToken, actualToken))
                .collect(Collectors.toList());
        Files.write(filePath, replaced);
        lines.close();
    }

    /**
     * Convert input stream to string.
     *
     * @param outputs input stream
     * @return converted string
     * @throws IOException Error when reading from input stream
     */
    static String getString(InputStream outputs) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(outputs))) {
            Stream<String> logLines = br.lines();
            String generatedLog = logLines.collect(Collectors.joining("\n"));
            logLines.close();
            return generatedLog;
        }
    }

    /**
     * Delete files inside directories.
     *
     * @param dirPath directory path
     * @throws IOException throw an exception if an issue occurs
     */
    static void deleteFiles(Path dirPath) throws IOException {
        if (dirPath == null) {
            return;
        }
        Files.walk(dirPath).sorted(Comparator.reverseOrder()).forEach(path -> {
            try {
                Files.delete(path);
            } catch (IOException e) {
                Assert.fail(e.getMessage(), e);
            }
        });
    }

    /**
     * Get generate bala log.
     *
     * @param org      org name
     * @param pkgName  package name
     * @param platform platform name
     * @param version  package version
     * @return generate bala log
     */
    static String getGenerateBalaLog(String org, String pkgName, String platform, String version) {
        return "Creating bala\n" + "\ttarget/bala/" + org + "-" + pkgName + "-" + platform + "-" + version + ".bala";
    }

    /**
     * Get pushed to central log.
     *
     * @param orgName org name
     * @param pkgName package name
     * @return pushed to central log
     */
    static String getPushedToCentralLog(String orgName, String pkgName) {
        return orgName + "/" + pkgName + ":1.0.0 pushed to central successfully";
    }

    /**
     * Get executable jar path.
     *
     * @param projectPath project path
     * @param pkgName     package name
     * @return executable jar path
     */
    static Path getExecutableJarPath(Path projectPath, String pkgName) {
        return projectPath.resolve("target").resolve("bin").resolve(pkgName + ".jar");
    }

    /**
     * Get executable jar path.
     *
     * @param projectPath project path
     * @param org         org name
     * @param pkgName     package name
     * @param platform    platform name
     * @param version     package version
     * @return bala path
     */
    static Path getBalaPath(Path projectPath, String org, String pkgName, String platform, String version) {
        return projectPath.resolve("target").resolve("bala")
                .resolve(org + "-" + pkgName + "-" + platform + "-" + version + ".bala");
    }
}
