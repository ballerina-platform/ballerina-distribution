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

import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;


import static org.ballerina.projectapi.MavenCustomRepoTestUtils.createSettingToml;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.deleteArtifacts;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.deleteFiles;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.getEnvVariables;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.getString;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeBuildCommand;
import static org.ballerina.projectapi.TestUtils.executePullCommand;
import static org.ballerina.projectapi.TestUtils.executePushCommand;

/**
 * Tests related to Maven repositories.
 */
public class MavenCustomRepoTest {

    private static final String org = "bctestorg";
    private static final String packagename = "pact";
    private static final String version = "0.2.0";
    private static final String GITHUB_REPO_ID = "github1";
    private Path actualHomeDirectory;
    private Path tempWorkspaceDirectory;
    private Path actualHomeDirectoryClone;
    private Map<String, String> envVariables;

    @BeforeClass()
    public void setUp() throws IOException {
        TestUtils.setupDistributions();
        actualHomeDirectory = Paths.get(System.getProperty("user.home")).resolve(".ballerina");
        actualHomeDirectoryClone = Files.createTempDirectory("bal-test-integration-packaging-home-")
                .resolve(".ballerina");
        Files.walkFileTree(actualHomeDirectory,
                new MavenCustomRepoTest.Copy(actualHomeDirectory, actualHomeDirectoryClone));
        deleteFiles(actualHomeDirectory, true);
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");

        createSettingToml(actualHomeDirectory);
        System.setProperty("user.home", actualHomeDirectory.getParent().toString());
        envVariables = getEnvVariables();

        // Copy test resources to temp workspace directory
        try {
            URI testResourcesURI = Objects.requireNonNull(getClass().getClassLoader()
                    .getResource("maven-repos")).toURI();
            Files.walkFileTree(Paths.get(testResourcesURI), new MavenCustomRepoTest.Copy(Paths.get(testResourcesURI),
                    this.tempWorkspaceDirectory));
        } catch (URISyntaxException e) {
            Assert.fail("error loading resources");
        }
    }

    @Test(description = "Push package to Github packages")
    public void testPushBalaGithub() throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        args.add("--repository=" + GITHUB_REPO_ID);
        Process build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(packagename),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        Assert.assertTrue(buildOutput.contains("Successfully pushed target/bala/" + org + "-"
                + packagename + "-any-" + version + ".bala to " + "'" + GITHUB_REPO_ID + "' repository."));
    }

    @Test(description = "Pull package from Github packages", dependsOnMethods = "testPushBalaGithub")
    public void testPullBalaGithub() throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        args.add(org + "/" + packagename + ":" + version);
        args.add("--repository=" + GITHUB_REPO_ID);
        Process build = executePullCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(packagename),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        Assert.assertTrue(buildOutput.contains("Successfully pulled the package from the custom repository"));

        Path packagePath = this.actualHomeDirectory.resolve("repositories")
                .resolve(GITHUB_REPO_ID).resolve("bala").resolve(org).resolve(packagename).resolve(version);
        Assert.assertTrue(Files.exists(packagePath.resolve("any")));
        deleteFiles(this.actualHomeDirectory.resolve("repositories").resolve(GITHUB_REPO_ID), false);
    }

    @Test(description = "Build a package offline using a module from Github packages",
            dependsOnMethods = "testPullBalaGithub")
    public void testBuildBalaGithubOffline() throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        args.add("--offline=true");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory
                        .resolve("test-resolution"),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        Assert.assertTrue(buildErrors.contains("cannot resolve module '" + org + "/pact as _'"));
    }

    @Test(description = "Build a package Online using a module from Github packages",
            dependsOnMethods = "testBuildBalaGithubOffline")
    public void testBuildBalaGithubOnline() throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        args.add("--offline=false");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory
                        .resolve("test-resolution"),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        Assert.assertTrue(buildOutput.contains("Generating executable\n\ttarget/bin/test.jar"));
    }

    @AfterClass
    private void cleanup() throws IOException {
        deleteFiles(actualHomeDirectory, true);
        Files.walkFileTree(actualHomeDirectoryClone,
                new MavenCustomRepoTest.Copy(actualHomeDirectoryClone, actualHomeDirectory));
        deleteFiles(actualHomeDirectoryClone, false);
        deleteFiles(tempWorkspaceDirectory, false);
        deleteArtifacts(org, packagename);
    }



    /**
     * Copy test resources to temp directory.
     */
    static class Copy extends SimpleFileVisitor<Path> {
        private final Path fromPath;
        private final Path toPath;
        private final StandardCopyOption copyOption;

        Copy(Path fromPath, Path toPath, StandardCopyOption copyOption) {
            this.fromPath = fromPath;
            this.toPath = toPath;
            this.copyOption = copyOption;
        }

        Copy(Path fromPath, Path toPath) {
            this(fromPath, toPath, StandardCopyOption.REPLACE_EXISTING);
        }

        @Override
        public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {

            Path targetPath = toPath.resolve(fromPath.relativize(dir).toString());
            if (!Files.exists(targetPath)) {
                Files.createDirectory(targetPath);
            }
            return FileVisitResult.CONTINUE;
        }

        @Override
        public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {

            Files.copy(file, toPath.resolve(fromPath.relativize(file).toString()), copyOption);
            return FileVisitResult.CONTINUE;
        }
    }
}
