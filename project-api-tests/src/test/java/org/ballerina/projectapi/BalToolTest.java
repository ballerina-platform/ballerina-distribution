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

import io.ballerina.projects.BalToolsManifest;
import io.ballerina.projects.BalToolsToml;
import io.ballerina.projects.internal.BalToolsManifestBuilder;
import io.ballerina.projects.util.ProjectUtils;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeGroups;
import org.testng.annotations.Test;

import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import static io.ballerina.projects.util.ProjectConstants.BALA_DIR_NAME;
import static io.ballerina.projects.util.ProjectConstants.CENTRAL_REPOSITORY_CACHE_NAME;
import static io.ballerina.projects.util.ProjectConstants.REPOSITORIES_DIR;
import static org.ballerina.projectapi.CentralTestUtils.OUTPUT_NOT_CONTAINS_EXP_MSG;
import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.CentralTestUtils.isToolAvailableInCentral;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeCommand;
import static org.ballerina.projectapi.TestUtils.executeHelpCommand;
import static org.ballerina.projectapi.TestUtils.executeToolCommand;

public class BalToolTest {
    private Path tempWorkspaceDirectory;
    private final String orgName = "bctestorg";
    private static final String toolId = "disttest";
    private static final String nonExistingTool = "disttest2";
    private static final String latestVersion = "1.1.0";
    private static final String specificVersion = "1.0.0";
    private static final String nonExistingVersion = "1.0.3";
    private static final String incompatibleDistVersion = "1.0.4";
    private static final String packageName = "disttest";
    private Map<String, String> envVariables;
    private Path balToolsTomlPath;
    private Path centralCachePath;

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        TestUtils.setupDistributions();
        Path tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        envVariables = TestUtils.addEnvVariables(getEnvVariables(), tempHomeDirectory);
        balToolsTomlPath = tempHomeDirectory.resolve(".config").resolve("bal-tools.toml");
        centralCachePath = tempHomeDirectory.resolve(Path.of(REPOSITORIES_DIR, CENTRAL_REPOSITORY_CACHE_NAME,
                BALA_DIR_NAME));

        if (!isToolAvailableInCentral(toolId, tempWorkspaceDirectory, envVariables)) {
            Assert.fail("Tool " + toolId + " is not available in central");
        }
    }

    @BeforeGroups(value = "pull")
    public void setupPullTests() {
        // Remove the tool from bal-tools.toml if exists
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.removeTool(toolId);
        balToolsToml.modify(balToolsManifest);

        // Delete the tool from local cache if exists
        Path toolPath = centralCachePath.resolve(Path.of(orgName, packageName));
        if (Files.exists(toolPath)) {
            ProjectUtils.deleteDirectory(toolPath);
        }
    }

    @Test(description = "Pull tool without specifying a version", groups = {"pull"})
    public void testPullToolWithoutVersion() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-without-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in local env
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + toolId + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), toolId);
        Assert.assertEquals(tool.version(), latestVersion);
        Assert.assertEquals(tool.org(), orgName);
        Assert.assertEquals(tool.name(), packageName);

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + latestVersion + " is not available in local cache");
        }
    }

    @Test(description = "Pull tool again without specifying a version",
            dependsOnMethods = "testPullToolWithoutVersion", groups = {"pull"})
    public void testPullToolAgainWithoutVersion() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-again-without-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in local env
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + toolId + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), toolId);
        Assert.assertEquals(tool.version(), latestVersion);
        Assert.assertEquals(tool.org(), orgName);
        Assert.assertEquals(tool.name(), packageName);

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + latestVersion + " is not available in local cache");
        }
    }

    @Test(description = "Pull tool with a specific version", groups = {"pull"})
    public void testPullToolWithASpecificVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-with-specific-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in local env
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + toolId + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), toolId);
        Assert.assertEquals(tool.version(), specificVersion);
        Assert.assertEquals(tool.org(), orgName);
        Assert.assertEquals(tool.name(), packageName);

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + specificVersion + " is not available in local cache");
        }
    }

    @Test(description = "Pull tool again with a specific version",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullToolAgainWithASpecificVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-again-with-specific-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in local env
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + toolId + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), toolId);
        Assert.assertEquals(tool.version(), specificVersion);
        Assert.assertEquals(tool.org(), orgName);
        Assert.assertEquals(tool.name(), packageName);

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + specificVersion + " is not available in local cache");
        }
    }

    @Test(description = "Pull tool with a non existing version", groups = {"pull"})
    public void testPullToolWithANonExistingVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + nonExistingVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-with-non-existing-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // check for tool availability in local env
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getTool(toolId, nonExistingVersion);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + toolIdAndVersion + " should not be in bal-tools.toml");
        }

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(orgName, toolId, nonExistingVersion));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + nonExistingVersion + "  should not be available in local cache");
        }
    }

    @Test(description = "Pull a tool version with incompatible distribution", groups = {"pull"})
    public void testPullAToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + incompatibleDistVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @BeforeGroups(value = "remove")
    public void setupRemoveTests() throws IOException, InterruptedException {
        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolId)), this.envVariables);

        // Pull tool version with specific tool version
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", specificToolVersion)), this.envVariables);

        // Pull tool version with incompatible distribution
        String incompToolVersion = toolId + ":" + incompatibleDistVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", incompToolVersion)), this.envVariables);

        // add the dist incompatible version to the toml file
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.addTool(toolId, orgName, packageName, incompatibleDistVersion, false);
        balToolsToml.modify(balToolsManifest);
    }

    @Test(description = "Remove a non existing tool", groups = {"remove"})
    public void testRemoveANonExistingTool() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", nonExistingTool)), this.envVariables);

        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-non-existing-tool.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @Test(description = "Remove a non existing version of a tool", groups = {"remove"})
    public void testRemoveANonExistingVersionOfATool() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + nonExistingVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolIdAndVersion)), this.envVariables);

        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-non-existing-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @Test(description = "Remove a tool version with incompatible distribution", groups = {"remove"})
    public void testRemoveToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + incompatibleDistVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @Test(description = "Remove a tool version with incompatible distribution", groups = {"remove"})
    public void testRemoveToolActiveVersion() throws IOException, InterruptedException {
        // make the latest version active
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.setActiveToolVersion(toolId, latestVersion);
        balToolsToml.modify(balToolsManifest);

        String toolIdAndVersion = toolId + ":" + latestVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-active-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @Test(description = "Remove a specific tool version", groups = {"remove"})
    public void testRemoveASpecificToolVersion() throws IOException, InterruptedException {
        // make the latest version active
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.setActiveToolVersion(toolId, latestVersion);
        balToolsToml.modify(balToolsManifest);

        String toolIdAndVersion = toolId + ":" + specificVersion;

        // check for tool availability in local env
        Optional<BalToolsManifest.Tool> toolOpt = balToolsManifest.getTool(toolId, specificVersion);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available to be removed");
        }

        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-specific-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in local env
        balToolsToml = BalToolsToml.from(balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getTool(toolId, specificVersion);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is available in bal-tools.toml");
        }

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(orgName, packageName, specificVersion));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is available in local cache");
        }
    }

    @Test(description = "Remove all tool versions",
            dependsOnMethods = {"testRemoveASpecificToolVersion", "testRemoveToolVersionWithIncompatibleDistribution"},
            groups = {"remove"})
    public void testRemoveAllToolVersions() throws IOException, InterruptedException {
        // check for tool availability in local env
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolId + "' is not available to be removed");
        }

        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-all.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in local env
        balToolsToml = BalToolsToml.from(balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(toolId);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + toolId + " is available in bal-tools.toml");
        }

        Path toolVersionCachePath = centralCachePath.resolve(Path.of(orgName, packageName));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolId + "' is available in local cache");
        }
    }

    @BeforeGroups(value = "update")
    public void setupUpdateTests() throws IOException, InterruptedException {
        // remove all versions of the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolId)), this.envVariables);
        getString(cmdExec.getErrorStream());

        // pull an older version of the tool
        String toolIdAndVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolIdAndVersion)), this.envVariables);
    }

    @Test(description = "Update a non-existing tool", groups = {"update"})
    public void testUpdateNonExistingTool() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("update", nonExistingTool)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-update-non-existing.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(nonExistingTool);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + nonExistingTool + " should not be available in bal-tools.toml");
        }
    }

    @Test(description = "Update a tool with new patch and minor versions", groups = {"update"})
    public void testUpdateToolWithNewPatchAndMinor() throws IOException, InterruptedException {
        // check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        String toolIdAndVersion = toolId + ":" + specificVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion +
                    "' should be the current version in bal-tools.toml before update command");
        }

        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("update", toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-update-with-new-patch-and-minor.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(toolId);
        toolIdAndVersion = toolId + ":" + latestVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in bal-tools.toml");
        }

        // check for tool availability in local env
        Path toolVersionCachePath = centralCachePath.resolve(Path.of(orgName, packageName, latestVersion));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in local cache");
        }
    }

    @Test(description = "Update a tool with no new versions",
            dependsOnMethods = {"testUpdateToolWithNewPatchAndMinor"}, groups = {"update"})
    public void testUpdateToolWithNoNewVersions() throws IOException, InterruptedException {
        // check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        String toolIdAndVersion = toolId + ":" + latestVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' should be the current version in bal-tools.toml");
        }

        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("update", toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-update-with-no-new-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(toolId);
        toolIdAndVersion = toolId + ":" + latestVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in bal-tools.toml");
        }
    }

    @BeforeGroups(value = "use")
    public void setupUseTests() throws IOException, InterruptedException {
        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolId)), this.envVariables);

        // Pull tool version with specific tool version
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", specificToolVersion)), this.envVariables);

        // Pull tool version with incompatible distribution
        String incompToolVersion = toolId + ":" + incompatibleDistVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", incompToolVersion)), this.envVariables);

        // add the dist incompatible version to the toml file
        BalToolsToml balToolsToml = BalToolsToml.from(balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.addTool(toolId, orgName, packageName, incompatibleDistVersion, false);
        balToolsToml.modify(balToolsManifest);
    }

    @Test(description = "Use a newer tool version", groups = {"use"})
    public void testUseNewToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + latestVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("use", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-use-new-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Use a newer tool version", dependsOnMethods = {"testUseNewToolVersion"}, groups = {"use"})
    public void testUseOldToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("use", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-use-old-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Use the currently active tool version",
            dependsOnMethods = {"testUseOldToolVersion"}, groups = {"use"})
    public void testUseCurrentlyActiveToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("use", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-use-active-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Use a non existent tool version", groups = {"use"})
    public void testUseNonExistentToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + nonExistingVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("use", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        String expectedOutput = readExpectedCmdOutsAsString("tool-use-non-existent-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @Test(description = "Use a tool version built with incompatible distribution", groups = {"use"})
    public void testUseToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + incompatibleDistVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("use", toolIdAndVersion)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        String expectedOutput = readExpectedCmdOutsAsString("tool-use-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }
    }

    @Test(description = "List all tools when there are no tools", groups = {"list"})
    public void testListToolsWhenNoToolsInstalled() throws IOException, InterruptedException {
        // remove the tool entirely
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("remove", toolId)), this.envVariables);

        // list all tools
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(List.of("list")), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-list-with-no-tools.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "List all tools when there are multiple versions of tools", groups = {"list"})
    public void testListToolsWithMultipleToolVersions() throws IOException, InterruptedException {
        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolId)), this.envVariables);

        // Pull tool version with specific tool version
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", specificToolVersion)), this.envVariables);

        // list all tools
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(List.of("list")), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-list-with-multiple-tool-versions.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Search a tool with tool id", groups = {"list"})
    public void testSearchAToolWithId() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("search", toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-search-with-tool-id.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @BeforeGroups(value = "execute_tool")
    public void setupExecuteToolTests() throws IOException, InterruptedException {
        // Pull tool version with specific tool version
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", specificToolVersion)), this.envVariables);

        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList("pull", toolId)), this.envVariables);
    }

    @Test(description = "Execute bal help with the tool installed", groups = {"execute_tool"})
    public void testExecuteGeneralHelpWithToolInstalled() throws IOException, InterruptedException {
        Process cmdExec = executeHelpCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory, new ArrayList<>(),
                this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-execute-general-help.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Execute bal help disttest with the tool installed", groups = {"execute_tool"})
    public void testExecuteToolSpecificHelpWithToolInstalled() throws IOException, InterruptedException {
        Process cmdExec = executeHelpCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(List.of(toolId)), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-execute-specific-help.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Execute disstest tool", groups = {"execute_tool"})
    public void testExecuteTool() throws IOException, InterruptedException {
        Process cmdExec = executeCommand(toolId, DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory,
                new ArrayList<>(List.of("arg1")), this.envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-execute-tool.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    private static String readExpectedCmdOutsAsString(String outputFileName) {
        try {
            return Files.readString(Path.of(Objects.requireNonNull(
                    BalToolTest.class.getClassLoader().getResource(
                            Path.of("bal-tool/cmd-outputs/").resolve(outputFileName).toString())).toURI()));
        } catch (IOException | URISyntaxException e) {
            throw new RuntimeException("Error reading resource file");
        }
    }
}
