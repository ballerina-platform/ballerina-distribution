/*
  ~ * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~ *
  ~ * Licensed under the Apache License, Version 2.0 (the "License");
  ~ * you may not use this file except in compliance with the License.
  ~ * You may obtain a copy of the License at
  ~ *
  ~ * http://www.apache.org/licenses/LICENSE-2.0
  ~ *
  ~ * Unless required by applicable law or agreed to in writing, software
  ~ * distributed under the License is distributed on an "AS IS" BASIS,
  ~ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ * See the License for the specific language governing permissions and
  ~ * limitations under the License.
  ~ */

package org.ballerinalang.distribution.lengthValidation;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.NoSuchElementException;
import org.testng.annotations.Test;
import org.testng.Assert;

import java.nio.file.Paths;
import java.util.regex.Pattern;

import static org.ballerinalang.distribution.utils.TestUtils.EXAMPLES_DIR;
import static org.ballerinalang.distribution.utils.TestUtils.EXTENSTIONS_TO_BE_FILTERED_FOR_LINE_CHECKS;
import static org.ballerinalang.distribution.utils.TestUtils.OUT;

/**
  Used to validate the filtered 
  file inside a example directory
*/
public class LengthValidator {

    private static int LINE_MAX_LIMIT = 80;
    private static String[] fileFilterExtensions;
    private static String defaultFilerExtension = ".bal";
    private static boolean isValidationFailure = false;
    private static Pattern descriptionLine = Pattern.compile("^\\s*//");

    public static void logger(String message) {
        OUT.println(message);
    }
    
    /**
      Check the length count of each lines in a file
    */
    public static void validateLineLength(String path, String fileName) throws LineLengthExceededException, NoSuchElementException {
        BufferedReader reader;
        String relativePath = String.format("/examples/%s", EXAMPLES_DIR.relativize(Paths.get(path)).toString());
        try {
            reader = new BufferedReader(new FileReader(path));
            String line;

            int lineCount = 1;
            do {
                line = reader.readLine();
                // Ignore comments line length
                if (line != null && !descriptionLine.matcher(line).find()) {
                    int count = line.length();
                    if(count > LINE_MAX_LIMIT){
                        logger(String.format("[%s] Line number %d.", relativePath, lineCount));
                        isValidationFailure = true;
                    }
                }
                lineCount += 1;
            } while (line != null);

            reader.close();

        } catch (IOException e) {
            logger(String.format("[%s] An IOException occurred for file name : %s", fileName, path));
            throw new NoSuchElementException("An error occurred during IO operation");
        } catch(NoSuchElementException e) {
            logger(String.format("Invalid file name given : %s",  relativePath));
            throw new NoSuchElementException("Invalid file name");
        }

    }
    
    /**
      Check the extension of the files
    */
    public static void validateFileExtension(File fileEntry, String[] extensions) throws LineLengthExceededException {
        for(String extension: extensions) {
            if(fileEntry.getName().endsWith(extension)) {
                LengthValidator.validateLineLength(fileEntry.getPath(), fileEntry.getName());
            }
        }
    }

    /**
      Check the files in folder
    */
    public static  void listFilesForFolder(final File folder) throws LineLengthExceededException {
        for (final File fileEntry : folder.listFiles()) {
            if (fileEntry.isDirectory() && !fileEntry.getName().endsWith("tests")) {
                listFilesForFolder(fileEntry);
            } else {
                validateFileExtension(fileEntry, fileFilterExtensions);
            }
        }
    }

    @Test
    public void validateLength() throws LineLengthExceededException, IOException, InterruptedException {
        String filePath = EXAMPLES_DIR.toString();
        if (!EXTENSTIONS_TO_BE_FILTERED_FOR_LINE_CHECKS.isEmpty()) {
            String[] splittedArg = EXTENSTIONS_TO_BE_FILTERED_FOR_LINE_CHECKS.split(",");
            fileFilterExtensions = new String[splittedArg.length];
            int counter = 0;
            for (String extension : splittedArg) {
                fileFilterExtensions[counter] = extension.trim();
                counter += 1;
            }
        } else {
            fileFilterExtensions = new String[] { defaultFilerExtension };
        }

        LengthValidator.listFilesForFolder(new File(filePath));

        Assert.assertFalse(isValidationFailure, "Bal files should only");
    }
}

