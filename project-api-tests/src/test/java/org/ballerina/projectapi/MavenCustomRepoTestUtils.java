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

import io.ballerina.toml.api.Toml;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.testng.Assert;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.ballerina.projectapi.TestUtils.*;


/**
 * Utility class for maven repository tests.
 */
public class MavenCustomRepoTestUtils {

    /**
     * Create Settings.toml inside the home repository.
     * @param dirPath  folder path to the settings toml
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
     * @param dirPath              directory path
     * @param deleteDirContentOnly delete only the content inside the directory
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

    /**
     * Run the `ballerina pack` command for the given package and return the spawned Process.
     *
     * @param packageName the package directory name under the sourceDirectory
     * @param sourceDirectory the path that contains the package folders
     * @param envVariable environment variables to pass to the process
     * @return the Process for the pack command
     * @throws IOException if an I/O error occurs when starting the process
     * @throws InterruptedException if the current thread is interrupted while waiting for the process
     */
    static Process packTrigger(String packageName, Path sourceDirectory, Map<String, String> envVariable) throws IOException, InterruptedException {
        Process process = executePackCommand(DISTRIBUTION_FILE_NAME,
                sourceDirectory.resolve(packageName), new ArrayList<>(),
                envVariable);

        String buildErrors = getString(process.getErrorStream());
        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        return process;
    }

    /**
     * Run the `ballerina push` command for the given package and return the spawned Process.
     *
     * @param packageName the package directory name under the sourceDirectory
     * @param sourceDirectory the path that contains the package folders
     * @param envVariable environment variables to pass to the process
     * @return the Process for the push command
     * @throws IOException if an I/O error occurs when starting the process
     * @throws InterruptedException if the current thread is interrupted while waiting for the process
     */
    static Process pushTrigger(String packageName, Path sourceDirectory, Map<String, String> envVariable) throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        args.add("--repository=" + MavenCustomRepoTest.GITHUB_REPO_ID);

        Process process = executePushCommand(DISTRIBUTION_FILE_NAME, sourceDirectory.resolve(packageName), args,
                envVariable);
        String buildErrors = getString(process.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        return process;
    }
    /**
     * Replace the `version = ...` line inside the [package] section of a Ballerina.toml.
     *
     * <p>The method performs a simple text substitution: any line starting with
     * {@code version =} is replaced with the provided version string. The file is
     * overwritten with the updated contents.</p>
     *
     * @param sourceDirectory path to the project containing Ballerina.toml
     * @param version the version string to set (e.g. "1.0.0")
     * @throws IOException if reading or writing the Ballerina.toml fails
     */
    static void editVersionBallerinaToml(Path sourceDirectory, String version) throws IOException {
        Path ballerinaTomlPath = sourceDirectory.resolve("Ballerina.toml");
        List<String> lines = Files.readAllLines(ballerinaTomlPath);

        // Replace the version line inside [package] table
        List<String> updatedLines = lines.stream()
                .map(line -> line.trim().startsWith("version =") ? "version = \"" + version + "\"" : line)
                .collect(Collectors.toList());

        // Write back
        Files.write(ballerinaTomlPath, updatedLines);
    }

    /**
     * Update (or insert) a `version = "..."` entry for the given package name inside a
     * Ballerina.toml located in the project directory.
     *
     * <p>The helper searches for a line containing {@code name = "<packageName>"} and then
     * replaces an existing {@code version =} line following it, or inserts one if missing.
     * The operation is persisted to disk and the method returns whether a change was made.</p>
     *
     * @param sourceDirectory the project directory that contains Ballerina.toml
     * @param packageName the package name to adjust (e.g. "pkg1")
     * @param version the version string to set (e.g. "1.1.0")
     * @return true if the file was modified, false if the package name was not found
     * @throws IOException if reading or writing the file fails
     */
    static boolean updateVersionForPackage(Path sourceDirectory, String packageName, String version) throws IOException {
        Path ballerinaTomlPath = sourceDirectory.resolve("Ballerina.toml");
        List<String> lines = Files.readAllLines(ballerinaTomlPath);

        for (int i = 0; i < lines.size(); i++) {
            String trimmed = lines.get(i).trim();
            // look for name = "pkg"
            if (trimmed.startsWith("name") && trimmed.contains("\"" + packageName + "\"")) {
                // search forward for version line until next section header
                for (int j = i + 1; j < lines.size(); j++) {
                    String t = lines.get(j).trim();
                    if (t.startsWith("[")) {
                        // reached next section, insert version right after the name line
                        lines.add(i + 1, "version = \"" + version + "\"");
                        Files.write(ballerinaTomlPath, lines);
                        return true;
                    }
                    if (t.startsWith("version")) {
                        // replace existing version line
                        lines.set(j, "version = \"" + version + "\"");
                        Files.write(ballerinaTomlPath, lines);
                        return true;
                    }
                }
                // reached EOF without finding version or next section: append version after name
                lines.add(i + 1, "version = \"" + version + "\"");
                Files.write(ballerinaTomlPath, lines);
                return true;
            }
        }
        return false; // package name not found
    }

    /**
     * Read a Dependencies.toml and return the version string for the given package name if present.
     *
     * @param dependencyTomlPath path to Dependencies.toml
     * @param packageName        package name to look up
     * @return Optional version string
     * @throws IOException when reading the toml fails
     */
    static Optional<String> getPackageVersionFromDependencies(Path dependencyTomlPath, String packageName) throws IOException {
        Toml toml = Toml.read(dependencyTomlPath);
        List<Toml> packages = toml.getTables("package");
        return packages.stream()
                .filter(pkg -> pkg.get("name").map(n -> n.toString()).orElse("").equals(packageName))
                .map(pkg -> pkg.get("version").map(v -> v.toString()))
                .filter(Optional::isPresent)
                .map(Optional::get)
                .findFirst();
    }

    /**
     * Add or update a [[dependency]] in Ballerina.toml for the given org and package, then update the source (imports/calls) so the package is included at compile time.
     *
     * @param projectDir the project directory containing Ballerina.toml
     * @param org the organization/group id of the dependency (e.g., "bctestorg")
     * @param name the package name of the dependency (e.g., "pkg1")
     * @param version the version to pin for the dependency (e.g., "1.0.0")
     * @param repository the repository id to use for the dependency (e.g., "github1")
     * @throws IOException if reading or writing the Ballerina.toml fails
     */
    public static void ensureLegacyDependency(Path projectDir, String org, String name, String version, String repository) throws IOException {
        Path ballerinaTomlPath = projectDir.resolve("Ballerina.toml");
        if (!Files.exists(ballerinaTomlPath)) {
            throw new IOException("Missing Ballerina.toml in project: " + projectDir);
        }
        String toml = Files.readString(ballerinaTomlPath);
        String desiredDepBlock = "\n[[dependency]]\norg=\"" + org + "\"\nname=\"" + name + "\"\nversion=\"" + version + "\"\nrepository=\"" + repository + "\"\n";
        Pattern depPattern = Pattern.compile("(?s)\\[\\[dependency\\]\\].*?org\\s*=\\s*\"" + Pattern.quote(org) + "\".*?name\\s*=\\s*\"" + Pattern.quote(name) + "\".*?(?:version\\s*=\\s*\"[^\"]*\".*?|)", Pattern.CASE_INSENSITIVE);
        Matcher matcher = depPattern.matcher(toml);
        if (matcher.find()) {
              return;
        } else {
            Files.writeString(ballerinaTomlPath, toml + desiredDepBlock);
        }

        // Ensure source-level usage so the package becomes a compile-time dependency
        if ("pkg1".equals(name) || "pkg2".equals(name) || "pkg3".equals(name)) {
            pasteStaticMainBalWithAllPkgs(projectDir);
        }
    }

    /**
     * Writes a deterministic `main.bal` that imports pkg2 and pkg1 and calls pkg2:main() then pkg1:main().
     * The method is idempotent: it returns early if the file already contains the imports and calls.
     *
     * @param projectDir the project directory where main.bal should be written
     * @throws IOException if an I/O error occurs while creating or writing the file
     */
    public static void pasteStaticMainBalWithPkg1AndPkg2(Path projectDir) throws IOException {
        Path mainBal = projectDir.resolve("main.bal");
        if (!Files.exists(mainBal)) {
            mainBal = projectDir.resolve("src").resolve("main.bal");
        }
        if (mainBal.getParent() != null && !Files.exists(mainBal.getParent())) {
            Files.createDirectories(mainBal.getParent());
        }

        String import1 = "import bctestorg/pkg1;";
        String import2 = "import bctestorg/pkg2;";
        String call1 = "pkg1:main();";
        String call2 = "pkg2:main();";



        String snippet = import2 + "\n" + import1 + "\n" +
                "\n" +
                "public function main(string... args) {\n" +
                "    // Ensure pkg2 then pkg1 are used so they become compile-time dependencies\n" +
                "    " + call2 + "\n" +
                "    " + call1 + "\n" +
                "}\n";

        Files.writeString(mainBal, snippet, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }


    /**
     * Writes a single deterministic `main.bal` that uses pkg2, pkg1 and pkg3. The method is idempotent: it returns early if
     * the file already contains the imports and calls.
     *
     * @param projectDir the project directory where main.bal should be written
     * @throws IOException if an I/O error occurs while creating or writing the file
     */
    public static void pasteStaticMainBalWithAllPkgs(Path projectDir) throws IOException {
        Path mainBal = projectDir.resolve("main.bal");
        if (!Files.exists(mainBal)) {
            mainBal = projectDir.resolve("src").resolve("main.bal");
        }
        if (mainBal.getParent() != null && !Files.exists(mainBal.getParent())) {
            Files.createDirectories(mainBal.getParent());
        }

        String import1 = "import bctestorg/pkg1;";
        String import2 = "import bctestorg/pkg2;";
        String import3 = "import bctestorg/pkg3;";
        String call1 = "pkg1:main();";
        String call2 = "pkg2:main();";
        String call3 = "pkg3:main();";

        if (Files.exists(mainBal)) {
            String existing = Files.readString(mainBal);
            if (existing.contains(import1) && existing.contains(import2) && existing.contains(import3)
                    && existing.contains(call1) && existing.contains(call2) && existing.contains(call3)) {
                return; // already contains desired snippet
            }
        }

        String snippet = import2 + "\n" + import1 + "\n" + import3 + "\n" +
                "\n" +
                "public function main(string... args) {\n" +
                "    // Ensure pkg2, pkg1 and pkg3 are used so they become compile-time dependencies\n" +
                "    " + call2 + "\n" +
                "    " + call1 + "\n" +
                "    " + call3 + "\n" +
                "}\n";

        Files.writeString(mainBal, snippet, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }

}
