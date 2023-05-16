/*
 * Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import static org.ballerina.projectapi.CentralTestUtils.DEPENDENCIES_TOML;
import static org.ballerina.projectapi.CentralTestUtils.PACKAGE_NAME_SEPARATOR;
import static org.ballerina.projectapi.CentralTestUtils.buildPackageBala;
import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getExecutableJarPath;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.CentralTestUtils.replaceRandomPackageName;
import static org.ballerina.projectapi.CentralTestUtils.testPushPackage;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeBuildCommand;

/**
 * Tests related to dependency resolution with distribution compatibility restrictions in central.
 */
public class DistributionCompatibilityTest {

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private Map<String, String> envVariables;
    private String orgName = "bctestorg";
    private String projectPath = "distribution-tests";
    private String randomPackageSuffix;
    private static final int BUFFER_SIZE = 4096;

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
        String dependencyVersion = "1.1.0";

        randomPackageSuffix = CentralTestUtils.randomPackageName(6);
        String multiPackageName = "disttestmultiples";
        String updatedMultiPackageName = multiPackageName + PACKAGE_NAME_SEPARATOR + randomPackageSuffix;
        // Update directory to match the package name
        replaceContainingDir(multiPackageName, updatedMultiPackageName);
        modifyBala(multiPackageName, updatedMultiPackageName);
        replaceRandomPackageName(tempWorkspaceDirectory, updatedMultiPackageName, multiPackageName);

        // Push dependency built with beta6, 9999.0.0 and a 1.1.0 version of multiple dependencies
        List<String> dependencyPackages = Arrays.asList("disttestpackbeta6", "forwardpack1", updatedMultiPackageName);
        for (String dependencyPackageName : dependencyPackages) {
            if (!CentralTestUtils.isPkgAvailableInCentral(orgName + "/" + dependencyPackageName,
                    tempWorkspaceDirectory, envVariables)) {
                CentralTestUtils.testPushPackageUsingBalaPath(tempWorkspaceDirectory, dependencyPackageName,
                        envVariables, orgName, dependencyPackageName, dependencyVersion,
                        tempWorkspaceDirectory.resolve(dependencyPackageName).resolve(orgName + "-" +
                                dependencyPackageName + "-any-" + dependencyVersion + ".bala").toString());
            }
        }

        // Delete the bala file for multiple dependencies
        FileUtils.forceDelete(FileUtils.getFile(String.valueOf(tempWorkspaceDirectory.resolve(updatedMultiPackageName).
                resolve(orgName + "-" + updatedMultiPackageName + "-any-" + dependencyVersion + ".bala"))));

        // Dependency built with this ballerina version
        String dependencyPackage = "disttestpack1";
        String updatedDependencyPackage = dependencyPackage + PACKAGE_NAME_SEPARATOR + randomPackageSuffix;
        replaceRandomPackageName(tempWorkspaceDirectory, updatedDependencyPackage, dependencyPackage);
        replaceContainingDir(dependencyPackage, updatedDependencyPackage);
        if (!CentralTestUtils.isPkgAvailableInCentral(orgName + "/" + updatedDependencyPackage,
                tempWorkspaceDirectory, envVariables)) {
            pushToCentral(updatedDependencyPackage, dependencyVersion);
        }
    }

    private void replaceContainingDir(String packageName, String updatedPackageName) {
        File multiplesDir = new File(tempWorkspaceDirectory.toFile(), packageName);
        File updatedMultiplesDir = new File(tempWorkspaceDirectory.toFile(), updatedPackageName);
        if (multiplesDir.exists()) {
            multiplesDir.renameTo(updatedMultiplesDir);
        }
    }

    @Test(description = "Verify dependency resolution with a dependency built with same distribution version.")
    public void testDependencyResolutionWithSameDist() throws IOException, InterruptedException {
        String dependencyPackageName = "disttestpack1" + PACKAGE_NAME_SEPARATOR + randomPackageSuffix;
        String dependencyVersion = "1.1.0";
        String packageName = "disttestpack2";
        buildPackage(packageName, new LinkedList<>());
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + dependencyPackageName + "\"\n" +
                "version = \"" + dependencyVersion + "\"");
    }

    @Test(description = "Verify dependency resolution with a dependency built with an older distribution version.")
    public void testDependencyResolutionBackwardCompatibility() throws IOException, InterruptedException {
        String dependencyPackageName = "disttestpackbeta6";
        String dependencyVersion = "1.1.0";
        String packageName = "disttestpack3";
        buildPackage(packageName, new LinkedList<>());
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + dependencyPackageName + "\"\n" +
                "version = \"" + dependencyVersion + "\"");
    }

    @Test(description = "Verify dependency resolution with a dependency built with a future distribution version.")
    public void testDependencyResolutionForwardCompatibility() throws IOException, InterruptedException {
        verifyBuildPackage("disttestpack4", "forwardpack1", new LinkedList<>());
    }

    @Test(description = "Verify dependency resolution with multiple dependencies built with an older and " +
            "current distribution version.")
    public void testWithMultipleDistDependencyVersions() throws IOException, InterruptedException {
        // Push 1.1.1 built with this Ballerina version
        String updatedVersion = "1.1.1";
        String dependencyPackage = "disttestmultiples" + PACKAGE_NAME_SEPARATOR + randomPackageSuffix;

        if (!CentralTestUtils.isPkgVersionAvailableInCentral(orgName + "/" + dependencyPackage,
                tempWorkspaceDirectory, envVariables, updatedVersion)) {
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, dependencyPackage, orgName, updatedVersion,
                    Collections.emptyList());
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, dependencyPackage, envVariables, orgName, dependencyPackage,
                    updatedVersion);
        }
        String packageName = "disttestpack5";
        buildPackage(packageName, new LinkedList<>());
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + dependencyPackage + "\"\n" +
                "version = \"" + updatedVersion + "\"");
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

    private void pushToCentral(String packageName, String version) throws IOException, InterruptedException {
        if (!CentralTestUtils.isPkgAvailableInCentral(orgName + "/" + packageName, tempWorkspaceDirectory,
                envVariables)) {
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, packageName, orgName, version,
                    Collections.emptyList());
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, packageName, envVariables, orgName, packageName,
                    version);
        }
    }

    private void verifyUpdatedDependencies(String packageName, String dependencyUpdate) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve(DEPENDENCIES_TOML);
        String content = Files.readString(filePath);
        Assert.assertTrue(content.contains(dependencyUpdate));
    }

    private void verifyBuildPackage(String packageName, String dependencyPackage, LinkedList args) throws IOException,
            InterruptedException {
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(packageName),
                args, this.envVariables);
        try (InputStream errStream = build.getErrorStream()) {
            String buildErrors = getString(errStream);
            if (!buildErrors.isEmpty()) {
                Assert.assertTrue(buildErrors.contains("cannot resolve module '" + orgName + "/" + dependencyPackage +
                        " as _'"));
            } else {
                Assert.fail("Build output does not contain the expected error");
            }
        }
    }

    private void modifyBala(String packageName, String updatedPackageName) throws IOException {
        // Open the zip file
        String dependencyVersion = "1.1.0";
        Path sourcePath = this.tempWorkspaceDirectory.resolve(updatedPackageName).resolve(orgName + "-" +
                packageName + "-any-" + dependencyVersion + ".bala");
        File zipFile = new File(sourcePath.toString());
        ZipFile zip = new ZipFile(zipFile);

        // Create a new zip file with the updated contents
        Path packageDir = this.tempWorkspaceDirectory.resolve(updatedPackageName);
        if (!packageDir.toFile().exists()) {
            Files.createDirectories(packageDir);
        }
        Path destinationPath = this.tempWorkspaceDirectory.resolve(updatedPackageName).resolve(orgName + "-" +
                updatedPackageName + "-any-" + dependencyVersion + ".bala");

        // Create a temporary directory for the new contents
        File tempDir = Files.createTempDirectory("zipFileModification").toFile();

        // Extract the zip file to the temporary directory
        zip.stream()
                .forEach(entry -> {
                    try {
                        String entryName = entry.getName();
                        File entryFile = new File(tempDir, entryName);
                        if (entry.isDirectory()) {
                            entryFile.mkdirs();
                        } else {
                            entryFile.getParentFile().mkdirs();
                            FileOutputStream outputStream = new FileOutputStream(entryFile);
                            InputStream inputStream = zip.getInputStream(entry);
                            byte[] buffer = new byte[BUFFER_SIZE];
                            int bytesRead;
                            while ((bytesRead = inputStream.read(buffer)) > 0) {
                                outputStream.write(buffer, 0, bytesRead);
                            }
                            outputStream.close();
                            inputStream.close();
                        }
                    } catch (IOException e) {
                        throw new UncheckedIOException(e);
                    }
                });

        // Rename the disttestmultiples module directory to disttestmultiples_<randomSuffix>
        File disttestmultiplesDir = new File(tempDir, "modules/" + packageName);
        if (disttestmultiplesDir.exists()) {
            File disttestmultiplesXyztheDir = new File(tempDir, "modules/" + updatedPackageName);
            disttestmultiplesDir.renameTo(disttestmultiplesXyztheDir);
        }
        Path packageJsonFile = Paths.get(tempDir.toString(), "package.json");
        if (packageJsonFile.toFile().exists()) {
            String content = new String(Files.readAllBytes(packageJsonFile));
            content = content.replace(packageName, updatedPackageName);
            Files.write(packageJsonFile, content.getBytes());
        }
        Path dependenciesJsonFile = Paths.get(tempDir.toString(), "dependency-graph.json");
        if (dependenciesJsonFile.toFile().exists()) {
            String content = new String(Files.readAllBytes(dependenciesJsonFile));
            content = content.replace(packageName, updatedPackageName);
            Files.write(dependenciesJsonFile, content.getBytes());
        }
        createBala(List.of(tempDir.listFiles()), destinationPath.toString());

        // Clean up
        zip.close();
        FileUtils.deleteDirectory(tempDir);
    }

    private void createBala(List<File> listFiles, String destZipFile) throws FileNotFoundException,
            IOException {
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(destZipFile));
        for (File file : listFiles) {
            if (file.isDirectory()) {
                zipDirectory(file, file.getName(), out);
            } else {
                zipFile(file, out);
            }
        }
        out.flush();
        out.close();
    }

    private void zipFile(File file, ZipOutputStream out)
            throws IOException {
        out.putNextEntry(new ZipEntry(file.getName()));
        BufferedInputStream inputStream = new BufferedInputStream(new FileInputStream(
                file));
        long bytesRead = 0;
        byte[] bytesIn = new byte[BUFFER_SIZE];
        int read = 0;
        while ((read = inputStream.read(bytesIn)) != -1) {
            out.write(bytesIn, 0, read);
            bytesRead += read;
        }
        out.closeEntry();
    }

    private void zipDirectory(File folder, String parentFolder,
                              ZipOutputStream out) throws IOException {
        for (File file : folder.listFiles()) {
            if (file.isDirectory()) {
                zipDirectory(file, parentFolder + "/" + file.getName(), out);
                continue;
            }
            out.putNextEntry(new ZipEntry(parentFolder + "/" + file.getName()));
            BufferedInputStream bis = new BufferedInputStream(
                    new FileInputStream(file));
            long bytesRead = 0;
            byte[] bytes = new byte[BUFFER_SIZE];
            int read = 0;
            while ((read = bis.read(bytes)) != -1) {
                out.write(bytes, 0, read);
                bytesRead += read;
            }
            out.closeEntry();
        }
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
        deleteFiles(tempWorkspaceDirectory);
    }

}
