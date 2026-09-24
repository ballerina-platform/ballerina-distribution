/*
 * Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
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

import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.addEnvVariables;
import static org.ballerina.projectapi.TestUtils.executeBuildCommand;
import static org.ballerina.projectapi.TestUtils.executeCommand;
import static org.ballerina.projectapi.TestUtils.executePackCommand;

/**
 * Tests to verify that {@code bal pack}, {@code bal build} and {@code bal test} recover from a
 * version conflict across workspace dependencies by retrying the build in soft locking mode.
 */
public class WorkspaceResolutionRetryTest {

    private static final String RESOURCE_DIR = "workspace-resolution-retry";
    private static final String DEPENDENCIES_TEMPLATE_TOML = "Dependencies-template.toml";
    private static final String DEPENDENCIES_TOML = "Dependencies.toml";
    private static final String DISTRIBUTION_VERSION_PLACEHOLDER = "**INSERT_DISTRIBUTION_VERSION_HERE**";
    private static final String CONFLICT_RETRY_WARNING = "WARNING: Build failed due to version conflicts across " +
            "workspace dependencies. Retrying with soft locking mode";
    private static final List<String> WORKSPACE_PACKAGE_NAMES = List.of("pkgA", "pkgB", "pkgC");

    private Path tempHomeDirectory;
    private Map<String, String> envVariables;

    @BeforeClass
    public void setup() throws IOException {
        TestUtils.setupDistributions();
        tempHomeDirectory = Files.createTempDirectory("bal-test-workspace-resolution-retry-home-");
        envVariables = addEnvVariables(getEnvVariables(), tempHomeDirectory);
    }

    @Test(description = "Verify 'bal pack' recovers from a version conflict across workspace dependencies " +
            "by retrying with soft locking mode")
    public void testPackRetriesWithSoftLockingOnVersionConflict() throws IOException, InterruptedException {
        Path workspace = copyWorkspace("pack");
        Process process = executePackCommand(DISTRIBUTION_FILE_NAME, workspace, new LinkedList<>(), envVariables);
        assertRetriedWithSoftLockingAndConverged(workspace, process);
    }

    @Test(description = "Verify 'bal build' recovers from a version conflict across workspace dependencies " +
            "by retrying with soft locking mode")
    public void testBuildRetriesWithSoftLockingOnVersionConflict() throws IOException, InterruptedException {
        Path workspace = copyWorkspace("build");
        Process process = executeBuildCommand(DISTRIBUTION_FILE_NAME, workspace, new LinkedList<>(), envVariables);
        assertRetriedWithSoftLockingAndConverged(workspace, process);
    }

    @Test(description = "Verify 'bal test' recovers from a version conflict across workspace dependencies " +
            "by retrying with soft locking mode")
    public void testTestRetriesWithSoftLockingOnVersionConflict() throws IOException, InterruptedException {
        Path workspace = copyWorkspace("test");
        Process process = executeCommand("test", DISTRIBUTION_FILE_NAME, workspace, new LinkedList<>(),
                envVariables);
        assertRetriedWithSoftLockingAndConverged(workspace, process);
    }

    private void assertRetriedWithSoftLockingAndConverged(Path workspace, Process process) throws IOException {
        String output = getString(process.getInputStream());
            Assert.assertTrue(output.contains(CONFLICT_RETRY_WARNING),
                "expected the soft locking retry warning in the command output, but it was not found:\n" + output);
        assertDependenciesConverged(workspace);
    }

    private void assertDependenciesConverged(Path workspace) throws IOException {
        String normalizedPkgA = normalizeWorkspacePackageNames(readDependenciesToml(workspace, "pkgA"));
        String normalizedPkgB = normalizeWorkspacePackageNames(readDependenciesToml(workspace, "pkgB"));
        String normalizedPkgC = normalizeWorkspacePackageNames(readDependenciesToml(workspace, "pkgC"));
        Assert.assertEquals(normalizedPkgB, normalizedPkgA,
                "pkgB/Dependencies.toml did not converge to the same dependency versions as pkgA/Dependencies.toml");
        Assert.assertEquals(normalizedPkgC, normalizedPkgA,
                "pkgC/Dependencies.toml did not converge to the same dependency versions as pkgA/Dependencies.toml");
    }

    private String readDependenciesToml(Path workspace, String packageName) throws IOException {
        return Files.readString(workspace.resolve(packageName).resolve(DEPENDENCIES_TOML));
    }

    private String normalizeWorkspacePackageNames(String content) {
        String normalized = content;
        for (String packageName : WORKSPACE_PACKAGE_NAMES) {
            normalized = normalized.replace(packageName, "pkgWorkspaceMember");
        }
        return normalized;
    }

    private Path copyWorkspace(String label) throws IOException {
        Path workspace = Files.createTempDirectory("bal-test-workspace-resolution-retry-" + label + "-");
        try {
            URI resourceUri = Objects.requireNonNull(
                    getClass().getClassLoader().getResource(RESOURCE_DIR)).toURI();
            Files.walkFileTree(Paths.get(resourceUri), new CentralTest.Copy(Paths.get(resourceUri), workspace));
        } catch (URISyntaxException e) {
            throw new IOException("error loading test resources for " + RESOURCE_DIR, e);
        }
        for (String packageName : WORKSPACE_PACKAGE_NAMES) {
            generateDependenciesToml(workspace.resolve(packageName));
        }
        return workspace;
    }

    private void generateDependenciesToml(Path packagePath) throws IOException {
        String currentDistributionVersion = System.getProperty("short.version");
        Path templatePath = packagePath.resolve(DEPENDENCIES_TEMPLATE_TOML);
        Path dependenciesTomlPath = packagePath.resolve(DEPENDENCIES_TOML);
        try (FileInputStream input = new FileInputStream(templatePath.toFile());
             FileOutputStream output = new FileOutputStream(dependenciesTomlPath.toFile());
             BufferedReader reader = new BufferedReader(new InputStreamReader(input));
             BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(output))) {
            String line;
            while ((line = reader.readLine()) != null) {
                writer.write(line.replace(DISTRIBUTION_VERSION_PLACEHOLDER, currentDistributionVersion));
                writer.newLine();
            }
        }
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(tempHomeDirectory);
    }
}
