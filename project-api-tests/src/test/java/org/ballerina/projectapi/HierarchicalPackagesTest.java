package org.ballerina.projectapi;

import org.apache.commons.io.FileUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_TOML;
import static org.ballerina.projectapi.CentralTestUtils.COMMON_VERSION;
import static org.ballerina.projectapi.CentralTestUtils.DEPENDENCIES_TOML;
import static org.ballerina.projectapi.CentralTestUtils.buildPackageBala;
import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getExecutableJarPath;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.CentralTestUtils.testPushPackage;
import static org.ballerina.projectapi.CentralTestUtils.testPushPackageToLocal;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeBuildCommand;

public class HierarchicalPackagesTest {

    private Path tempHomeDirectory;
    private Path tempWorkspaceDirectory;
    private Map<String, String> envVariables;
    //    private String orgName = "bc2testorg";
    private String orgName = "dilhashanazeer";
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
        List<String> packageNames = Arrays.asList("PackageH.test", "PackageI.test", "PackageK.test", "PackageN.test",
                "PackageI.test", "PackageN.test", "PackageH.test.mod");
        List<String> versions = Arrays.asList(COMMON_VERSION, COMMON_VERSION, COMMON_VERSION, "1.0.0-beta.1",
                updatedVersion, updatedVersion, updatedVersion);
        List<Boolean> isUpdatedVersion = Arrays.asList(false, false, false, false, true, true, true);
        List<String> previousVersions = Arrays.asList("", "", "", "", COMMON_VERSION, "1.0.0-beta.1", COMMON_VERSION);
        for (int i = 0; i < packageNames.size(); i++) {
            String packageName = packageNames.get(i);
            String version = versions.get(i);
            if (!CentralTestUtils.isPkgAvailableInCentral(packageName, tempWorkspaceDirectory, envVariables)) {
                if (isUpdatedVersion.get(i)) {
                    // Update version details in Ballerina.toml
                    updateBallerinaToml(packageName, previousVersions.get(i), version, "", "");
                }
                // Build the bala for package
                buildPackageBala(tempWorkspaceDirectory, envVariables, packageName, orgName, version,
                        Collections.emptyList());
                // Push the package to central
                testPushPackage(tempWorkspaceDirectory, packageName, envVariables, orgName, packageName,
                        version);
            }
        }
        // Push package to local
        String localPackageName = "PackageQ.test";
        if (!CentralTestUtils.isPkgAvailableInCentral(localPackageName, tempWorkspaceDirectory, envVariables)) {
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, localPackageName, orgName, COMMON_VERSION,
                    Collections.emptyList());
            testPushPackageToLocal(tempWorkspaceDirectory, localPackageName, envVariables, orgName,
                    localPackageName, COMMON_VERSION);
        }
        // Build and push updated Versions to Central
        packageNames = Arrays.asList("PackageI.test", "PackageN.test", "PackageH.test.mod");
        previousVersions = Arrays.asList(COMMON_VERSION, "1.0.0-beta.1", COMMON_VERSION);
        for (int i = 0; i < packageNames.size(); i++) {
            String packageName = packageNames.get(i);
            if (!CentralTestUtils.isPkgAvailableInCentral(packageName, tempWorkspaceDirectory, envVariables)) {
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
    }

    @Test(description = "Verify build package behaviour for hierarchical package imports in two consecutive builds.")
    public void testConsecutiveBuilds() throws IOException, InterruptedException {
        String packageName = "PackageI";
        // First build
        buildPackage(packageName, new LinkedList<>());
        // Consecutive build with existing `Dependencies.toml` and `build` file
        buildPackage(packageName, new LinkedList<>());
    }

    @Test(description = "Verify build package behaviour when there is an updated version for a hierarchical package" +
            " import in Remote Repo.")
    public void testUpdatedVersionInRemote() throws IOException, InterruptedException {
        // Check if specific package version is available in central. If not build and push updated version.
        String importedPackageName = "PackageI.test";
        String packageName = "PackageK";
        // Build package when there is an updated version in Remote Repo
        buildPackage(packageName, new LinkedList<>());
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + importedPackageName + "\"\n" +
                "version = \"" + updatedVersion + "\"");
    }

    // TODO: This test is disabled due to a bug in Central API. Need to re-enable once issue is fixed.
    @Test(description = "Verify build package behaviour when there is an updated version for a pre-release version of " +
            "a hierarchical package import in Remote Repo.", enabled = false)
    public void testUpdateToPreReleaseVersionInRemote() throws IOException, InterruptedException {
        String importedPackageName = "PackageN.test";
        String packageName = "PackageP";
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + importedPackageName + "\"\n" +
                "version = \"" + updatedVersion + "\"");
    }

    @Test(description = "When a new module is added and published to remote repo and project is updated to use " +
            "the new module, check if it pulls the latest even when sticky true")
    public void testUpdatedPackage() throws IOException, InterruptedException {
        // Check if specific package version is available in central. If not build and push updated version.
        String importedPackageName = "PackageK.test";
        if (!CentralTestUtils.isPkgVersionAvailableInCentral(importedPackageName, tempWorkspaceDirectory, envVariables,
                updatedVersion)) {
            // Add a module to the package
            addNewModule(importedPackageName, "doc.api", "mod.api");
            // Update version details in Ballerina.toml
            // Version can be either 1.0.0 or 1.0.1 depending on whether the package was already available on
            // remote repository or not.
            updateBallerinaToml(importedPackageName, COMMON_VERSION, updatedVersion,
                    "\"" + importedPackageName + ".mod.api\"",
                    "\"" + importedPackageName + ".mod.api\", \"" + importedPackageName + ".doc.api\"");
            // Build the bala for updated package
            buildPackageBala(tempWorkspaceDirectory, envVariables, importedPackageName, orgName, updatedVersion,
                    Collections.emptyList());
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, importedPackageName, envVariables, orgName, importedPackageName,
                    updatedVersion);
        }
        String packageName = "PackageL";
        // Import newly added module
        updateImports(packageName, "import " + orgName + "/" + importedPackageName + ".doc.api as _;");
        // Build updated package with sticky
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + importedPackageName + "\"\n" +
                "version = \"" + updatedVersion + "\"");
    }

    @Test(description = "Verify whether the correct packages are picked when there are two possible packages" +
            " for an import")
    public void testTwoPossiblePackages() throws IOException, InterruptedException {
        // Check if specific package version is available in central. If not build and push updated version.
        String importedPackageName = "PackageH.test.mod";
        // PackageM has already locked `orgName/PackageH.test:1.0.0`
        String packageName = "PackageM";
        // Import newly added module in new package `orgName/PackageH.test.mod:1.0.1`
        updateImports(packageName, "import " + orgName + "/PackageH.test.mod.api.doc as _;");
        // Build updated package with sticky
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + importedPackageName + "\"\n" +
                "version = \"" + updatedVersion + "\"");
        // Build package when there is an updated version in Remote Repo
        buildPackage(packageName, new LinkedList<>());
    }

    @Test(description = "Verify build package behaviour if hierarchical package needs to be pulled from local repository.")
    public void testPackageFromLocal() throws IOException, InterruptedException {
        String packageName = "PackageR";
        buildPackage(packageName, new LinkedList<>());
    }

    @Test(description = "Verify build package behaviour when there is an updated version for a transitive " +
            "hierarchical package dependency in Remote Repo.")
    public void testUpdateTransitiveDependency() throws IOException, InterruptedException {
        String transitivePackageName = "PackageI.test";
        String importedPackageName = "PackageS.test";
        if (!CentralTestUtils.isPkgAvailableInCentral(importedPackageName, tempWorkspaceDirectory, envVariables)) {
            // Build the bala for package
            buildPackageBala(tempWorkspaceDirectory, envVariables, importedPackageName, orgName, COMMON_VERSION,
                    Collections.singletonList("--sticky"));
            // Push the package to central
            testPushPackage(tempWorkspaceDirectory, importedPackageName, envVariables, orgName, importedPackageName,
                    COMMON_VERSION);
        }
        String packageName = "PackageT";
        // Build the package that uses above package with sticky true
        buildPackage(packageName, new LinkedList<>(Collections.singletonList("--sticky")));
        // Check the old package version in Dependencies.toml
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + transitivePackageName + "\"\n" +
                "version = \"" + COMMON_VERSION + "\"");
        // Rebuild after clearing target
        Path targetDir = tempWorkspaceDirectory.resolve(packageName).resolve("target");
        FileUtils.deleteDirectory(targetDir.toFile());
        buildPackage(packageName, new LinkedList<>(Collections.emptyList()));
        // Check if version has been updated in Dependencies.toml
        verifyUpdatedDependencies(packageName, "org = \"" + orgName + "\"\n" +
                "name = \"" + transitivePackageName + "\"\n" +
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

    private void updateImports(String packageName, String s) throws IOException {
        Path filePath = tempWorkspaceDirectory.resolve(packageName).resolve("main.bal");
        Stream<String> lines = Files.lines(filePath);
        List<String> updated = new ArrayList<>();
        updated.add(s);
        updated.addAll(lines.collect(Collectors.toList()));
        Files.write(filePath, updated);
        lines.close();
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
        deleteFiles(tempWorkspaceDirectory);
    }
}
