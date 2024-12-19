/*
 * Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
package org.ballerina.projectapi;

import org.apache.commons.io.FileUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.nio.file.StandardOpenOption.APPEND;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_ARTIFACT_TYPE;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_HOME_DIR;
import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_TOML;
import static org.ballerina.projectapi.CentralTestUtils.COMMON_VERSION;
import static org.ballerina.projectapi.CentralTestUtils.DEPENDENCIES_TOML;
import static org.ballerina.projectapi.CentralTestUtils.PACKAGE_NAME_SEPARATOR;
import static org.ballerina.projectapi.CentralTestUtils.PACKAGE_PATH_SEPARATOR;
import static org.ballerina.projectapi.CentralTestUtils.buildPackageBala;
import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getExecutableJarPath;
import static org.ballerina.projectapi.CentralTestUtils.getNewDirectoryName;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.CentralTestUtils.replaceRandomPackageName;
import static org.ballerina.projectapi.CentralTestUtils.testPushPackage;
import static org.ballerina.projectapi.CentralTestUtils.testPushPackageToLocal;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeBuildCommand;

/**
 * Tests related to hierarchical packages.
 */
public class HierarchicalPackagesTest {

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private Map<String, String> envVariables;
    private String randomPackageSuffix;
    private String orgName = "bctestorg";
    private String projectPath = "hierarchical-packages";
    private String updatedVersion = "1.0.1";
    private final String balExtension = ".bal";
    private final String modulesPath = "modules";

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        TestUtils.setupDistributions();
        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        envVariables = TestUtils.addEnvVariables(getEnvVariables(), tempHomeDirectory);

        // Copy test resources to temp workspace directory
        try {
            URI testResourcesURI = Objects.requireNonNull(
                    getClass().getClassLoader().getResource(projectPath)).toURI();
            Files.walkFileTree(Paths.get(testResourcesURI),
                    new CentralTest.Copy(Paths.get(testResourcesURI), this.tempWorkspaceDirectory));
        } catch (URISyntaxException e) {
            Assert.fail("error loading resources");
        }

        // Update the distribution-version in Dependencies.toml
        Files.list(tempWorkspaceDirectory).forEach(path -> {
            File dependenciesTomlTemplate = path.resolve("Dependencies-template.toml").toFile();
            if (dependenciesTomlTemplate.exists()) {
                try {
                    replaceDependenciesTomlVersion(path);
                } catch (IOException e) {
                    Assert.fail("error updating Dependencies.toml for " + path.getFileName()
                            + " with error: " + e.getMessage());
                }
            }
        });

        randomPackageSuffix = CentralTestUtils.randomPackageName(6);
        Set<String> uniquePackageNames = new HashSet<>();

        for (String packageName : tempWorkspaceDirectory.toFile().list()) {
            File newPackageDirName = new File(tempWorkspaceDirectory.resolve(
                    getNewDirectoryName(packageName, randomPackageSuffix)).toUri());
            tempWorkspaceDirectory.resolve(packageName).toFile().renameTo(newPackageDirName);
            uniquePackageNames.add(Arrays.stream(packageName.split("\\.")).
                    filter((b) -> b.startsWith("Package")).toArray()[0].toString());
        }
        for (String packageName : uniquePackageNames) {
            String randomPackageName = packageName + PACKAGE_NAME_SEPARATOR + randomPackageSuffix;
            replaceRandomPackageName(tempWorkspaceDirectory, randomPackageName, packageName);
        }

        List<String> oldPackageNames = Arrays.asList("PackageH.test", "PackageJ.test", "PackageL.test", "PackageT.test",
                "PackageH.test.mod", "PackageR.test");
        List<String> packageNames = oldPackageNames.stream()
                .map(pkg -> getNewDirectoryName(pkg, randomPackageSuffix))
                .collect(Collectors.toList());
        List<String> versions = Arrays.asList(COMMON_VERSION, COMMON_VERSION, COMMON_VERSION, "1.0.0-beta.1",
                updatedVersion, COMMON_VERSION);
        for (int i = 0; i < packageNames.size(); i++) {
            String packageName = packageNames.get(i);
            String version = versions.get(i);
            pushToCentral(packageName, version);
        }
        // Build and push updated Versions to Central
        oldPackageNames = Arrays.asList("PackageJ.test", "PackageT.test");
        packageNames = oldPackageNames.stream()
                .map(pkg -> getNewDirectoryName(pkg, randomPackageSuffix))
                .collect(Collectors.toList());
        List<String> previousVersions = Arrays.asList(COMMON_VERSION, "1.0.0-beta.1");
        for (int i = 0; i < packageNames.size(); i++) {
            String packageName = packageNames.get(i);
            pushUpdatedVersion(previousVersions, i, packageName);
        }
        // Push package to local
        String localPackageName = getNewDirectoryName("PackageQ.test", randomPackageSuffix);
        if (!CentralTestUtils.isPkgAvailableInCentral(orgName + PACKAGE_PATH_SEPARATOR + localPackageName,
                tempWorkspaceDirectory, envVariables)) {
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, localPackageName, orgName, COMMON_VERSION,
                    Collections.emptyList());
            testPushPackageToLocal(tempWorkspaceDirectory, localPackageName, envVariables, orgName,
                    localPackageName, COMMON_VERSION);
        }
    }

    private void pushToCentral(String packageName, String version) throws IOException, InterruptedException {
        if (!CentralTestUtils.isPkgAvailableInCentral(orgName + PACKAGE_PATH_SEPARATOR + packageName,
                tempWorkspaceDirectory, envVariables)) {
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, packageName, orgName, version,
                    Collections.emptyList());
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, packageName, envVariables, orgName, packageName,
                    version);
        }
    }

    private void pushUpdatedVersion(List<String> previousVersions, int i, String packageName) throws IOException,
            InterruptedException {
        if (!CentralTestUtils.isPkgVersionAvailableInCentral(orgName + PACKAGE_PATH_SEPARATOR + packageName,
                tempWorkspaceDirectory, envVariables, updatedVersion)) {
            // Update version details in Ballerina.toml
            updateBallerinaToml(packageName, previousVersions.get(i), updatedVersion, "", "");
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, packageName, orgName, updatedVersion,
                    Collections.emptyList());
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, packageName, envVariables, orgName, packageName,
                    updatedVersion);
        }
    }



    @Test(description = "Verify build package behaviour for hierarchical package imports in two consecutive builds.",
    enabled = false)
    public void testConsecutiveBuilds() throws IOException, InterruptedException {
        String packageName = getNewDirectoryName("PackageI.test", randomPackageSuffix);
        // First build
        buildPackage(packageName, new LinkedList<>());
        // Consecutive build with existing `Dependencies.toml` and `build` file
        buildPackage(packageName, new LinkedList<>());
    }

    @Test(description = "Verify build package behaviour when there is an updated version for a hierarchical package" +
            " import in Remote Repo.")
    public void testUpdatedVersionInRemote() throws IOException, InterruptedException {
        String importedPackageName = getNewDirectoryName("PackageJ.test", randomPackageSuffix);
        String packageName = getNewDirectoryName("PackageK", randomPackageSuffix);
        // Check whether version in Dependencies.toml is the initial version
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, importedPackageName, COMMON_VERSION));
        // Build package when there is an updated version in Remote Repo
        buildPackage(packageName, new LinkedList<>());
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, importedPackageName, updatedVersion));
    }

    @Test(description = "When a new module is added and published to remote repo and project is updated to use " +
            "the new module, check if it pulls the latest even when sticky true")
    public void testUpdatedPackage() throws IOException, InterruptedException {
        // Check if specific package version is available in central. If not build and push updated version.
        String importedPackageName = getNewDirectoryName("PackageL.test", randomPackageSuffix);
        if (!CentralTestUtils.isPkgVersionAvailableInCentral(orgName + PACKAGE_PATH_SEPARATOR + importedPackageName,
                tempWorkspaceDirectory, envVariables, updatedVersion)) {
            // Add a module to the package
            addNewModule(importedPackageName, "doc.api", "mod.api");
            // Update version details in Ballerina.toml
            updateBallerinaToml(importedPackageName, COMMON_VERSION, updatedVersion, "", "");
            addExports(importedPackageName, new String[]{importedPackageName + ".doc.api"});
            // Build the bala for updated package
            buildPackageBala(tempWorkspaceDirectory, envVariables, importedPackageName, orgName, updatedVersion,
                    Collections.emptyList());
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, importedPackageName, envVariables, orgName, importedPackageName,
                    updatedVersion);
        }
        String packageName = getNewDirectoryName("PackageM", randomPackageSuffix);
        // Check whether version in Dependencies.toml is the initial version
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, importedPackageName, COMMON_VERSION));
        // Import newly added module
        updateImports(packageName, "import " + orgName + "/" + importedPackageName + ".doc.api as _;",
                "main.bal");
        // Build updated package with sticky
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, importedPackageName, updatedVersion));
    }

    @Test(description = "Verify whether the correct packages are picked when there are two possible packages" +
            " for an import")
    public void testTwoPossiblePackages() throws IOException, InterruptedException {
        // Check if specific package version is available in central. If not build and push updated version.
        String importedPackageName = getNewDirectoryName("PackageH.test.mod", randomPackageSuffix);
        // PackageN has already locked `orgName/PackageH.test:1.0.0`
        String packageName = getNewDirectoryName("PackageN", randomPackageSuffix);
        // Import newly added module in new package `orgName/PackageH.test.mod:1.0.1`
        updateImports(packageName, "import " + orgName + "/" + importedPackageName + ".api.doc as _;", "main.bal");
        // Build updated package with sticky
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, importedPackageName, updatedVersion));
        // Build package when there is an updated version in Remote Repo
        buildPackage(packageName, new LinkedList<>());
    }

    @Test(description = "Verify build package behaviour if hierarchical package needs to be pulled from local " +
            "repository.")
    public void testPackageFromLocal() throws IOException, InterruptedException {
        String packageName = getNewDirectoryName("PackageR", randomPackageSuffix);
        // Create symbolic link for this package in local repository
        Path target = Paths.get(envVariables.get(BALLERINA_HOME_DIR)).resolve("repositories").
                resolve("local").resolve(BALLERINA_ARTIFACT_TYPE).resolve(orgName);
        Path link = Paths.get(envVariables.get("HOME")).resolve(".ballerina").resolve("repositories").
                resolve("local").resolve(BALLERINA_ARTIFACT_TYPE).resolve(orgName);
        File linkDir = new File(link.toUri());
        if (linkDir.exists()) {
            FileUtils.deleteDirectory(linkDir);
        }

        Files.createDirectories(link.getParent());
        Files.createSymbolicLink(link, target);
        buildPackage(packageName, new LinkedList<>());
        // Delete symbolic link for this package in local repository
        if (linkDir.exists()) {
            FileUtils.deleteDirectory(linkDir);
        }
    }

    @Test(description = "Verify build package behaviour when there is an updated version for a transitive " +
            "hierarchical package dependency in Remote Repo.")
    public void testUpdateTransitiveDependency() throws IOException, InterruptedException {
        String transitivePackagePrefix =  getNewDirectoryName("Transitive.PackageH.test", randomPackageSuffix);
        String randomSuffix = CentralTestUtils.randomPackageName(5);
        String transitivePackageName = transitivePackagePrefix + PACKAGE_NAME_SEPARATOR + randomSuffix;
        String importedPackagePrefix = getNewDirectoryName("PackageO.test", randomPackageSuffix);
        String importedPackageName = importedPackagePrefix + PACKAGE_NAME_SEPARATOR + randomSuffix;

        String packageName = getNewDirectoryName("PackageP", randomPackageSuffix);
        pushPreRequisites(transitivePackagePrefix, transitivePackageName, importedPackagePrefix,
                importedPackageName, packageName);

        // Build the package that uses `importedPackageName` package
        buildPackage(packageName, new LinkedList<>());
        // Update transitive package version and push
        pushUpdatedVersion(Arrays.asList(COMMON_VERSION), 0, transitivePackageName);

        // Build the package that uses `importedPackageName` package with sticky true
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check the old package version in Dependencies.toml
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, transitivePackageName, COMMON_VERSION));

        // Rebuild after clearing target
        Path targetDir = tempWorkspaceDirectory.resolve(packageName).resolve("target");
        FileUtils.deleteDirectory(targetDir.toFile());
        buildPackage(packageName, new LinkedList<>());
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, transitivePackageName, updatedVersion));
    }

    private void pushPreRequisites(String transitivePackagePrefix, String transitivePackageName,
                                   String importedPackagePrefix, String importedPackageName, String packageName)
            throws IOException, InterruptedException {
        // Copy transitivePackage template as a new project
        copyProject(transitivePackagePrefix, transitivePackageName);
        // Copy importedPackage template as a new project
        copyProject(importedPackagePrefix, importedPackageName);

        // Build and push transitivePackage
        pushToCentral(transitivePackageName, COMMON_VERSION);
        // Build and push imported package
        updateImports(importedPackageName, "import " + orgName + "/" + transitivePackageName + " as _;",
                "lib.bal");
        pushToCentral(importedPackageName, COMMON_VERSION);
        updateImports(packageName, "import " + orgName + "/" + importedPackageName + " as _;",
                "main.bal");
    }

    private void copyProject(String packagePrefix, String packageName) throws IOException {
        Files.createDirectories(tempWorkspaceDirectory.resolve(packageName));
        Files.walkFileTree(tempWorkspaceDirectory.resolve(packagePrefix),
                    new CentralTest.Copy(tempWorkspaceDirectory.resolve(packagePrefix),
                            tempWorkspaceDirectory.resolve(packageName)));
        updateBallerinaToml(packageName, COMMON_VERSION, COMMON_VERSION,
                "\"" + packagePrefix + "\"",
                "\"" + packageName + "\"");
    }

    @Test(description = "Verify build package behaviour when there is direct dependency added for another package " +
            "with similar hierarchical name structure as a transitive dependency.")
    public void testTwoPossibleTransitiveDependencies() throws IOException, InterruptedException {
        String transitivePackageName = getNewDirectoryName("PackageH.test", randomPackageSuffix);
        String directPackageName = getNewDirectoryName("PackageH.test.mod", randomPackageSuffix);
        String packageName = getNewDirectoryName("PackageS", randomPackageSuffix);
        // Build package with transitive dependency to "PackageH.test"
        // PackageS <— PackageR.test <— PackageH.test
        buildPackage(packageName, new LinkedList<>(Collections.emptyList()));
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, transitivePackageName, COMMON_VERSION));

        // Add direct dependency for "PackageH.test.mod" and build
        updateImports(packageName, "import " + orgName + "/" + directPackageName + ".api.doc as _;", "main.bal");
        buildPackage(packageName, new LinkedList<>(Collections.emptyList()));
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, directPackageName, updatedVersion));
    }

    // TODO: This test is disabled due to a bug in Central API. Need to re-enable once issue is fixed.
    @Test(description = "Verify build package behaviour when there is an updated version for a pre-release version " +
            "of a hierarchical package import in Remote Repo.", enabled = false)
    public void testUpdateToPreReleaseVersionInRemote() throws IOException, InterruptedException {
        String importedPackageName = getNewDirectoryName("PackageT.test", randomPackageSuffix);
        String packageName = getNewDirectoryName("PackageU", randomPackageSuffix);
        buildPackage(packageName, new LinkedList<>());
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, getDependencyUpdate(orgName, importedPackageName, updatedVersion));
    }

    private void buildPackage(String packageName, LinkedList args) throws IOException, InterruptedException {
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(packageName),
                args, this.envVariables);
        try (InputStream errStream = build.getErrorStream()) {
            String buildErrors = getString(errStream);
            if (!buildErrors.isEmpty()) {
                Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
            }
            Assert.assertTrue(
                    getExecutableJarPath(this.tempWorkspaceDirectory.resolve(packageName), packageName)
                            .toFile().exists());
        }
    }

    private void verifyUpdatedDependencies(String packageName, String dependencyUpdate) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve(DEPENDENCIES_TOML);
        String content = Files.readString(filePath);
        Assert.assertTrue(content.contains(dependencyUpdate));
    }

    private void addNewModule(String packageName, String newModule, String moduleToCopy) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve(modulesPath).resolve(newModule);
        Files.createDirectory(filePath);
        Files.createFile(filePath.resolve(newModule + balExtension));
        Path filePathToCopy = tempWorkspaceDirectory.resolve(packageName).resolve(modulesPath).resolve(moduleToCopy).
                resolve(moduleToCopy + balExtension);
        Stream<String> lines = Files.lines(filePathToCopy);
        Files.write(filePath.resolve(newModule + balExtension), lines.collect(Collectors.toList()));
        lines.close();
    }

    private void updateBallerinaToml(String packageName, String previousVersion, String updatedVersion,
                                     String previousExport, String newExport) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve(BALLERINA_TOML);
        Stream<String> lines = Files.lines(filePath);
        List<String> replaced = lines.map(line -> {
            String updatedLine = line.replaceAll(previousVersion, updatedVersion);
            if (!(previousExport.isEmpty() && newExport.isEmpty())) {
                updatedLine = updatedLine.replaceAll(previousExport, newExport);
            }
            return updatedLine;
        }).collect(Collectors.toList());
        Files.write(filePath, replaced);
        lines.close();
    }

    private void addExports(String packageName, String[] moduleNames) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve(BALLERINA_TOML);
        List<String> exports = new ArrayList<>();
        for (String mod : moduleNames) {
            exports.add("\n");
            exports.add("[[package.modules]]");
            exports.add("name = \"" + mod + "\"");
            exports.add("export = true");
        }
        Files.write(filePath, exports, APPEND);
    }

    private void updateImports(String packageName, String s, String fileName) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve(fileName);
        Stream<String> lines = Files.lines(filePath);
        List<String> updated = new ArrayList<>();
        updated.add(s);
        updated.addAll(lines.collect(Collectors.toList()));
        Files.write(filePath, updated);
        lines.close();
    }

    private String getDependencyUpdate(String orgName, String packageName, String updatedVersion) {
        return "org = \"" + orgName + "\"\n" + "name = \"" + packageName + "\"\n" +
                "version = \"" + updatedVersion + "\"";
    }

    private void replaceDependenciesTomlVersion(Path projectPath) throws IOException {
        String currentDistrVersion = System.getProperty("short.version");
        Path dependenciesTomlTemplatePath = projectPath.resolve("Dependencies-template.toml");
        Path dependenciesTomlPath = projectPath.resolve("Dependencies.toml");

        try (FileInputStream input = new FileInputStream(dependenciesTomlTemplatePath.toString());
             FileOutputStream output = new FileOutputStream(dependenciesTomlPath.toString());
             BufferedReader reader = new BufferedReader(new InputStreamReader(input));
             BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(output))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.replace("**INSERT_DISTRIBUTION_VERSION_HERE**", currentDistrVersion);
                writer.write(line);
                writer.newLine();
            }
        }
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
        deleteFiles(tempWorkspaceDirectory);
    }
}
