/*
 *  Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package org.ballerina.packages.buildtime;

//import com.google.gson.Gson;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


/**
 * Class with a main function to accumulate command generated JSON build time data to a CSV file.
 */
public class GenerateBuildDataCsv {
    public static void main(String[] args) throws IOException {

        Path artefactsDir = Paths.get(System.getProperty("user.dir"), "build", "build-time-data");
        Path outputCsvFile = artefactsDir.resolve("buildTimeData.csv");
        List<Path> jsonFiles = getJsonFiles(artefactsDir);

        CsvSchema.Builder csvSchemaBuilder = CsvSchema.builder();
        JsonNode jsonTree = new ObjectMapper().readTree(jsonFiles.get(0).toFile());
        csvSchemaBuilder.addColumn("name");
        jsonTree.fieldNames().forEachRemaining(fieldName ->
                csvSchemaBuilder.addColumn(fieldName, CsvSchema.ColumnType.NUMBER));
        CsvSchema csvSchema;
        CsvMapper csvMapper = new CsvMapper();

        if (!Files.exists(outputCsvFile)) {
            // This done to avoid duplication of the header in the CSV file
            csvSchema = csvSchemaBuilder.build().withHeader();
            csvMapper.writerFor(JsonNode.class).with(csvSchema).writeValue(outputCsvFile.toFile(), null);
        }
        csvSchema = csvSchemaBuilder.build().withoutHeader();

        for (Path jsonFile : jsonFiles) {
            JsonNode jsonTree1 = new ObjectMapper().readTree(jsonFile.toFile());
            // additionally ass the name of the sample to the record
            ((ObjectNode)jsonTree1).put("name", jsonFile.getFileName().toString().split("-build-time.json")[0]);
            ObjectWriter writer = csvMapper.writerFor(JsonNode.class).with(csvSchema);
            try (OutputStream outstream = new FileOutputStream(outputCsvFile.toFile(), true)) {
                writer.writeValue(outstream, jsonTree1);
            }
        }
    }

    private static List<Path> getJsonFiles(Path artefactsDir) throws IOException {
        try (Stream<Path> pathStream = Files.walk(artefactsDir, 2)) {
            return pathStream
                    .filter(path -> path.getFileName().toString().endsWith(".json"))
                    .collect(Collectors.toList());
        }
    }
}
