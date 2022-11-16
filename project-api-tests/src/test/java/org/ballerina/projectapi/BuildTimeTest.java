//package org.ballerina.projectapi;
//
//import com.fasterxml.jackson.databind.JsonNode;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import org.testng.Assert;
//import org.testng.annotations.AfterClass;
//import org.testng.annotations.BeforeClass;
//import org.testng.annotations.Test;
//
//import java.io.IOException;
//import java.io.PrintStream;
//import java.net.URI;
//import java.net.URISyntaxException;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.nio.file.Paths;
//import java.util.Collections;
//import java.util.LinkedList;
//import java.util.Map;
//import java.util.Objects;
//
//import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_DEV_CENTRAL;
//import static org.ballerina.projectapi.CentralTestUtils.BALLERINA_HOME_DIR;
//import static org.ballerina.projectapi.CentralTestUtils.createSettingToml;
//import static org.ballerina.projectapi.CentralTestUtils.deleteFiles;
//import static org.ballerina.projectapi.CentralTestUtils.getEnvVariables;
//import static org.ballerina.projectapi.CentralTestUtils.getString;
//import static org.ballerina.projectapi.TestUtils.DISTRIBUTION_FILE_NAME;
//import static org.ballerina.projectapi.TestUtils.OUTPUT_CONTAIN_ERRORS;
//import static org.ballerina.projectapi.TestUtils.executeBuildCommand;
//
///**
// * Tests related to build time.
// */
//public class BuildTimeTest {
//
//    private static final PrintStream OUT = System.out;
//    private Path tempHome;
//    private Path tempWorkspace;
//    private Map<String, String> envVariables;
//
//    @BeforeClass
//    public void setup() throws IOException {
//        TestUtils.setupDistributions();
//        tempHome = Files.createTempDirectory("bal-test-integration-packaging-home-");
//        tempWorkspace = Files.createTempDirectory("bal-test-integration-packaging-workspace-");
//        createSettingToml(tempHome);
//        envVariables = addEnvVariables(getEnvVariables());
//        // Copy test resources to temp workspace directory
//        try {
//            URI testResourcesURI = Objects.requireNonNull(getClass().getClassLoader().getResource("build-time")).
//                    toURI();
//            Files.walkFileTree(Paths.get(testResourcesURI),
//                    new CentralTest.Copy(Paths.get(testResourcesURI), this.tempWorkspace));
//        } catch (URISyntaxException e) {
//            Assert.fail("error loading resources");
//        }
//    }
//
//    @Test(enabled = false,
//            description = "Build project twice to verify reduction in package resolution time due to caching.")
//    public void testResolutionTimeReduction() throws IOException, InterruptedException {
//        String projectName = "Project1";
//        long expectedMinimumTimeDiff = 500;
//        long firstResolutionTime = getPackageResolutionTime(projectName);
//        OUT.println("Package resolution time for the first attempt: " + firstResolutionTime);
//        long consecutiveResolutionTime = getPackageResolutionTime(projectName);
//        OUT.println("Package resolution time for the consecutive attempt: " + consecutiveResolutionTime);
//        // Assert whether the resolution time has reduced more than the expected minimum time difference
//        Assert.assertTrue((firstResolutionTime - consecutiveResolutionTime) > expectedMinimumTimeDiff);
//    }
//
//    /**
//     * Get environment variables and add ballerina_home as a env variable the tmp directory.
//     *
//     * @return env directory variable array
//     */
//    private Map<String, String> addEnvVariables(Map<String, String> envVariables) {
//        envVariables.put(BALLERINA_HOME_DIR, tempHome.toString());
//        envVariables.put(BALLERINA_DEV_CENTRAL, "true");
//        return envVariables;
//    }
//
//    /**
//     * Given the project name get the package resolution time in milliseconds.
//     *
//     * @param projectName ballerina project name
//     * @return package resolution time in milliseconds as a long
//     * @throws IOException
//     * @throws InterruptedException
//     */
//    private long getPackageResolutionTime(String projectName) throws IOException, InterruptedException {
//        String targetDir = "target";
//        String buildTimeFileName = "build-time.json";
//        String buildDumpFlag = "--dump-build-time";
//        String packageResolutionField = "packageResolutionDuration";
//        Process build = executeBuildCommand(DISTRIBUTION_FILE_NAME, this.tempWorkspace.resolve(projectName),
//                new LinkedList<>(Collections.singletonList(buildDumpFlag)), this.envVariables);
//        String buildErrors = getString(build.getErrorStream());
//        if (!buildErrors.isEmpty()) {
//            Assert.fail(OUTPUT_CONTAIN_ERRORS + buildErrors);
//        }
//        Path buildTimeJson = this.tempWorkspace.resolve(projectName).resolve(targetDir).resolve(buildTimeFileName);
//        if (buildTimeJson.toFile().exists()) {
//            JsonNode jsonTree = new ObjectMapper().readTree(buildTimeJson.toFile());
//            return jsonTree.get(packageResolutionField).asLong();
//        } else {
//            Assert.fail("Unable to locate the JSON file with build time at " + buildTimeJson.toString());
//        }
//        // Return 0 if there is a failure.
//        return 0;
//    }
//
//    @AfterClass
//    private void cleanup() throws IOException {
//        deleteFiles(tempHome);
//        deleteFiles(tempWorkspace);
//    }
//
//}
