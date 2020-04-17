/*
 * Copyright (c) 2020, WSO2 Inc. (http://wso2.com) All Rights Reserved.
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

package io.ballerina.test;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;

public class Utils {

    public static final String DISTRIBUTION_LOCATION =
            "https://product-dist.ballerina.io/downloads/";

    public static void downloadFile(String version, String installerName) {
        try {
            String destination = getUserHome();
            File output = new File(destination + File.separator + installerName);
            if (!output.exists()) {
                HttpURLConnection conn = (HttpURLConnection) new URL(
                        DISTRIBUTION_LOCATION + version + "/" + installerName).openConnection();
                conn.setRequestProperty("content-type", "binary/data");

                try (InputStream in = conn.getInputStream();
                     FileOutputStream out = new FileOutputStream(output)) {
                    byte[] b = new byte[1024];
                    int count;
                    while ((count = in.read(b)) > 0) {
                        out.write(b, 0, count);
                    }
                } catch (IOException e) {
                    System.out.print(e);
                }
            }
        } catch (Exception e) {
            System.out.print(e);
        }
    }

    public static String executeWindowsCommand(String command) {
        String output = "";
        try {
            ProcessBuilder pb = new ProcessBuilder("cmd.exe", "/c", command);
            Process p = pb.start();
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                output += line + "\n";
            }
        } catch (Exception e) {
            System.out.print("Error occurred");
        }
        return output;
    }


    public static String executeCommand(String command) {
        String output = "";
        try {
            File file = new File(getUserHome() + File.separator
                    + "temp-" + new Timestamp(System.currentTimeMillis()).getTime() + ".sh");
            file.createNewFile();
            file.setExecutable(true);
            PrintWriter writer = new PrintWriter(file.getPath(), "UTF-8");
            writer.println(command);
            writer.close();

            ProcessBuilder pb = new ProcessBuilder(file.getPath());
            Process p = pb.start();
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                output += line + "\n";
            }
            file.delete();
        } catch (Exception e) {
            System.out.print("Error occurred");
        }
        return output;
    }

    /**
     * Provide user home directory based on command.
     *
     * @return user home directory
     */
    public static String getUserHome() {
        String userHome = System.getenv("HOME");
        if (userHome == null) {
            userHome = System.getProperty("user.home");
        }
        return userHome;
    }
}
