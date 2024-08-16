/*
 * Copyright (c) 2024, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import org.apache.commons.lang3.tuple.Pair;
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
import java.util.stream.Collectors;

import static io.ballerina.projects.util.ProjectConstants.BALA_DIR_NAME;
import static io.ballerina.projects.util.ProjectConstants.CENTRAL_REPOSITORY_CACHE_NAME;
import static io.ballerina.projects.util.ProjectConstants.REPOSITORIES_DIR;
import static org.ballerina.projectapi.CentralTestUtils.OUTPUT_NOT_CONTAINS_EXP_MSG;
import static org.ballerina.projectapi.CentralTestUtils.TEST_MODE_ACTIVE;
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
    private Path tempHomeDirectory;
    private final String orgName = "bctestorg";
    private static final String toolId = "disttest";
    private static final String nonExistingTool = "disttest2";
    private static final String latestVersion = "1.1.0";
    private static final String specificVersion = "1.0.0";
    private static final String nonExistingVersion = "1.0.3";
    private static final String incompatibleDistVersion = "1.0.4";
    private static final String packageName = "disttest";
    private static final String PULL = "pull";
    private static final String REMOVE = "remove";
    private static final String UPDATE = "update";
    private static final String USE = "use";
    private static final String LIST = "list";
    private static final String SEARCH = "search";
    private Map<ToolSubCommand, ToolEnvironment> toolEnvironments;

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        TestUtils.setupDistributions();
        tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        setToolEnvironmentsForSubCommands();
        Map<String, String> envVariables = getEnvVariables();
        envVariables.put(TEST_MODE_ACTIVE, "true");
        if (!isToolAvailableInCentral(toolId, tempWorkspaceDirectory, envVariables)) {
            Assert.fail("Tool " + toolId + " is not available in central");
        }
    }

    @BeforeGroups(value = "pull")
    public void setupPullTests() {
        // Remove the tool from bal-tools.toml if exists
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.removeTool(toolId);
        balToolsToml.modify(balToolsManifest);

        // Delete the tool from local cache if exists
        Path toolPath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(orgName, packageName));
        if (Files.exists(toolPath)) {
            ProjectUtils.deleteDirectory(toolPath);
        }
    }

    @Test(description = "Pull a tool without specifying a version", groups = {"pull"})
    public void testPullToolWithoutVersion() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolId)), toolEnvironments.get(ToolSubCommand.PULL).envVariables);
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

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
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

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + latestVersion + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Pull a tool again without specifying a version",
            dependsOnMethods = "testPullToolWithoutVersion", groups = {"pull"})
    public void testPullToolAgainWithoutVersion() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolId)), toolEnvironments.get(ToolSubCommand.PULL).envVariables);
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

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
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

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + latestVersion + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Pull a tool with a specific version",
            dependsOnMethods = {"testPullToolAgainWithoutVersion"}, groups = {"pull"})
    public void testPullToolWithASpecificVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
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

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
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

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + specificVersion + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Pull a tool again with a specific version",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullToolAgainWithASpecificVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
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

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
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

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + specificVersion + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Pull a tool with a non existing version",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullToolWithANonExistingVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + nonExistingVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-with-non-existing-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getTool(toolId, nonExistingVersion, null);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + toolIdAndVersion + " should not be in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(orgName, toolId, nonExistingVersion));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + toolId + ":" + nonExistingVersion + "  should not be available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Pull a tool version with incompatible distribution",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullAToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + incompatibleDistVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-pull-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @BeforeGroups(value = "remove")
    public void setupRemoveTests() throws IOException, InterruptedException {
        // Pull a specific version of a tool
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolId)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Pull tool version with incompatible distribution
        String incompToolVersion = toolId + ":" + incompatibleDistVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, incompToolVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Add the dist incompatible version to the toml file
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.addTool(toolId, orgName, packageName, incompatibleDistVersion, false, null);
        balToolsToml.modify(balToolsManifest);
    }

    @Test(description = "Remove a non existing tool", groups = {"remove"})
    public void testRemoveANonExistingTool() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, nonExistingTool)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Validate the command output
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-non-existing-tool.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                nonExistingTool, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(
                outputs.getLeft(), readExpectedCmdOutsAsString("tool-execute-unknown-cmd-non-existing.txt"));
        Assert.assertEquals("", outputs.getRight());
    }

    @Test(description = "Remove a non existing version of a tool", groups = {"remove"})
    public void testRemoveANonExistingVersionOfATool() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + nonExistingVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Validate the command output
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-non-existing-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove a tool version with incompatible distribution", groups = {"remove"})
    public void testRemoveToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + incompatibleDistVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove a tool version with incompatible distribution", groups = {"remove"})
    public void testRemoveToolActiveVersion() throws IOException, InterruptedException {
        // Make the latest version active
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.setActiveToolVersion(toolId, latestVersion, null);
        balToolsToml.modify(balToolsManifest);

        // Remove the active version
        String toolIdAndVersion = toolId + ":" + latestVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-remove-active-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove a specific tool version",
            dependsOnMethods = {"testRemoveANonExistingVersionOfATool",
                    "testRemoveToolVersionWithIncompatibleDistribution", "testRemoveToolActiveVersion"},
            groups = {"remove"})
    public void testRemoveASpecificToolVersion() throws IOException, InterruptedException {
        // Make the latest version active
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.setActiveToolVersion(toolId, latestVersion, null);
        balToolsToml.modify(balToolsManifest);

        String toolIdAndVersion = toolId + ":" + specificVersion;

        // Check for tool availability in bal-tools.toml
        Optional<BalToolsManifest.Tool> toolOpt = balToolsManifest.getTool(toolId, specificVersion, null);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available to be removed");
        }

        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
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

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getTool(toolId, specificVersion, null);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is available in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.REMOVE).centralCachePath
                .resolve(Path.of(orgName, packageName, specificVersion));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove all tool versions", dependsOnMethods = {"testRemoveASpecificToolVersion"},
            groups = {"remove"})
    public void testRemoveAllToolVersions() throws IOException, InterruptedException {
        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolId + "' is not available to be removed");
        }

        // Remove all versions of the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolId)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
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

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(toolId);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + toolId + " is available in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.REMOVE).centralCachePath
                .resolve(Path.of(orgName, packageName));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolId + "' is available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(outputs.getLeft(), readExpectedCmdOutsAsString("tool-execute-unknown-cmd.txt"));
        Assert.assertEquals("", outputs.getRight());
    }

    @BeforeGroups(value = "update")
    public void setupUpdateTests() throws IOException, InterruptedException {
        // Remove all versions of the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolId)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        getString(cmdExec.getErrorStream());

        // Pull an older version of the tool
        String toolIdAndVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
    }

    @Test(description = "Update a non-existing tool", groups = {"update"})
    public void testUpdateNonExistingTool() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(UPDATE, nonExistingTool)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-update-non-existing.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(nonExistingTool);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + nonExistingTool + " should not be available in bal-tools.toml");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                nonExistingTool, toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        Assert.assertEquals(
                outputs.getLeft(), readExpectedCmdOutsAsString("tool-execute-unknown-cmd-non-existing.txt"));
        Assert.assertEquals("", outputs.getRight());
    }

    @Test(description = "Update a tool with new patch and minor versions", groups = {"update"})
    public void testUpdateToolWithNewPatchAndMinor() throws IOException, InterruptedException {
        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        String toolIdAndVersion = toolId + ":" + specificVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion +
                    "' should be the current version in bal-tools.toml before update command");
        }

        // Update the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(UPDATE, toolId)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
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

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(toolId);
        toolIdAndVersion = toolId + ":" + latestVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.UPDATE).centralCachePath
                .resolve(Path.of(orgName, packageName, latestVersion));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Update a tool with no new versions",
            dependsOnMethods = {"testUpdateToolWithNewPatchAndMinor"}, groups = {"update"})
    public void testUpdateToolWithNoNewVersions() throws IOException, InterruptedException {
        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(toolId);
        String toolIdAndVersion = toolId + ":" + latestVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' should be the current version in bal-tools.toml");
        }

        // Update the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(UPDATE, toolId)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
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

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(toolId);
        toolIdAndVersion = toolId + ":" + latestVersion;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in bal-tools.toml");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @BeforeGroups(value = "use")
    public void setupUseTests() throws IOException, InterruptedException {
        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolId)), toolEnvironments.get(ToolSubCommand.USE).envVariables);

        // Pull a specific version of a tool
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);

        // Pull tool version with incompatible distribution
        String incompToolVersion = toolId + ":" + incompatibleDistVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, incompToolVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);

        // Add the dist incompatible version to the toml file
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.USE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.addTool(toolId, orgName, packageName, incompatibleDistVersion, false, null);
        balToolsToml.modify(balToolsManifest);
    }

    @Test(description = "Use a newer tool version", groups = {"use"})
    public void testUseNewToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + latestVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
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

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Use a newer tool version", dependsOnMethods = {"testUseNewToolVersion"}, groups = {"use"})
    public void testUseOldToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
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

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Use the currently active tool version",
            dependsOnMethods = {"testUseOldToolVersion"}, groups = {"use"})
    public void testUseCurrentlyActiveToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + specificVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
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

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Use a non existent tool version", dependsOnMethods = {"testUseCurrentlyActiveToolVersion"},
            groups = {"use"})
    public void testUseNonExistentToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + nonExistingVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-use-non-existent-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Use a tool version built with incompatible distribution",
            dependsOnMethods = "testUseNonExistentToolVersion", groups = {"use"})
    public void testUseToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = toolId + ":" + incompatibleDistVersion;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-use-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                toolId, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals("", outputs.getLeft());
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "List all tools when there are no tools", groups = {"list"})
    public void testListToolsWhenNoToolsInstalled() throws IOException, InterruptedException {
        // Remove the tool entirely
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolId)),
                toolEnvironments.get(ToolSubCommand.LIST).envVariables);

        // List all tools
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(List.of(LIST)), toolEnvironments.get(ToolSubCommand.LIST).envVariables);
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
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolId)), toolEnvironments.get(ToolSubCommand.LIST).envVariables);

        // Pull a specific version of a tool
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.LIST).envVariables);

        // List all tools
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(List.of(LIST)), toolEnvironments.get(ToolSubCommand.LIST).envVariables);
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
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(SEARCH, toolId)),
                toolEnvironments.get(ToolSubCommand.SEARCH).envVariables);
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
        // Pull a specific version of a tool
        String specificToolVersion = toolId + ":" + specificVersion;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);

        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolId)),
                toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);
    }

    @Test(description = "Execute bal help with the tool installed", groups = {"execute_tool"})
    public void testExecuteGeneralHelpWithToolInstalled() throws IOException, InterruptedException {
        Process cmdExec = executeHelpCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory, new ArrayList<>(),
                toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);
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
        Process cmdExec = executeHelpCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(List.of(toolId)), toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Execute disstest tool", groups = {"execute_tool"})
    public void testExecuteTool() throws IOException, InterruptedException {
        Process cmdExec = executeCommand(toolId, DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(List.of("arg1")), toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);
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

    private void setToolEnvironmentsForSubCommands() {
        toolEnvironments = Arrays.stream(ToolSubCommand.values()).map(
                toolSubCommand -> {
                    try {
                        return getToolEnvironment(toolSubCommand);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }).collect(Collectors.toMap(
                toolEnvironment -> toolEnvironment.subCommand, toolEnvironment -> toolEnvironment));
    }

    private Pair<String, String> executeHelpFlagOfTool(String toolId, Map<String, String> envVariables)
            throws IOException, InterruptedException {
        Process cmdExec = executeCommand(toolId, DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(List.of("--help")), envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String cmdOutput = getString(cmdExec.getInputStream());
        return Pair.of(cmdErrors, cmdOutput);
    }

    private ToolEnvironment getToolEnvironment(ToolSubCommand subCommand) throws IOException {
        Map<String, String> envVariables = TestUtils.addEnvVariables(getEnvVariables(),
                tempHomeDirectory);
        Path balToolsTomlPath = tempHomeDirectory.resolve(".config").resolve("bal-tools.toml");
        Path centralCachePath = tempHomeDirectory.resolve(
                Path.of(REPOSITORIES_DIR, CENTRAL_REPOSITORY_CACHE_NAME, BALA_DIR_NAME));
        return new ToolEnvironment(subCommand, envVariables, balToolsTomlPath, centralCachePath);
    }

    static class ToolEnvironment {
        ToolSubCommand subCommand;
        Map<String, String> envVariables;
        Path balToolsTomlPath;
        Path centralCachePath;

        public ToolEnvironment(ToolSubCommand subCommand, Map<String, String> envVariables, Path balToolsTomlPath,
                               Path centralCachePath) {
            this.subCommand = subCommand;
            this.envVariables = envVariables;
            this.balToolsTomlPath = balToolsTomlPath;
            this.centralCachePath = centralCachePath;
        }
    }
}

enum ToolSubCommand {
    PULL, UPDATE, REMOVE, USE, LIST, SEARCH, EXECUTE
}
