/*
 * Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.distribution.test;

import org.ballerinalang.distribution.utils.TestUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

import static org.ballerinalang.distribution.utils.TestUtils.*;

public class GraphqlToolTest {

    @BeforeClass
    public void setupDistributions() throws IOException {
        TestUtils.cleanDistribution();
        TestUtils.prepareDistribution(DISTRIBUTIONS_DIR.resolve(DISTRIBUTION_FILE_NAME + ".zip"));
    }

    @Test(description = "Check GraphQL client generation")
    public void testGraphqlClientGenerationUsingEndpoint() throws IOException, InterruptedException {
        Path testResource = Paths.get("/graphql/client-gen/project_1");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("graphql_endpoint.config.yaml");
        boolean successful = TestUtils.executeGraphql(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("client.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("types.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("config_types.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("utils.bal")));
        TestUtils.deleteGeneratedFiles("client.bal", GRAPHQL_CMD);
    }

    @Test(description = "Check GraphQL client generation")
    public void testGraphqlClientGenerationUsingSchemaFile() throws IOException, InterruptedException {
        Path testResource = Paths.get("/graphql/client-gen/project_2");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("graphql_schema.config.yaml");
        boolean successful = TestUtils.executeGraphql(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("client.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("types.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("config_types.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("utils.bal")));
        TestUtils.deleteGeneratedFiles("client.bal", GRAPHQL_CMD);
    }

    @Test(description = "Check GraphQL schema generation")
    public void testGraphqlSchemaGeneration() throws IOException, InterruptedException {
        Path testResource = Paths.get("/graphql/schema-gen");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("service.bal");
        boolean successful = TestUtils.executeGraphql(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("schema_graphql.graphql")));
        TestUtils.deleteGeneratedFiles("schema_graphql.graphql", GRAPHQL_CMD);
    }

    @Test(description = "Check GraphQL schema generation")
    public void testGraphqlSchemaGenerationWithServicePathFlag() throws IOException, InterruptedException {
        Path testResource = Paths.get("/graphql/schema-gen/project_1");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("main.bal");
        buildArgs.add("-s");
        buildArgs.add("/gql");
        boolean successful = TestUtils.executeGraphql(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("schema_gql.graphql")));
        TestUtils.deleteGeneratedFiles("schema_gql.graphql", GRAPHQL_CMD);
    }

    @Test(description = "Check GraphQL service generation")
    public void testGraphqlServiceGeneration() throws IOException, InterruptedException {
        Path testResource = Paths.get("/graphql/service-gen");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("schema_starwars.graphql");
        boolean successful = TestUtils.executeGraphql(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("service.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("types.bal")));
        TestUtils.deleteGeneratedFiles("service.bal", GRAPHQL_CMD);
    }

    @Test(description = "Check GraphQL service generation")
    public void testGraphqlServiceGenerationWithRecordFlag() throws IOException, InterruptedException {
        Path testResource = Paths.get("/graphql/service-gen");
        List<String> buildArgs = new LinkedList<>();
        buildArgs.add("-i");
        buildArgs.add("schema_book.graphql");
        buildArgs.add("-r");
        boolean successful = TestUtils.executeGraphql(DISTRIBUTION_FILE_NAME, TestUtils.getResource(testResource),
                buildArgs);
        Assert.assertTrue(successful);
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("service.bal")));
        Assert.assertTrue(Files.exists(TestUtils.getResource(testResource).resolve("types.bal")));
        TestUtils.deleteGeneratedFiles("service.bal", GRAPHQL_CMD);
    }

    @AfterClass
    public void cleanUp() throws IOException {
        TestUtils.cleanDistribution();
    }
}
