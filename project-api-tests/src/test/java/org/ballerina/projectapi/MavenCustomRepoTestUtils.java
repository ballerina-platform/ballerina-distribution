/*
 * Copyright (c) 2023, WSO2 LLC. (http://wso2.com).
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

package org.ballerina.projectapi;

import okhttp3.OkHttpClient;
import okhttp3.Request;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;


/**
 * Utility class for maven repository tests.
 */
public class MavenCustomRepoTestUtils {

    /**
     * Create Settings.toml inside the home repository.
     *
     * @throws IOException i/o exception when writing to file
     */
    static void createSettingToml(Path dirPath) throws IOException {
        String content = "[[repository.maven]]\n " +
                "id = \"github1\"\n " +
                "url = \"https://maven.pkg.github.com/ballerina-platform/ballerina-release\"\n " +
                "username = \"ballerina-platform\"\n " +
                "accesstoken = \"" + getGithubToken() + "\"\n";
        Files.write(dirPath.resolve("Settings.toml"), content.getBytes(), StandardOpenOption.CREATE,
                    StandardOpenOption.TRUNCATE_EXISTING);
    }

    /**
     * Get access token of GitHub required to push the module.
     *
     * @return token required to push the module.
     */
    private static String getGithubToken() {
        return System.getenv("githubAccessToken");
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
     * @param dirPath               directory path
     * @param deleteDirContentOnly  delete only the content inside the directory
     * @throws IOException throw an exception if an issue occurs
     */
    static void deleteFiles(Path dirPath, boolean deleteDirContentOnly) throws IOException {
        Files.walk(dirPath)
                .sorted(Comparator.reverseOrder())
                .map(Path::toFile)
                .forEach(File::delete);
        if (deleteDirContentOnly) {
            Files.createDirectories(dirPath);
        }
    }

    /**
     * Delete artifacts from GitHub.
     * @param org           organization name
     * @param packagename   package name
     */
    static void deleteArtifacts(String org, String packagename) throws IOException {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url("https://api.github.com/orgs/ballerina-platform/packages/maven/" + org + "." + packagename)
                .header("Accept", "application/vnd.github+json")
                .header("Authorization", "Bearer " + getGithubToken())
                .header("X-GitHub-Api-Version", "2022-11-28")
                .delete()
                .build();
        client.newCall(request).execute();
    }
}
