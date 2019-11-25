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

package org.ballerinalang.update.cmd;

import org.ballerinalang.update.BLauncherCommand;
import org.ballerinalang.update.BallerinaCliCommands;
import org.ballerinalang.update.util.Distribution;
import org.ballerinalang.update.util.ToolUtil;
import picocli.CommandLine;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 * This class represents the "Update" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "list", description = "List Ballerina Distributions")
public class ListCommand extends Command implements BLauncherCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> listCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public ListCommand(PrintStream printStream) {
        super(printStream);
    }

    public void execute() {
        if (helpFlag) {
            printUsageInfo(BallerinaCliCommands.LIST);
            return;
        }

        if (listCommands == null) {
            listDistributions(getPrintStream());
            return;
        } else if (listCommands.size() > 1) {
            //  throw LauncherUtils.createUsageExceptionWithHelp("too many arguments given");
        }

        String userCommand = listCommands.get(0);
        if (parentCmdParser.getSubcommands().get(userCommand) == null) {
            // throw LauncherUtils.createUsageExceptionWithHelp("unknown command " + userCommand);
        }
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.LIST;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  ballerina dist list\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }

    /**
     * List distributions in the local and remote.
     * @param outStream stream outputs need to be printed
     */
    public static void listDistributions(PrintStream outStream) {
        try {
            outStream.println("Distributions available locally: \n");
            String currentBallerinaVersion = ToolUtil.getCurrentBallerinaVersion();
            File folder = new File(ToolUtil.getDistributionsPath());
            File[] listOfFiles;
            listOfFiles = folder.listFiles();
            List<String> installedVersions = new ArrayList<>();
            for (int i = 0; i < listOfFiles.length; i++) {
                if (listOfFiles[i].isDirectory()) {
                    String version = listOfFiles[i].getName();
                    outStream.println(markVersion(ToolUtil.BALLERINA_TYPE + "-" + currentBallerinaVersion,
                            version));
                    installedVersions.add(version);
                }
            }
            outStream.println();

            outStream.println("Distributions available remotely: \n");
            for (Distribution distribution : ToolUtil.getDistributions()) {
                String version = distribution.getName() + "-" + distribution.getVersion();
                if (!installedVersions.stream().anyMatch(s -> version.contains(s))) {
                    outStream.println("  " + version);
                }
            }
            outStream.println();
        } catch (IOException | KeyManagementException | NoSuchAlgorithmException e) {
            outStream.println("Ballerina Update service is not available");
        }
    }

    /**
     * Checks used Ballerina version and mark the output.
     * @param used Used Ballerina version
     * @param current Version needs to be checked
     * @return Marked output
     */
    private static String markVersion(String used, String current) {
        if (used.equals(current)) {
            return "* " + current;
        } else {
            return "  " + current;
        }
    }
}
