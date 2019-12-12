/*
 * Copyright (c) 2019, WSO2 Inc. (http://wso2.com) All Rights Reserved.
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

package org.ballerinalang.command.util;

import me.tongfei.progressbar.ProgressBar;
import me.tongfei.progressbar.ProgressBarStyle;
import org.ballerinalang.command.Main;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

/**
 * Ballerina tool utilities.
 */
public class ToolUtil {
   // public static final String PRODUCTION_URL = "https://api.central.ballerina.io/1.0/update-tool";
    private static final String PRODUCTION_URL = "https://api.staging-central.ballerina.io/update-tool";
    public static final String BALLERINA_TYPE = "jballerina";

    private static TrustManager[] trustAllCerts = new TrustManager[]{
            new X509TrustManager() {
                public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                    return null;
                }
                public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) {
                    //No need to implement.
                }
                public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) {
                    //No need to implement.
                }
            }
    };

    /**
     * Provides used Ballerina version.
     * @return Used Ballerina version
     */
    public static String getCurrentBallerinaVersion() {
        try {
            return getVersion(OSUtils.getBallerinaVersionFilePath());
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("current ballerina version not found.");
        }
    }

    private static void setCurrentBallerinaVersion(String version) {
        try {
            setVersion(OSUtils.getBallerinaVersionFilePath(), version);
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("failed to set ballerina version.");
        }
    }

    private static void clearCache(PrintStream outStream) {
        try {
            OSUtils.clearBirCacheLocation(outStream);
            OSUtils.clearJarCacheLocation(outStream);
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("failed to clear the caches.");
        }
    }

    /**
     * Provides used Ballerina tools version.
     * @return Used Ballerina tools version.
     */
    public static String getCurrentToolsVersion() {
        InputStream inputStream = Main.class.getResourceAsStream("/META-INF/tool.properties");
        Properties properties = new Properties();
        try {
            properties.load(inputStream);
            return properties.getProperty("ballerina.command.version");
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("current tool version not found.");
        }
    }

    private static String getVersion(String path) throws IOException {
        BufferedReader br = Files.newBufferedReader(Paths.get(path));
        List<String> list = br.lines().collect(Collectors.toList());
        return list.get(0).replace(BALLERINA_TYPE + "-", "");
    }

    static void setVersion(String path, String version) throws IOException {
        PrintWriter writer = new PrintWriter(path, "UTF-8");

        if (!version.contains(BALLERINA_TYPE)) {
            version = BALLERINA_TYPE  + "-" + version;
        }

        writer.println(version);
        writer.close();
    }

    public static boolean use(PrintStream printStream, String distribution) {
        File installFile = new File(getDistributionsPath() + File.separator + distribution);
        if (installFile.exists()) {
            if (distribution.equals(getCurrentBallerinaVersion())) {
                printStream.println(distribution + " is already in use ");
                return true;
            } else {
                setCurrentBallerinaVersion(distribution);
                clearCache(printStream);
                printStream.println("Using " + distribution);
                return true;
            }
        }
        return false;
    }

    public static List<Distribution> getDistributions() throws IOException, KeyManagementException,
            NoSuchAlgorithmException {

        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCerts, new java.security.SecureRandom());
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

        List<Distribution> distributions = new ArrayList<>();
        URL url = new URL(PRODUCTION_URL + "/distributions");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("user-agent",
                OSUtils.getUserAgent(getCurrentBallerinaVersion(),
                        getCurrentToolsVersion(), "jballerina"));
        conn.setRequestProperty("Accept", "application/json");
        if (conn.getResponseCode() != 200) {
            conn.disconnect();
            throw ErrorUtil.createCommandException("server request failed. HTTP error code  : " +
                                                           conn.getResponseCode());
        } else {
            String json = convertStreamToString(conn.getInputStream());
            Pattern p = Pattern.compile("\"version\":\"(.*?)\"");
            Matcher matcher = p.matcher(json);
            while (matcher.find()) {
                distributions.add(new Distribution(BALLERINA_TYPE, matcher.group(1)));
            }
        }
        conn.disconnect();
        return distributions;
    }

    public static String getLatest(String currentVersion, String type) {
        HttpURLConnection conn = null;
        try {
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            URL url = new URL(PRODUCTION_URL
                                      + "/distributions/latest?version=" + currentVersion + "&type=" + type);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("user-agent",
                                    OSUtils.getUserAgent(getCurrentBallerinaVersion(),
                                                         getCurrentToolsVersion(), "jballerina"));
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                conn.disconnect();
                throw ErrorUtil.createCommandException("server request failed. HTTP error code  : " +
                                                               conn.getResponseCode());
            } else {
                return getValue(type, convertStreamToString(conn.getInputStream()));
            }
        } catch (IOException | NoSuchAlgorithmException | KeyManagementException e) {
            throw ErrorUtil.createCommandException("Cannot connect to the update server");
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    private static String getValue(String key, String json) {
        Pattern pattern = Pattern.compile(String.format("\"%s\":\"(.*?)\"", key));
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    public static String getLatestToolVersion() {
        HttpURLConnection conn = null;
        try {
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            URL url = new URL(PRODUCTION_URL + "/versions/latest");

            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("user-agent", OSUtils.getUserAgent(getCurrentBallerinaVersion(),
                                                                       getCurrentToolsVersion(), "jballerina"));
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw ErrorUtil.createCommandException("server request failed. HTTP error code  : " +
                                                               conn.getResponseCode());
            } else {
                String json = convertStreamToString(conn.getInputStream());
                Pattern p = Pattern.compile("\"version\":\"(.*?)\"");
                Matcher matcher = p.matcher(json);
                if (matcher.find()) {
                    conn.disconnect();
                    return matcher.group(1);
                } else {
                    throw ErrorUtil.createCommandException("cannot find the version from json response: " + json);
                }
            }
        } catch (IOException | NoSuchAlgorithmException | KeyManagementException e) {
            throw ErrorUtil.createCommandException("Cannot connect to the update server");
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    private static String convertStreamToString(InputStream is) {

        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (IOException e) {
            //TODO : do nothing
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                //TODO : do nothing
            }
        }
        return sb.toString();
    }

    /**
     * Provides path of the installed distributions.
     * @return installed distributions path
     */
    public static String getDistributionsPath() {
        try {
            return OSUtils.getInstallationPath() + File.separator + "distributions";
        } catch (URISyntaxException e) {
            throw ErrorUtil.createCommandException("failed to get the distributions path");
        }
    }

    /**
     * Provides path of the tool unzip location.
     *
     * @return temporary directory to unzip update tool zip
     */
    private static String getToolUnzipLocation() {
        try {
            return OSUtils.getInstallationPath() + File.separator + "ballerina-command-tmp";
        } catch (URISyntaxException e) {
            throw ErrorUtil.createCommandException("failed to get temporary directory to unzip update tool zip");
        }
    }

    /**
     * Checks for command avaiable for current version.
     * @param printStream stream which messages should be printed
     * @param args current commands arguments
     */
    public static void checkForUpdate(PrintStream printStream, String[] args) {
        try {
            //Update check will be done only for build command
            boolean isBuildCommand = Arrays.asList(args).contains("build");
            boolean isHelpFlag = Arrays.stream(args).anyMatch(val -> val.equals("--help") || val.equals("-h"));

            if (isBuildCommand && !isHelpFlag) {
                String version = getCurrentBallerinaVersion();
                if (OSUtils.updateNotice(version)) {
                    String latestVersion = ToolUtil.getLatest(version, "patch");
                    if (!latestVersion.equals(version)) {
                        printStream.println();
                        printStream.println("A new Ballerina version is available : " + latestVersion);
                        printStream.println("You can download the installer of it from " +
                                            "https://ballerina.io/downloads/.");
                        printStream.println();
                    }
                }
            }
        } catch (Exception e) {
            // If any exception occurs we are not letting users know as check for command is optional
        }
    }

    public static void downloadDistribution(PrintStream printStream, String distribution, boolean manualUpdate) {
        HttpURLConnection conn = null;
        try {
            if (!ToolUtil.use(printStream, distribution)) {
                SSLContext sc = SSLContext.getInstance("SSL");
                sc.init(null, trustAllCerts, new java.security.SecureRandom());
                HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

                String distributionType = distribution.split("-")[0];
                String distributionVersion = distribution.replace(distributionType + "-", "");
                URL url = new URL(ToolUtil.PRODUCTION_URL + "/distributions/" + distributionVersion);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("user-agent",
                                        OSUtils.getUserAgent(distributionVersion, ToolUtil.getCurrentToolsVersion(),
                                                             distributionType));
                conn.setRequestProperty("Accept", "application/json");
                if (conn.getResponseCode() == 302) {
                    String newUrl = conn.getHeaderField("Location");
                    conn = (HttpURLConnection) new URL(newUrl).openConnection();
                    conn.setRequestProperty("content-type", "binary/data");
                    ToolUtil.downloadAndSetupDist(printStream, conn, distribution, manualUpdate);
                } else if (conn.getResponseCode() == 200) {
                    ToolUtil.downloadAndSetupDist(printStream, conn, distribution, manualUpdate);
                } else {
                    printStream.println(distribution + " is not found ");
                }
            }
        } catch (IOException | NoSuchAlgorithmException | KeyManagementException e) {
            throw ErrorUtil.createCommandException("Cannot connect to the update server");
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    private static void downloadAndSetupDist(PrintStream printStream, HttpURLConnection conn,
                                             String distribution, boolean manual) {
        try {
            String distPath = getDistributionsPath();
            String zipFileLocation = getDistributionsPath() + File.separator + distribution + ".zip";
            downloadFile(conn, zipFileLocation, distribution, printStream);
            printStream.println();
            unzip(zipFileLocation, distPath);
            addExecutablePermissionToFile(new File(distPath + File.separator + distribution
                                                           + File.separator + "bin"
                                                           + File.separator + OSUtils.getExecutableFileName()));
            new File(zipFileLocation).delete();
        } finally {
            conn.disconnect();
        }
        if (manual) {
            printStream.println(distribution + " is installed. Please execute \"ballerina dist use " +
                                        "" + distribution + "\" to use as the default");
        }
    }

    public static void downloadTool(PrintStream printStream, String toolVersion) {
        HttpURLConnection conn = null;
        try {
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            URL url = new URL(ToolUtil.PRODUCTION_URL + "/versions/" + toolVersion);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("user-agent", OSUtils.getUserAgent(getCurrentBallerinaVersion(),
                                                                       getCurrentToolsVersion(), "jballerina"));
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() == 302) {
                String newUrl = conn.getHeaderField("Location");
                conn = (HttpURLConnection) new URL(newUrl).openConnection();
                conn.setRequestProperty("content-type", "binary/data");
                downloadAndSetupTool(printStream, conn, "ballerina-command-" + toolVersion);
            } else if (conn.getResponseCode() == 200) {
                downloadAndSetupTool(printStream, conn, "ballerina-command-" + toolVersion);
            } else {
                throw ErrorUtil.createCommandException(toolVersion + " is not found ");
            }
        } catch (IOException | NoSuchAlgorithmException | KeyManagementException e) {
            throw ErrorUtil.createCommandException("Cannot connect to the update server");
        }  finally {
            if (conn != null) {
                conn.disconnect();
            }
        }

    }

    private static void downloadAndSetupTool(PrintStream printStream, HttpURLConnection conn,
                                             String toolFileName) {
        printStream.println("Downloading " + toolFileName);
        String toolUnzipLocation = getToolUnzipLocation();
        File tempUnzipDirectory = Paths.get(toolUnzipLocation).toFile();
        if (tempUnzipDirectory.exists()) {
            tempUnzipDirectory.delete();
        }
        tempUnzipDirectory.mkdir();
        String zipFileLocation = toolUnzipLocation + File.separator + toolFileName + ".zip";
        downloadFile(conn, zipFileLocation, toolFileName, printStream);
        printStream.println();
        unzip(zipFileLocation, toolUnzipLocation);
        copyScripts(toolUnzipLocation, toolFileName);
        Paths.get(toolUnzipLocation).toFile().delete();
        Paths.get(zipFileLocation).toFile().delete();
    }

    private static void downloadFile(HttpURLConnection conn, String zipFileLocation,
                                     String fileName, PrintStream printStream) {
        try (InputStream in = conn.getInputStream();
             FileOutputStream out = new FileOutputStream(zipFileLocation)) {
            byte[] b = new byte[1024];
            int count;
            int progress = 0;
            long totalSizeInMB = conn.getContentLengthLong() / (1024 * 1024);

            try (ProgressBar progressBar = new ProgressBar("Downloading " + fileName, totalSizeInMB,
                    1000, printStream , ProgressBarStyle.ASCII, " MB", 1)) {
                while ((count = in.read(b)) > 0) {
                    out.write(b, 0, count);
                    progress++;
                    if (progress % 1024 == 0) {
                        progressBar.step();
                    }
                }
            }
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("failed to download file: " + fileName + " to " +
                                                           zipFileLocation + ".");
        }
    }

    private static void unzip(String zipFilePath, String destDirectory) {
        File destDir = new File(destDirectory);
        if (!destDir.exists()) {
            destDir.mkdir();
        }
        try (ZipInputStream zipIn = new ZipInputStream(new FileInputStream(zipFilePath))) {
            ZipEntry entry = zipIn.getNextEntry();
            while (entry != null) {
                String filePath = destDirectory + File.separator + entry.getName();
                if (!entry.isDirectory()) {
                    BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(filePath));
                    byte[] bytesIn = new byte[1024];
                    int read;
                    while ((read = zipIn.read(bytesIn)) != -1) {
                        bos.write(bytesIn, 0, read);
                    }
                    bos.close();
                } else {
                    File dir = new File(filePath);
                    dir.mkdir();
                }
                zipIn.closeEntry();
                entry = zipIn.getNextEntry();
            }
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("failed to unzip zip the file in: " + zipFilePath + " to " +
                                                           destDirectory + ".");
        }
    }

    private static void copyScripts(String unzippedUpdateToolPath, String ballerinaCommandDir) {
        String installScriptFileName = OSUtils.getInstallScriptFileName();
        Path installScript = Paths.get(unzippedUpdateToolPath, installScriptFileName);
        try {
            Files.copy(Paths.get(unzippedUpdateToolPath, ballerinaCommandDir, "scripts", installScriptFileName),
                       installScript);
        } catch (IOException e) {
            throw ErrorUtil.createCommandException("failed to copy update scripts to temp directory " +
                                                           unzippedUpdateToolPath);
        }
        addExecutablePermissionToFile(installScript.toFile());
    }

    private static void addExecutablePermissionToFile(File file) {
        file.setReadable(true, false);
        file.setExecutable(true, false);
        file.setWritable(true, false);
    }

    public static String readFileAsString(String path) throws IOException {
        InputStream is = ClassLoader.getSystemResourceAsStream(path);
        if (is == null) {
            throw new IOException("path cannot be found in :" + path);
        }
        InputStreamReader inputStreamREader = null;
        BufferedReader br = null;
        StringBuilder sb = new StringBuilder();
        try {
            inputStreamREader = new InputStreamReader(is, StandardCharsets.UTF_8);
            br = new BufferedReader(inputStreamREader);
            String content = br.readLine();
            if (content == null) {
                return sb.toString();
            }

            sb.append(content);

            while ((content = br.readLine()) != null) {
                sb.append('\n').append(content);
            }
        } finally {
            if (inputStreamREader != null) {
                try {
                    inputStreamREader.close();
                } catch (IOException ignore) {
                }
            }
            if (br != null) {
                try {
                    br.close();
                } catch (IOException ignore) {
                }
            }
        }
        return sb.toString();
    }

    /**
     * Handle user permission to ballerina install location.
     *
     */
    public static void handleInstallDirPermission() {
        try {
            String installationPath = OSUtils.getInstallationPath();
            if (!new File(installationPath).canWrite()) {
                throw ErrorUtil.createCommandException("current user does not have write permissions.\n\n" +
                                                               "Current user does not have write permissions to " +
                                                               "ballerina installation path : " + installationPath +
                                                               ". Grant permission to the file path or run the " +
                                                               "command with user has write permission.");
            }
        } catch (URISyntaxException e) {
            throw ErrorUtil.createCommandException("failed to get ballerina installation file path.");
        }
    }
}

