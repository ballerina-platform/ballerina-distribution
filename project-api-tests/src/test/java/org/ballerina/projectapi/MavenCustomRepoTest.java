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
import org.testng.annotations.BeforeGroups;
import org.testng.annotations.Test;

import java.io.File;
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
import java.util.Optional;

import static org.ballerina.projectapi.MavenCustomRepoTestUtils.createSettingToml;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.deleteArtifacts;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.deleteFiles;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.editVersionBallerinaToml;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.getEnvVariables;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.getString;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.packTrigger;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.pushTrigger;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.pasteStaticMainBalWithAllPkgs;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.pasteStaticMainBalWithPkg1AndPkg2;
import static org.ballerina.projectapi.MavenCustomRepoTestUtils.updateVersionForPackage;
import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
import static org.ballerina.projectapi.TestUtils.executeBuildCommand;
import static org.ballerina.projectapi.TestUtils.executeCleanCommand;
import static org.ballerina.projectapi.TestUtils.executePackCommand;
import static org.ballerina.projectapi.TestUtils.executePullCommand;
import static org.ballerina.projectapi.TestUtils.executePushCommand;

public class MavenCustomRepoTest {

    private static final String org = "bctestorg";
    private static final String platform = "any";
    private static final String PACKAGE_NAME = "pkg1";
    static final String GITHUB_REPO_ID = "github1";
    private static final String VERSION = "0.1.0";
    private Path actualHomeDirectory;
    private Path tempWorkspaceDirectory;
    private Path actualHomeDirectoryClone;
    private Map<String, String> envVariables;

    @BeforeClass()
    public void setUp() throws IOException, InterruptedException {
        TestUtils.setupDistributions();
            deleteArtifacts(org, "pkg1");
            deleteArtifacts(org, "pkg2");
            deleteArtifacts(org, "pkg3");
              actualHomeDirectory = Paths.get(System.getProperty("user.home")).resolve(".ballerina");
        actualHomeDirectoryClone = Files.createTempDirectory("bal-test-integration-packaging-home-")
                .resolve(".ballerina");
        Files.walkFileTree(actualHomeDirectory,
                new MavenCustomRepoTest.Copy(actualHomeDirectory, actualHomeDirectoryClone));
        deleteFiles(actualHomeDirectory, true);
        tempWorkspaceDirectory = Files.createTempDirectory("bal-test-integration-packaging-workspace-");

        createSettingToml(actualHomeDirectory);
        System.setProperty("user.home", actualHomeDirectory.getParent().toString());
        envVariables = TestUtils.addEnvVariables(getEnvVariables(), actualHomeDirectory);

        // Copy test resources to temp workspace directory
        try {
            URI testResourcesURI = Objects.requireNonNull(getClass().getClassLoader()
                    .getResource("maven-repos")).toURI();
            Files.walkFileTree(Paths.get(testResourcesURI), new MavenCustomRepoTest.Copy(Paths.get(testResourcesURI),
                    this.tempWorkspaceDirectory));
        } catch (URISyntaxException e) {
            Assert.fail("error loading resources");
        }

        publishBalaPackagesBeforeTests();
    }

    @Test(description = "Push package to Github packages", enabled = false)
    public void testPushBalaGithub() throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        Process build = executePackCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PACKAGE_NAME),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        String normalizedOutput = buildOutput.replace("\\", "/").replace("\r\n", "\n").replace("\r", "\n");
        String collapsed = normalizedOutput.replaceAll("\\s+", " ");
        String expectedBalaPath = "target/bala/" + org + "-" + PACKAGE_NAME + "-" + platform + "-" + VERSION + ".bala";

        Assert.assertTrue(collapsed.contains("Creating bala") && collapsed.contains(expectedBalaPath),
                "Expected creation message with path: " + expectedBalaPath + System.lineSeparator()
                        + "Actual output: " + buildOutput);
        args = new ArrayList<>();
        args.add("--repository=" + GITHUB_REPO_ID);
        build = executePushCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PACKAGE_NAME),
                args, this.envVariables);
        buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        buildOutput = getString(build.getInputStream());
        String normalizedPushOutput = buildOutput.replace("\\", "/").replace("\r\n", "\n").replace("\r", "\n");
        String collapsedPush = normalizedPushOutput.replaceAll("\\s+", " ");
        String expectedPushMsg = "Successfully pushed target/bala/" + org + "-" + PACKAGE_NAME + "-any-" + VERSION
                + ".bala to '" + GITHUB_REPO_ID + "' repository.";
        Assert.assertTrue(collapsedPush.contains(expectedPushMsg),
                "Expected push success message. Actual output: " + buildOutput);
    }

    @Test(description = "Pull package from Github packages", dependsOnMethods = "testPushBalaGithub", enabled = false)
    public void testPullBalaGithub() throws IOException, InterruptedException {
        List<String> args = new ArrayList<>();
        args.add(org + "/" + PACKAGE_NAME + ":" + VERSION);
        args.add("--repository=" + GITHUB_REPO_ID);
        Process build = executePullCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve(PACKAGE_NAME),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }

        String buildOutput = getString(build.getInputStream());
        Assert.assertTrue(buildOutput.contains("Successfully pulled the package from the custom repository"));

        Path packagePath = this.actualHomeDirectory.resolve("repositories")
                .resolve(GITHUB_REPO_ID).resolve("bala").resolve(org).resolve(PACKAGE_NAME).resolve(VERSION);
        Assert.assertTrue(Files.exists(packagePath.resolve("any")));
        deleteFiles(this.actualHomeDirectory.resolve("repositories").resolve(GITHUB_REPO_ID), false);
    }

    @Test(description = "Build a package offline using a module from Github packages",
            dependsOnMethods = "testPullBalaGithub", enabled = false)
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
            dependsOnMethods = "testBuildBalaGithubOffline", enabled = false)
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
        String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n").replace("\r", "\n");
        String collapsed = normalized.replaceAll("\\s+", " ");
        Assert.assertTrue(collapsed.contains("Generating executable") && collapsed.contains("target/bin/test.jar"),
                "Expected generating executable + target/bin/test.jar in output. Actual output: " + buildOutput);
    }

     private void publishBalaPackagesBeforeTests() throws IOException, InterruptedException {
         // Iteratively publish the requested versions: pkg1 -> 0.1.0, pkg2 -> 1.0.0 then pkg 3 -> 1.0.0
        String[][] seq = {
                 {"pkg1", "0.1.0"},
                 {"pkg2", "1.0.0"},
                 {"pkg3", "1.0.0"}
         };

         for (String[] entry : seq) {
             String pkg = entry[0];
             String ver = entry[1];
             // packTrigger returns a Process; we don't use the process object, so don't assign it
             packTrigger(pkg, this.tempWorkspaceDirectory, this.envVariables);
             Process push = pushTrigger(pkg, this.tempWorkspaceDirectory, this.envVariables);
             String pushOutput = getString(push.getInputStream());
             String normalizedPushOutput = pushOutput.replace("\\", "/").replace("\r\n", "\n").replace("\r", "\n");
             String collapsedPush = normalizedPushOutput.replaceAll("\\s+", " ");
             Assert.assertTrue(collapsedPush.contains("Successfully pushed target/bala/" + org + "-" + pkg + "-any-" + ver + ".bala to '" + GITHUB_REPO_ID + "' repository."),
                     "Expected push success message. Actual output: " + pushOutput);
         }
     }

     @Test(description = "Build a package with multiple dependencies from Github packages")
    public void testCase1_buildMyProject_assertDependenciesToml() throws IOException, InterruptedException {
         List<String> args = new ArrayList<>();
         Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory
                         .resolve("myproject1"),
                 args, this.envVariables);
         String buildErrors = getString(build.getErrorStream());
         if (!buildErrors.isEmpty()) {
             Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
         }

         String buildOutput = getString(build.getInputStream());
         String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n")
                 .replace("\r", "\n");
         String collapsed = normalized.replaceAll("\\s+", " ");
         Assert.assertTrue(collapsed.contains("Generating executable") &&
                         collapsed.contains("target/bin/myproject1.jar"),
                 "Expected generating executable + target/bin/myproject1.jar in output. Actual output: "
                         + buildOutput);

         Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
         Optional<String> pkg1Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                 "pkg1");
         Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                 "pkg2");

         Assert.assertTrue(pkg1Version.isPresent(), "Expected pkg1 to be present in Dependencies.toml");
         Assert.assertEquals(pkg1Version.get(), "0.1.0", "Package version is not matching with the " +
                 "pushed package version");
         Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
         Assert.assertEquals(pkg2Version.get(), "1.0.0", "Package version is not matching with the" +
                 "pushed package version");
    }

    @BeforeGroups("testCase2")
    public void beforeGroupTestCase2() throws IOException {
         Path projectDir = this.tempWorkspaceDirectory.resolve("myproject1");
         try {
             Assert.assertTrue(updateVersionForPackage(projectDir, "pkg1", "0.1.0"),
                     "pkg1 not found in Ballerina.toml");
             Assert.assertTrue(updateVersionForPackage(projectDir, "pkg2", "1.0.0"),
                     "pkg2 not found in Ballerina.toml");
         } catch (IOException e) {
            Assert.fail("Error updating package versions in Ballerina.toml before Test Case 2. " + e.getMessage());
         }
         pasteStaticMainBalWithPkg1AndPkg2(projectDir);
     }

   @Test(description = "Push more packages to Github to test locking mode results",
           dependsOnMethods = "testCase1_buildMyProject_assertDependenciesToml")
   public void testCase2_publishAdditionalVersionsForDeps() throws IOException, InterruptedException {

       // Publish multiple versions for pkg1 (Dep1)
       String[] pkg1Versions = {"0.1.1", "0.2.0", "1.0.0"};
       for (String ver : pkg1Versions) {
           // Update package version, pack and push
           editVersionBallerinaToml(this.tempWorkspaceDirectory.resolve("pkg1"), ver);
           // packTrigger returns a Process we don't need; call directly
           packTrigger("pkg1", this.tempWorkspaceDirectory, this.envVariables);
           Process p = pushTrigger("pkg1", this.tempWorkspaceDirectory, this.envVariables);
           String pushOutput = getString(p.getInputStream());
           // Normalize output so Windows backslashes don't break the assertion
           String normalizedPushOutput = pushOutput.replace("\\", "/")
                   .replace("\r\n", "\n").replace("\r", "\n");
           String collapsedPush = normalizedPushOutput.replaceAll("\\s+", " ");
           String expectedPushMsg1 = "Successfully pushed target/bala/" + org + "-pkg1-any-" + ver
                   + ".bala to '" + GITHUB_REPO_ID + "' repository.";
           Assert.assertTrue(collapsedPush.contains(expectedPushMsg1),
                   "Expected push success message. Actual output: " + pushOutput);
       }

       // Publish multiple versions for pkg2 (Dep2)
       String[] pkg2Versions = {"1.1.1", "1.1.0", "2.0.0"};
       for (String ver : pkg2Versions) {
           // Update package version, pack and push
           editVersionBallerinaToml(this.tempWorkspaceDirectory.resolve("pkg2"), ver);
           Process p = packTrigger("pkg2", this.tempWorkspaceDirectory, this.envVariables);
           String ignoredPackOut = getString(p.getInputStream());
           p = pushTrigger("pkg2", this.tempWorkspaceDirectory, this.envVariables);
           String pushOutput = getString(p.getInputStream());
           // Normalize output so Windows backslashes don't break the assertion
           String normalizedPushOutput = pushOutput.replace("\\", "/")
                   .replace("\r\n", "\n").replace("\r", "\n");
           String collapsedPush = normalizedPushOutput.replaceAll("\\s+", " ");
           String expectedPushMsg2 = "Successfully pushed target/bala/" + org + "-pkg2-any-" + ver
                   + ".bala to '" + GITHUB_REPO_ID + "' repository.";
           Assert.assertTrue(collapsedPush.contains(expectedPushMsg2),
                   "Expected push success message. Actual output: " + pushOutput);
       }

   }

   @Test(description = "Build package with soft locking mode",
           dependsOnMethods = "testCase2_publishAdditionalVersionsForDeps", groups = "testCase2")
    public void testCase2_1_softLockingMode_resolvesLatestCompatible() throws IOException, InterruptedException {
    List<String> args = new ArrayList<>();

       File dependencyPathBefore = this.tempWorkspaceDirectory.resolve("myproject1")
               .resolve("Dependencies.toml").toFile();
       if (dependencyPathBefore.exists()) {
           if (!dependencyPathBefore.delete()) {
               Assert.fail("Could not delete Dependencies.toml at " + dependencyPathBefore.getAbsolutePath());
           }
           List<String> cleanArgs = new ArrayList<>();
           Process clean = executeCleanCommand(DISTRIBUTION_FILE_NAME,
                   this.tempWorkspaceDirectory.resolve("myproject1"), cleanArgs, this.envVariables);
           String cleanErrors = getString(clean.getErrorStream());
           if (!cleanErrors.isEmpty()) {
               Assert.fail(OUTPUT_CONTAIN_ERRORS + cleanErrors);
           }
       }
    args.add("--locking-mode=soft");
    Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve("myproject1"),
            args, this.envVariables);
    String buildErrors = getString(build.getErrorStream());
    if (!buildErrors.isEmpty()) {
        Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
    }
    String buildOutput = getString(build.getInputStream());
    String normalized = buildOutput.replace("\\", "/")
            .replace("\r\n", "\n").replace("\r", "\n");
    String collapsed = normalized.replaceAll("\\s+", " ");
    Assert.assertTrue(collapsed.contains("Generating executable") && collapsed.contains("target/bin/myproject1.jar"),
            "Expected generating executable + target/bin/myproject1.jar in output. Actual output: " + buildOutput);

       Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
       Optional<String> pkg1Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
               "pkg1");
       Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
               "pkg2");
       Assert.assertTrue(pkg1Version.isPresent(), "Expected pkg1 to be present in Dependencies.toml");
       Assert.assertEquals(pkg1Version.get(), "0.1.1", "Package version is not matching with " +
               "the expected package version");
       Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
       Assert.assertEquals(pkg2Version.get(), "1.1.1", "Package version is not matching with " +
               "the expected package version");
   }

   @Test(description = "Build package with medium locking mode",
           dependsOnMethods = "testCase2_publishAdditionalVersionsForDeps", groups = "testCase2")
   public void testCase2_2_mediumLockingMode_resolvesConservative() throws IOException, InterruptedException {
    List<String> args = new ArrayList<>();

    File dependencyPathBefore = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml").toFile();
    if (dependencyPathBefore.exists()) {
        if (!dependencyPathBefore.delete()) {
            Assert.fail("Could not delete Dependencies.toml at " + dependencyPathBefore.getAbsolutePath());
        }
        List<String> cleanArgs = new ArrayList<>();
        Process clean = executeCleanCommand(DISTRIBUTION_FILE_NAME,
                this.tempWorkspaceDirectory.resolve("myproject1"), cleanArgs, this.envVariables);
        String cleanErrors = getString(clean.getErrorStream());
        if (!cleanErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + cleanErrors);
        }
    }
    args.add("--locking-mode=medium");
    Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve("myproject1"),
            args, this.envVariables);
    String buildErrors = getString(build.getErrorStream());
    if (!buildErrors.isEmpty()) {
        Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
    }
    String buildOutput = getString(build.getInputStream());
    String normalized = buildOutput.replace("\\", "/")
            .replace("\r\n", "\n").replace("\r", "\n");
    String collapsed = normalized.replaceAll("\\s+", " ");
    Assert.assertTrue(collapsed.contains("Generating executable") &&
                    collapsed.contains("target/bin/myproject1.jar"), "Expected generating executable + " +
            "target/bin/myproject1.jar in output. Actual output: " + buildOutput);

    Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
    Optional<String> pkg1Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
            "pkg1");
    Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
            "pkg2");
    Assert.assertTrue(pkg1Version.isPresent(), "Expected pkg1 to be present in Dependencies.toml");
    Assert.assertEquals(pkg1Version.get(), "0.1.1", "Package version is not matching with the " +
            "expected package version");
    Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
    Assert.assertEquals(pkg2Version.get(), "1.0.0", "Package version is not matching with the " +
            "expected package version");
   }

   // HARD mode enforces exact compiler update reproducibility.
    // Build is expected to fail if the project was built using a different Swan Lake update.
   @Test(description = "Build package with hard locking mode",
           dependsOnMethods = "testCase2_publishAdditionalVersionsForDeps", groups = "testCase2")
   public void testCase2_3_hardLockingMode_enforcesExact() throws IOException, InterruptedException {
    List<String> args = new ArrayList<>();
    File dependencyPathBefore = this.tempWorkspaceDirectory.resolve("myproject1")
            .resolve("Dependencies.toml").toFile();
       if (dependencyPathBefore.exists()) {
           if (!dependencyPathBefore.delete()) {
               Assert.fail("Could not delete Dependencies.toml at " + dependencyPathBefore.getAbsolutePath());
           }
           List<String> cleanArgs = new ArrayList<>();
           Process clean = executeCleanCommand(DISTRIBUTION_FILE_NAME,
                   this.tempWorkspaceDirectory.resolve("myproject1"), cleanArgs, this.envVariables);
           String cleanErrors = getString(clean.getErrorStream());
           if (!cleanErrors.isEmpty()) {
               Assert.fail(OUTPUT_CONTAIN_ERRORS + cleanErrors);
           }
       }

    args.add("--locking-mode=hard");
    Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve("myproject1"),
            args, this.envVariables);
    String buildErrors = getString(build.getErrorStream());
    if (!buildErrors.isEmpty()) {
        Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
    }
    String buildOutput = getString(build.getInputStream());
    String normalized = buildOutput.replace("\\", "/")
            .replace("\r\n", "\n").replace("\r", "\n");
    String collapsed = normalized.replaceAll("\\s+", " ");

    Assert.assertTrue(collapsed.contains("Generating executable") &&
                    collapsed.contains("target/bin/myproject1.jar"),
               "Expected generating executable + target/bin/myproject1.jar in output. Actual output: "
                       + buildOutput);

       Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
       Optional<String> pkg1Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
               "pkg1");
       Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
               "pkg2");
       Assert.assertTrue(pkg1Version.isPresent(), "Expected pkg1 to be present in Dependencies.toml");
       Assert.assertEquals(pkg1Version.get(), "0.1.0", "Package version is not matching with the " +
               "expected package version");
       Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
       Assert.assertEquals(pkg2Version.get(), "1.0.0", "Package version is not matching with the " +
               "expected package version");

    }

   @Test(description = "Build package with locked mode", dependsOnMethods = "testCase2_publishAdditionalVersionsForDeps"
           , groups = "testCase2")
   public void testCase2_4_lockedMode_usesLockedVersions() throws IOException, InterruptedException {
    List<String> args = new ArrayList<>();
    args.add("--locking-mode=locked");
    Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve("myproject1"),
            args, this.envVariables);
    String buildErrors = getString(build.getErrorStream());
    if (!buildErrors.isEmpty()) {
        Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
    }
    String buildOutput = getString(build.getInputStream());
    String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n")
            .replace("\r", "\n");
    String collapsed = normalized.replaceAll("\\s+", " ");
    Assert.assertTrue(collapsed.contains("Generating executable") &&
                    collapsed.contains("target/bin/myproject1.jar"),
            "Expected generating executable + target/bin/myproject1.jar in output. Actual output: "
                    + buildOutput);

       Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
       Optional<String> pkg1Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
               "pkg1");
       Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
               "pkg2");
       Assert.assertTrue(pkg1Version.isPresent(), "Expected pkg1 to be present in Dependencies.toml");
       Assert.assertEquals(pkg1Version.get(), "0.1.0", "Package version is not matching with the " +
               "expected package version");
       Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
       Assert.assertEquals(pkg2Version.get(), "1.0.0", "Package version is not matching with the " +
               "expected package version");
   }

   @Test(description = "Build package with backwards compatibility", dependsOnGroups = "testCase2")
   public void testCase3_backwardCompatibility_legacyBallerinaToml() throws IOException, InterruptedException {
        Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
        if (Files.deleteIfExists(dependencyPath)) {
            // Use separate argument lists for clean and build to avoid reusing/mutating the same list
            List<String> cleanArgs = new ArrayList<>();
            Process clean = executeCleanCommand(DISTRIBUTION_FILE_NAME,
                    this.tempWorkspaceDirectory.resolve("myproject1"), cleanArgs, this.envVariables);
            String cleanErrors = getString(clean.getErrorStream());
            if (!cleanErrors.isEmpty()) {
                Assert.fail(OUTPUT_CONTAIN_ERRORS + cleanErrors);
            }
            List<String> buildArgs = new ArrayList<>();
            Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME,
                    this.tempWorkspaceDirectory.resolve("myproject1"),
                    buildArgs, this.envVariables);
             String buildErrors = getString(build.getErrorStream());
             if (!buildErrors.isEmpty()) {
                 Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
             }
             String buildOutput = getString(build.getInputStream());
             String normalized = buildOutput.replace("\\", "/")
                     .replace("\r\n", "\n").replace("\r", "\n");
             String collapsed = normalized.replaceAll("\\s+", " ");
             Assert.assertTrue(collapsed.contains("Generating executable") &&
                             collapsed.contains("target/bin/myproject1.jar"),
                     "Expected generating executable + target/bin/myproject1.jar in output. Actual output: "
                             + buildOutput);
             Path dependencyPath2 = this.tempWorkspaceDirectory.resolve("myproject1")
                     .resolve("Dependencies.toml");
             Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath2,
                     "pkg2");
             Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
             Assert.assertEquals(pkg2Version.get(), "1.1.1", "Package version is not matching with " +
                     "the expected package version");
        } else {
            Assert.fail("Could not delete Dependencies.toml file to test backwards compatibility");
        }
    }

    private void pinPkg1AndPkg2To100() throws IOException, InterruptedException {
        Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
        if (Files.exists(dependencyPath)) {
            boolean deleted = Files.deleteIfExists(dependencyPath);
            if (!deleted) {
                Assert.fail("Could not delete Dependencies.toml at " + dependencyPath);
            }
            List<String> cleanArgs = new ArrayList<>();
            Process clean = executeCleanCommand(DISTRIBUTION_FILE_NAME,
                    this.tempWorkspaceDirectory.resolve("myproject1"), cleanArgs, this.envVariables);
            String cleanErrors = getString(clean.getErrorStream());
            if (!cleanErrors.isEmpty()) {
                Assert.fail(OUTPUT_CONTAIN_ERRORS + cleanErrors);
            }
        }

        Path ballerinaTOML = this.tempWorkspaceDirectory.resolve("myproject1");
        Assert.assertTrue(updateVersionForPackage(ballerinaTOML, "pkg1", "1.0.0"),
                "pkg1 not found in Ballerina.toml");
        Assert.assertTrue(updateVersionForPackage(ballerinaTOML, "pkg2", "1.0.0"),
                "pkg2 not found in Ballerina.toml");
        List<String> args = new ArrayList<>();
        args.add("--locking-mode=hard");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME,
                this.tempWorkspaceDirectory.resolve("myproject1"), args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
    }

   // New: run this setup only before the Test Case 4 group
    @BeforeGroups("testCase4")
    public void beforeGroupTestCase4() throws IOException, InterruptedException {
        pinPkg1AndPkg2To100();
    }

    @Test(description = "Test case 4.1: Add dep3 and build with SOFT locking mode",
            dependsOnGroups = "testCase2", groups = "testCase4")
     public void testCase4_1_addDep3_softLocking() throws IOException, InterruptedException {
        Path projectDir = this.tempWorkspaceDirectory.resolve("myproject1");
        // Ensure legacy dependency for pkg3 is present (idempotent)
        MavenCustomRepoTestUtils.ensureLegacyDependency(projectDir, "bctestorg", "pkg3", "1.0.0", GITHUB_REPO_ID);
        List<String> args = new ArrayList<>();
        args.add("--locking-mode=soft");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir, args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n").replace("\r", "\n");
        String collapsed = normalized.replaceAll("\\s+", " ");
        Assert.assertTrue(collapsed.contains("Generating executable") &&
                        collapsed.contains("target/bin/myproject1.jar"),
                "Expected generating executable + target/bin/myproject1.jar in output. Actual output: " + buildOutput);

        Path dependencyPath = projectDir.resolve("Dependencies.toml");
        Optional<String> pkg3Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg3");
        Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg2");
        Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
        Assert.assertEquals(pkg2Version.get(), "1.1.1", "pkg2 version should be 1.1.1");
        Assert.assertTrue(pkg3Version.isPresent(), "Expected pkg3 to be present in Dependencies.toml");
        Assert.assertEquals(pkg3Version.get(), "1.0.0", "pkg3 version should be 1.0.0");
    }

    @Test(description = "Test case 4.2: Add dep3 and build with MEDIUM (default) locking mode",
            dependsOnGroups = "testCase2", groups = "testCase4")
    public void testCase4_2_addDep3_mediumLocking() throws IOException, InterruptedException {
        Path projectDir = this.tempWorkspaceDirectory.resolve("myproject1");
        // Ensure legacy dependency for pkg3 is present (idempotent)
        MavenCustomRepoTestUtils.pasteStaticMainBalWithPkg1AndPkg2(projectDir);
        // Remove existing Dependencies.toml in an idempotent way
        Files.deleteIfExists(projectDir.resolve("Dependencies.toml"));
        List<String> args = new ArrayList<>();
        args.add("--locking-mode=hard");
        Process buildCleanup = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir,
                args, this.envVariables);
        String buildCleanupErrors = getString(buildCleanup.getErrorStream());
        if (!buildCleanupErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildCleanupErrors);
        }
        pasteStaticMainBalWithAllPkgs(projectDir);
        args = new ArrayList<>();
        args.add("--locking-mode=medium");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir, args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n")
                .replace("\r", "\n");
        String collapsed = normalized.replaceAll("\\s+", " ");
        Assert.assertTrue(collapsed.contains("Generating executable") &&
                        collapsed.contains("target/bin/myproject1.jar"),
                "Expected generating executable + target/bin/myproject1.jar in output. Actual output: "
                        + buildOutput);

        Path dependencyPath = projectDir.resolve("Dependencies.toml");
        Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg2");
        Optional<String> pkg3Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg3");
        Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
        Assert.assertEquals(pkg2Version.get(), "1.0.0", "Pkg2 version should be 1.0.0");
        Assert.assertTrue(pkg3Version.isPresent(), "Expected pkg3 to be present in Dependencies.toml");
        Assert.assertEquals(pkg3Version.get(), "1.0.0", "pkg3 version should be 1.0.0");
    }

    @Test(description = "Test case 4.3: Add dep3 and build with HARD locking mode",
            dependsOnGroups = "testCase2", groups = "testCase4")
    public void testCase4_3_addDep3_hardLocking() throws IOException, InterruptedException {
        Path projectDir = this.tempWorkspaceDirectory.resolve("myproject1");
        // Ensure legacy dependency for pkg3 is present (idempotent)
        MavenCustomRepoTestUtils.pasteStaticMainBalWithPkg1AndPkg2(projectDir);
        // Remove existing Dependencies.toml in an idempotent way
        Files.deleteIfExists(projectDir.resolve("Dependencies.toml"));
        List<String> args = new ArrayList<>();
        args.add("--locking-mode=hard");
        Process buildCleanup = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir,
                args, this.envVariables);
        String buildCleanupErrors = getString(buildCleanup.getErrorStream());
        if (!buildCleanupErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildCleanupErrors);
        }
        pasteStaticMainBalWithAllPkgs(projectDir);
        args = new ArrayList<>();
        args.add("--locking-mode=hard");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir, args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n")
                .replace("\r", "\n");
        String collapsed = normalized.replaceAll("\\s+", " ");
        Assert.assertTrue(collapsed.contains("Generating executable") &&
                        collapsed.contains("target/bin/myproject1.jar"),
                "Expected generating executable + target/bin/myproject1.jar in output. Actual output: " + buildOutput);

        Path dependencyPath = projectDir.resolve("Dependencies.toml");
        Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg2");
        Optional<String> pkg3Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg3");
        Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
        Assert.assertTrue(pkg3Version.isPresent(), "Expected pkg3 to be present in Dependencies.toml");
        Assert.assertEquals(pkg2Version.get(), "1.0.0", "pkg2 version should be 1.0.0");
        Assert.assertEquals(pkg3Version.get(), "1.0.0", "pkg3 version should be 1.0.0");
    }

    @Test(description = "Test case 4.4: Add dep3 and build with LOCKED locking mode",
          dependsOnGroups = "testCase2", groups = "testCase4")
     public void testCase4_4_addDep3_lockedLocking() throws IOException, InterruptedException {
        Path projectDir = this.tempWorkspaceDirectory.resolve("myproject1");
        MavenCustomRepoTestUtils.pasteStaticMainBalWithPkg1AndPkg2(projectDir);
        Files.deleteIfExists(projectDir.resolve("Dependencies.toml"));

        List<String> args = new ArrayList<>();
        args.add("--locking-mode=hard");
        Process buildCleanup = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir,
                args, this.envVariables);
        String buildCleanupErrors = getString(buildCleanup.getErrorStream());
        if (!buildCleanupErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildCleanupErrors);
        }

        pasteStaticMainBalWithAllPkgs(projectDir);

        args = new ArrayList<>();
        args.add("--locking-mode=locked");
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, projectDir, args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        String buildOutput = getString(build.getInputStream());
        String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n")
                .replace("\r", "\n");
        String collapsed = normalized.replaceAll("\\s+", " ");

        // Expect a locked-mode error when attempting to add new imports.
        boolean stderrHasLockedMsg = buildErrors != null && (buildErrors.contains("cannot add new imports with" +
                " --locking-mode=locked")
                || buildErrors.contains("package resolution contains errors"));
        boolean stdoutHasLockedMsg = collapsed.contains("cannot add new imports with --locking-mode=locked")
                || collapsed.contains("package resolution contains errors");

        Assert.assertTrue(stderrHasLockedMsg || stdoutHasLockedMsg,
                "Expected locked-mode error when adding new imports. stdout: " + collapsed + "\nstderr: " +
                        buildErrors);

        // Build should not have generated an executable in locked mode when adding new imports.
        Assert.assertFalse(collapsed.contains("Generating executable") &&
                        collapsed.contains("target/bin/myproject1.jar"),
                "Build unexpectedly succeeded in locked locking mode when adding new imports. stdout: " +
                        collapsed + "\nstderr: " + buildErrors);
    }

    @Test(description = "Add a new version for an existing dependency and build",
            dependsOnMethods = "testCase2_publishAdditionalVersionsForDeps")
    public void testCase5_addVersionInBallerinaToml_buildSucceeds() throws IOException, InterruptedException {
        // Update the package version in Ballerina.toml first, then build to pick up the change.
        Assert.assertTrue(updateVersionForPackage(this.tempWorkspaceDirectory.resolve("myproject1"),
                "pkg2", "1.1.0"), "pkg2 not found in Ballerina.toml");
        List<String> args = new ArrayList<>();
        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspaceDirectory.resolve("myproject1"),
                args, this.envVariables);
        String buildErrors = getString(build.getErrorStream());
        if (!buildErrors.isEmpty()) {
            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
        }
        String buildOutput = getString(build.getInputStream());
        String normalized = buildOutput.replace("\\", "/").replace("\r\n", "\n")
                .replace("\r", "\n");
        String collapsed = normalized.replaceAll("\\s+", " ");
        Assert.assertTrue(collapsed.contains("Generating executable") &&
                        collapsed.contains("target/bin/myproject1.jar"),
                "Expected generating executable + target/bin/myproject1.jar in output. Actual output: " + buildOutput);

        Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
        Optional<String> pkg2Version = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg2");
        Assert.assertTrue(pkg2Version.isPresent(), "Expected pkg2 to be present in Dependencies.toml");
        Assert.assertEquals(pkg2Version.get(), "1.1.1", "Package version is not matching with the " +
                "expected package version");
    }

    @Test(description = "Add an incompatible version for an existing dependency and build should fail",
            dependsOnMethods = "testCase2_publishAdditionalVersionsForDeps")
    public void testCase5_addIncompatibleVersion_buildFails() throws IOException, InterruptedException {
        Path dependencyPath = this.tempWorkspaceDirectory.resolve("myproject1").resolve("Dependencies.toml");
        if (!Files.exists(dependencyPath)) {
            // If the locked Dependencies.toml was removed by an earlier test, recreate a pinned state.
            // pinPkg1AndPkg2To100 is idempotent and will create a hard-locked Dependencies.toml.
            pinPkg1AndPkg2To100();
        }

        // Read the existing locked version so we can restore it after the test
        String existingVersion = MavenCustomRepoTestUtils.getPackageVersionFromDependencies(dependencyPath,
                "pkg2").orElse("");

        // Update Ballerina.toml to an incompatible version first, then run the build and assert failure
        try {
            updateVersionForPackage(this.tempWorkspaceDirectory.resolve("myproject1"), "pkg2", "2.0.0");
            List<String> args = new ArrayList<>();
            Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME,
                    this.tempWorkspaceDirectory.resolve("myproject1"), args, this.envVariables);
            String buildErrors = getString(build.getErrorStream());
            Assert.assertTrue(buildErrors.contains("incompatible with the version locked in Dependencies.toml"),
                    "Incompatible version error message not found in the build errors. Actual stderr: " + buildErrors);
        } finally {
            if (!existingVersion.isEmpty()) {
                updateVersionForPackage(this.tempWorkspaceDirectory.resolve("myproject1"), "pkg2", existingVersion);
            }
         }
        }

    @AfterClass(alwaysRun = true)
    public void cleanup() throws IOException {
        deleteFiles(actualHomeDirectory, true);
        Files.walkFileTree(actualHomeDirectoryClone,
                new MavenCustomRepoTest.Copy(actualHomeDirectoryClone, actualHomeDirectory));
        deleteFiles(actualHomeDirectoryClone, false);
        deleteFiles(tempWorkspaceDirectory, false);
        deleteArtifacts(org, "pkg1");
        deleteArtifacts(org, "pkg2");
        deleteArtifacts(org, "pkg3");
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
