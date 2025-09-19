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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import io.ballerina.projects.BalToolsManifest;
import io.ballerina.projects.BalToolsToml;
import io.ballerina.projects.JvmTarget;
import io.ballerina.projects.internal.BalToolsManifestBuilder;
import io.ballerina.projects.util.ProjectUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeGroups;
import org.testng.annotations.Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import static io.ballerina.projects.util.ProjectConstants.BALA_DIR_NAME;
import static io.ballerina.projects.util.ProjectConstants.CENTRAL_REPOSITORY_CACHE_NAME;
import static io.ballerina.projects.util.ProjectConstants.REPOSITORIES_DIR;
import static org.ballerina.projectapi.CentralTestUtils.OUTPUT_NOT_CONTAINS_EXP_MSG;
import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
import static org.ballerina.projectapi.CentralTestUtils.getString;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeCommand;
import static org.ballerina.projectapi.TestUtils.executeHelpCommand;
import static org.ballerina.projectapi.TestUtils.executePackCommand;
import static org.ballerina.projectapi.TestUtils.executePushCommand;
import static org.ballerina.projectapi.TestUtils.executeToolCommand;

public class BalToolTest {
    private Path tempWorkspaceDirectory;
    private Map<ToolSubCommand, ToolEnvironment> toolEnvironments;

    static final String ORG_NAME = "bctestorg";
    static final String TOOL_ID = "disttest";
    static final String PACKAGE_NAME = "disttestpackage";
    static final String NON_EXISTING_TOOL = "disttest2";
    static final String LATEST_VERSION = "1.1.0";
    static final String SPECIFIC_VERSION = "1.0.0";
    static final String PATCH_VERSION = "1.0.1";
    static final String NON_EXISTING_VERSION = "1.0.3";
    static final String INCOMPATIBLE_DIST_VERSION = "1.0.4";
    static final String PULL = "pull";
    static final String REMOVE = "remove";
    static final String UPDATE = "update";
    static final String USE = "use";
    static final String LIST = "list";
    static final String SEARCH = "search";

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        TestUtils.setupDistributions();
        Path tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        this.tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
        createSettingToml(tempHomeDirectory);
        this.toolEnvironments = setToolEnvironmentsForSubCommands();
        Map<String, String> envVariables = TestUtils.addEnvVariables(getEnvVariables(), tempHomeDirectory);
        copyTestResourcesToTempWorkspace();
        pushToolPackages(envVariables);
    }

    @BeforeGroups(value = "pull")
    public void setupPullTests() {
        // Remove the tool from bal-tools.toml if exists
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.removeTool(TOOL_ID);
        balToolsToml.modify(balToolsManifest);

        // Delete the tool from local cache if exists
        Path toolPath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(ORG_NAME, PACKAGE_NAME));
        if (Files.exists(toolPath)) {
            ProjectUtils.deleteDirectory(toolPath);
        }
    }

    @Test(description = "Pull a tool without specifying a version", groups = {"pull"})
    public void testPullToolWithoutVersion() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, TOOL_ID)), toolEnvironments.get(ToolSubCommand.PULL).envVariables);
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
                .getActiveTool(TOOL_ID);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + TOOL_ID + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), TOOL_ID);
        Assert.assertEquals(tool.version(), LATEST_VERSION);
        Assert.assertEquals(tool.org(), ORG_NAME);
        Assert.assertEquals(tool.name(), PACKAGE_NAME);

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + TOOL_ID + ":" + LATEST_VERSION + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Pull a tool again without specifying a version",
            dependsOnMethods = "testPullToolWithoutVersion", groups = {"pull"})
    public void testPullToolAgainWithoutVersion() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, TOOL_ID)), toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-pull-again-without-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(TOOL_ID);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + TOOL_ID + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), TOOL_ID);
        Assert.assertEquals(tool.version(), LATEST_VERSION);
        Assert.assertEquals(tool.org(), ORG_NAME);
        Assert.assertEquals(tool.name(), PACKAGE_NAME);

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + TOOL_ID + ":" + LATEST_VERSION + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Pull a tool with a specific version",
            dependsOnMethods = {"testPullToolAgainWithoutVersion"}, groups = {"pull"})
    public void testPullToolWithASpecificVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-pull-with-specific-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(TOOL_ID);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + TOOL_ID + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), TOOL_ID);
        Assert.assertEquals(tool.version(), SPECIFIC_VERSION);
        Assert.assertEquals(tool.org(), ORG_NAME);
        Assert.assertEquals(tool.name(), PACKAGE_NAME);

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + TOOL_ID + ":" + SPECIFIC_VERSION + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString(
                "tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Pull a tool again with a specific version",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullToolAgainWithASpecificVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-pull-again-with-specific-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(TOOL_ID);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool " + TOOL_ID + " is not available in bal-tools.toml");
        }
        BalToolsManifest.Tool tool = toolOpt.get();
        Assert.assertEquals(tool.id(), TOOL_ID);
        Assert.assertEquals(tool.version(), SPECIFIC_VERSION);
        Assert.assertEquals(tool.org(), ORG_NAME);
        Assert.assertEquals(tool.name(), PACKAGE_NAME);

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(tool.org(), tool.name(), tool.version()));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + TOOL_ID + ":" + SPECIFIC_VERSION + " is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString(
                "tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Pull a tool with a non existing version",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullToolWithANonExistingVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + NON_EXISTING_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-pull-with-non-existing-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.PULL).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getTool(TOOL_ID, NON_EXISTING_VERSION, null);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + toolIdAndVersion + " should not be in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.PULL).centralCachePath
                .resolve(Path.of(ORG_NAME, TOOL_ID, NON_EXISTING_VERSION));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool " + TOOL_ID + ":" + NON_EXISTING_VERSION + "  should not be available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString(
                "tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Pull a tool version with incompatible distribution",
            dependsOnMethods = "testPullToolWithASpecificVersion", groups = {"pull"})
    public void testPullAToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + INCOMPATIBLE_DIST_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-pull-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.PULL).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(), readExpectedCmdOutsAsString(
                "tool-execute-specific-help-1.0.0.txt"));
    }

    @BeforeGroups(value = "remove")
    public void setupRemoveTests() throws IOException, InterruptedException {
        // Pull a specific version of a tool
        String specificToolVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, TOOL_ID)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Pull tool version with incompatible distribution
        String incompToolVersion = TOOL_ID + ":" + INCOMPATIBLE_DIST_VERSION;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, incompToolVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Add the dist incompatible version to the toml file
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.addTool(TOOL_ID, ORG_NAME, PACKAGE_NAME, INCOMPATIBLE_DIST_VERSION, false, null);
        balToolsToml.modify(balToolsManifest);
    }

    @Test(description = "Remove a non existing tool", groups = {"remove"})
    public void testRemoveANonExistingTool() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, NON_EXISTING_TOOL)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Validate the command output
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-remove-non-existing-tool.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                NON_EXISTING_TOOL, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(
                outputs.getLeft(),
                readExpectedCmdOutsAsString("tool-execute-unknown-cmd-non-existing.txt"));
        Assert.assertEquals(outputs.getRight(), "");
    }

    @Test(description = "Remove a non existing version of a tool", groups = {"remove"})
    public void testRemoveANonExistingVersionOfATool() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + NON_EXISTING_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);

        // Validate the command output
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-remove-non-existing-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove a tool version with incompatible distribution", groups = {"remove"})
    public void testRemoveToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + INCOMPATIBLE_DIST_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-remove-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove a tool version with incompatible distribution", groups = {"remove"})
    public void testRemoveToolActiveVersion() throws IOException, InterruptedException {
        // Make the latest version active
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.setActiveToolVersion(TOOL_ID, LATEST_VERSION, null);
        balToolsToml.modify(balToolsManifest);

        // Remove the active version
        String toolIdAndVersion = TOOL_ID + ":" + LATEST_VERSION;
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
                TOOL_ID, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove a specific tool version",
            dependsOnMethods = {"testRemoveANonExistingVersionOfATool",
                    "testRemoveToolVersionWithIncompatibleDistribution", "testRemoveToolActiveVersion"},
            groups = {"remove"})
    public void testRemoveASpecificToolVersion() throws IOException, InterruptedException {
        // Make the latest version active
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.setActiveToolVersion(TOOL_ID, LATEST_VERSION, null);
        balToolsToml.modify(balToolsManifest);

        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;

        // Check for tool availability in bal-tools.toml
        Optional<BalToolsManifest.Tool> toolOpt = balToolsManifest.getTool(TOOL_ID, SPECIFIC_VERSION, null);
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
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-remove-specific-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getTool(TOOL_ID, SPECIFIC_VERSION, null);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is available in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.REMOVE).centralCachePath
                .resolve(Path.of(ORG_NAME, PACKAGE_NAME, SPECIFIC_VERSION));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Remove all tool versions", dependsOnMethods = {"testRemoveASpecificToolVersion"},
            groups = {"remove"})
    public void testRemoveAllToolVersions() throws IOException, InterruptedException {
        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.REMOVE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(TOOL_ID);
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + TOOL_ID + "' is not available to be removed");
        }

        // Remove all versions of the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, TOOL_ID)),
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
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(TOOL_ID);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + TOOL_ID + " is available in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.REMOVE).centralCachePath
                .resolve(Path.of(ORG_NAME, PACKAGE_NAME));
        if (Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + TOOL_ID + "' is available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.REMOVE).envVariables);
        Assert.assertEquals(outputs.getLeft(),
                readExpectedCmdOutsAsString("tool-execute-unknown-cmd.txt"));
        Assert.assertEquals(outputs.getRight(), "");
    }

    @BeforeGroups(value = "update")
    public void setupUpdateTests() throws IOException, InterruptedException {
        // Remove all versions of the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, TOOL_ID)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        getString(cmdExec.getErrorStream());

        // Pull an older version of the tool
        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
    }

    @Test(description = "Update a non-existing tool", groups = {"update"})
    public void testUpdateNonExistingTool() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(UPDATE, NON_EXISTING_TOOL)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString("tool-update-non-existing.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(NON_EXISTING_TOOL);
        if (toolOpt.isPresent()) {
            Assert.fail("Tool " + NON_EXISTING_TOOL + " should not be available in bal-tools.toml");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                NON_EXISTING_TOOL, toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        Assert.assertEquals(
                outputs.getLeft(),
                readExpectedCmdOutsAsString("tool-execute-unknown-cmd-non-existing.txt"));
        Assert.assertEquals(outputs.getRight(), "");
    }

    @Test(description = "Update a tool with new patch and minor versions", groups = {"update"})
    public void testUpdateToolWithNewPatchAndMinor() throws IOException, InterruptedException {
        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(TOOL_ID);
        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion +
                    "' should be the current version in bal-tools.toml before update command");
        }

        // Update the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(UPDATE, TOOL_ID)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-update-with-new-patch-and-minor.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(TOOL_ID);
        toolIdAndVersion = TOOL_ID + ":" + LATEST_VERSION;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in bal-tools.toml");
        }

        // Check for tool availability in local cache
        Path toolVersionCachePath = toolEnvironments.get(ToolSubCommand.UPDATE).centralCachePath
                .resolve(Path.of(ORG_NAME, PACKAGE_NAME, LATEST_VERSION));
        if (!Files.exists(toolVersionCachePath)) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in local cache");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Update a tool with no new versions",
            dependsOnMethods = {"testUpdateToolWithNewPatchAndMinor"}, groups = {"update"})
    public void testUpdateToolWithNoNewVersions() throws IOException, InterruptedException {
        // Check for tool availability in bal-tools.toml
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        Optional<BalToolsManifest.Tool> toolOpt = BalToolsManifestBuilder.from(balToolsToml).build()
                .getActiveTool(TOOL_ID);
        String toolIdAndVersion = TOOL_ID + ":" + LATEST_VERSION;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' should be the current version in bal-tools.toml");
        }

        // Update the tool
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(UPDATE, TOOL_ID)),
                toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());

        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-update-with-no-new-version.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }

        // Check for tool availability in bal-tools.toml
        balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.UPDATE).balToolsTomlPath);
        toolOpt = BalToolsManifestBuilder.from(balToolsToml).build().getActiveTool(TOOL_ID);
        toolIdAndVersion = TOOL_ID + ":" + LATEST_VERSION;
        if (toolOpt.isEmpty()) {
            Assert.fail("Tool '" + toolIdAndVersion + "' is not available in bal-tools.toml");
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.UPDATE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @BeforeGroups(value = "use")
    public void setupUseTests() throws IOException, InterruptedException {
        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, TOOL_ID)), toolEnvironments.get(ToolSubCommand.USE).envVariables);

        // Pull a specific version of a tool
        String specificToolVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);

        // Pull tool version with incompatible distribution
        String incompToolVersion = TOOL_ID + ":" + INCOMPATIBLE_DIST_VERSION;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, incompToolVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);

        // Add the dist incompatible version to the toml file
        BalToolsToml balToolsToml = BalToolsToml.from(toolEnvironments.get(ToolSubCommand.USE).balToolsTomlPath);
        BalToolsManifest balToolsManifest = BalToolsManifestBuilder.from(balToolsToml).build();
        balToolsManifest.addTool(TOOL_ID, ORG_NAME, PACKAGE_NAME, INCOMPATIBLE_DIST_VERSION, false, null);
        balToolsToml.modify(balToolsManifest);
    }

    @Test(description = "Use a newer tool version", groups = {"use"})
    public void testUseNewToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + LATEST_VERSION;
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
                TOOL_ID, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.1.0.txt"));
    }

    @Test(description = "Use a newer tool version", dependsOnMethods = {"testUseNewToolVersion"}, groups = {"use"})
    public void testUseOldToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
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
                TOOL_ID, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Use the currently active tool version",
            dependsOnMethods = {"testUseOldToolVersion"}, groups = {"use"})
    public void testUseCurrentlyActiveToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
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
                TOOL_ID, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Use a non existent tool version", dependsOnMethods = {"testUseCurrentlyActiveToolVersion"},
            groups = {"use"})
    public void testUseNonExistentToolVersion() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + NON_EXISTING_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-use-non-existent-version.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "Use a tool version built with incompatible distribution",
            dependsOnMethods = "testUseNonExistentToolVersion", groups = {"use"})
    public void testUseToolVersionWithIncompatibleDistribution() throws IOException, InterruptedException {
        String toolIdAndVersion = TOOL_ID + ":" + INCOMPATIBLE_DIST_VERSION;
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(USE, toolIdAndVersion)),
                toolEnvironments.get(ToolSubCommand.USE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-use-with-incompatible-dist.txt");
        if (!cmdErrors.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdErrors);
        }

        // Execute the tool
        Pair<String, String> outputs = executeHelpFlagOfTool(
                TOOL_ID, toolEnvironments.get(ToolSubCommand.USE).envVariables);
        Assert.assertEquals(outputs.getLeft(), "");
        Assert.assertEquals(outputs.getRight(),
                readExpectedCmdOutsAsString("tool-execute-specific-help-1.0.0.txt"));
    }

    @Test(description = "List all tools when there are no tools", groups = {"list"})
    public void testListToolsWhenNoToolsInstalled() throws IOException, InterruptedException {
        // Remove the tool entirely
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(REMOVE, TOOL_ID)),
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
                new ArrayList<>(Arrays.asList(PULL, TOOL_ID)), toolEnvironments.get(ToolSubCommand.LIST).envVariables);

        // Pull a specific version of a tool
        String specificToolVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
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
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-list-with-multiple-tool-versions.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Search a tool with tool id", groups = {"list"})
    public void testSearchAToolWithId() throws IOException, InterruptedException {
        Process cmdExec = executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(SEARCH, TOOL_ID)),
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
        String specificToolVersion = TOOL_ID + ":" + SPECIFIC_VERSION;
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, specificToolVersion)),
                toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);

        // Pull the latest tool version
        executeToolCommand(DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(Arrays.asList(PULL, TOOL_ID)),
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
                new ArrayList<>(List.of(TOOL_ID)), toolEnvironments.get(ToolSubCommand.EXECUTE).envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        if (!cmdErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cmdErrors);
        }

        // Validate the command output
        String cmdOutput = getString(cmdExec.getInputStream());
        String expectedOutput = readExpectedCmdOutsAsString(
                "tool-execute-specific-help-1.1.0.txt");
        if (!cmdOutput.contains(expectedOutput)) {
            Assert.fail(OUTPUT_NOT_CONTAINS_EXP_MSG + expectedOutput + "\nactual output:" + cmdOutput);
        }
    }

    @Test(description = "Execute disstest tool", groups = {"execute_tool"})
    public void testExecuteTool() throws IOException, InterruptedException {
        Process cmdExec = executeCommand(TOOL_ID, DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
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

    private Map<ToolSubCommand, BalToolTest.ToolEnvironment> setToolEnvironmentsForSubCommands() {
        return Arrays.stream(ToolSubCommand.values()).map(
                toolSubCommand -> {
                    try {
                        return getToolEnvironment(toolSubCommand);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }).collect(Collectors.toMap(
                toolEnvironment -> toolEnvironment.subCommand, toolEnvironment -> toolEnvironment));
    }

    private BalToolTest.ToolEnvironment getToolEnvironment(ToolSubCommand subCommand) throws IOException {
        Path tempHomeDirectory = Files.createTempDirectory("bal-test-integration-packaging-home-");
        Map<String, String> envVariables = TestUtils.addEnvVariables(getEnvVariables(),
                tempHomeDirectory);
        Path balToolsTomlPath = tempHomeDirectory.resolve(".config").resolve("bal-tools.toml");
        Path centralCachePath = tempHomeDirectory.resolve(
                Path.of(REPOSITORIES_DIR, CENTRAL_REPOSITORY_CACHE_NAME, BALA_DIR_NAME));
        return new BalToolTest.ToolEnvironment(subCommand, envVariables, balToolsTomlPath, centralCachePath);
    }

    private void copyTestResourcesToTempWorkspace() {
        try {
            URI testResourcesURI = Objects.requireNonNull(BalToolTest.class.getClassLoader().getResource("bal-tool")).
                    toURI();
            Path start = Paths.get(testResourcesURI);
            Files.walkFileTree(start, new CentralTest.Copy(start, tempWorkspaceDirectory));
        } catch (URISyntaxException | IOException e) {
            Assert.fail("error loading resources");
        }
    }

    private void pushToolPackages(Map<String, String> envVariables) throws IOException, InterruptedException {
        for (String version :
                Arrays.asList(SPECIFIC_VERSION, PATCH_VERSION, INCOMPATIBLE_DIST_VERSION, LATEST_VERSION)) {
            Path packagePath = tempWorkspaceDirectory.resolve("v" + version).resolve(PACKAGE_NAME);
            Process pack = executePackCommand(DISTRIBUTION_FILE_NAME, packagePath, new LinkedList<>(), envVariables);
            String packErrors = getString(pack.getErrorStream());
            if (!packErrors.isEmpty()) {
                Assert.fail(OUTPUT_CONTAIN_ERRORS + packErrors);
            }
            Optional<Path> balaPath = getBalaPath(packagePath, version);
            if (balaPath.isEmpty()) {
                Assert.fail("Bala file not found for " + TOOL_ID + ":" + version);
            }
            // This should make the tools incompatible with the current distribution for incompatible version tests,
            // and compatible with the current distribution (>=U11) for other versions.
            String balVersion = version.equals(INCOMPATIBLE_DIST_VERSION) ? "2201.99.0" : "2201.11.0";
            updateBallerinaVersionOfBala(balaPath.get(), balVersion);
            Process build = executePushCommand(DISTRIBUTION_FILE_NAME, packagePath, new LinkedList<>(), envVariables);
            String buildErrors = getString(build.getErrorStream());
            if (!buildErrors.isEmpty() && !buildErrors.contains("already exists")) {
                Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
            }
        }
    }

    private Optional<Path> getBalaPath(Path packagePath, String version) {
        Path balaRootPath = packagePath.resolve("target").resolve("bala");
        String balaNamePrefix = ORG_NAME + "-" + PACKAGE_NAME + "-";
        String balaNameSuffix = "-" + version + ".bala";
        for (JvmTarget jvmTarget : JvmTarget.values()) {
            Path balaPath = balaRootPath.resolve(balaNamePrefix + jvmTarget.code() + balaNameSuffix);
            if (Files.exists(balaPath)) {
                return Optional.of(balaPath);
            }
        }
        return Optional.empty();
    }

    private void updateBallerinaVersionOfBala(Path balaFilePath, String balVersion) throws IOException {
        Path tempDir = Files.createTempDirectory(balaFilePath.getFileName().toString());
        try {
            unzipBalaFile(balaFilePath, tempDir);
            updatePackageJsonBallerinaVersion(tempDir, balVersion);
            zipBalaFile(tempDir, balaFilePath);
        } catch (IOException e) {
            Assert.fail("Failed to update the ballerina version of the bala file", e);
        }
    }

    private void unzipBalaFile(Path balaFilePath, Path destDir) throws IOException {
        File destDirFile = destDir.toFile();
        byte[] buffer = new byte[1024];
        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(balaFilePath.toFile()))) {
            ZipEntry zipEntry = zis.getNextEntry();
            while (zipEntry != null) {
                File newFile = newFile(destDirFile, zipEntry);
                if (zipEntry.isDirectory()) {
                    newFile.mkdirs();
                } else {
                    // Create all non-existing directories
                    new File(newFile.getParent()).mkdirs();
                    try (FileOutputStream fos = new FileOutputStream(newFile)) {
                        int len;
                        while ((len = zis.read(buffer)) > 0) {
                            fos.write(buffer, 0, len);
                        }
                    }
                }
                zipEntry = zis.getNextEntry();
            }
            zis.closeEntry();
        }
    }

    private File newFile(File destinationDir, ZipEntry zipEntry) throws IOException {
        File destFile = new File(destinationDir, zipEntry.getName());
        String destDirPath = destinationDir.getCanonicalPath();
        String destFilePath = destFile.getCanonicalPath();
        if (!destFilePath.startsWith(destDirPath + File.separator)) {
            throw new IOException("Entry is outside of the target dir: " + zipEntry.getName());
        }
        return destFile;
    }

    private void updatePackageJsonBallerinaVersion(Path packagePath, String balVersion) throws IOException {
        Path packageJsonPath = packagePath.resolve("package.json");
        String content = Files.readString(packageJsonPath);
        JsonObject jsonObject = JsonParser.parseString(content).getAsJsonObject();

        // Update the value for the given key
        jsonObject.addProperty("ballerina_version", balVersion);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String formattedJson = gson.toJson(jsonObject);
        Files.writeString(packageJsonPath, formattedJson);
    }

    private void zipBalaFile(Path sourceDirPath, Path zipFilePath) throws IOException {
        Files.deleteIfExists(zipFilePath);
        Path zipFile = Files.createFile(zipFilePath);
        try (ZipOutputStream zs = new ZipOutputStream(Files.newOutputStream(zipFile));
             Stream<Path> walk = Files.walk(sourceDirPath)) {
            walk.filter(path -> !Files.isDirectory(path))
                    .forEach(path -> {
                        ZipEntry zipEntry = new ZipEntry(sourceDirPath.relativize(path).toString());
                        try {
                            zs.putNextEntry(zipEntry);
                            Files.copy(path, zs);
                            zs.closeEntry();
                        } catch (IOException e) {
                            throw new RuntimeException("\"Failed to re-zip bala with error: ", e);
                        }
                    });
        }
    }

    private String readExpectedCmdOutsAsString(String outputFileName) {
        try {
            return Files.readString(Path.of(Objects.requireNonNull(
                    BalToolTest.class.getClassLoader().getResource(
                            Path.of("bal-tool/cmd-outputs/").resolve(outputFileName).toString())).toURI()));
        } catch (IOException | URISyntaxException e) {
            throw new RuntimeException("Error reading resource file");
        }
    }

    private Pair<String, String> executeHelpFlagOfTool(String toolId, Map<String, String> envVariables)
            throws IOException, InterruptedException {
        Process cmdExec = executeCommand(toolId, DISTRIBUTION_FILE_NAME, tempWorkspaceDirectory,
                new ArrayList<>(List.of("--help")), envVariables);
        String cmdErrors = getString(cmdExec.getErrorStream());
        String cmdOutput = getString(cmdExec.getInputStream());
        return Pair.of(cmdErrors, cmdOutput);
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
