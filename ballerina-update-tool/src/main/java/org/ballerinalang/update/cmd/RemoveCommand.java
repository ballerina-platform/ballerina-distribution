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
import org.ballerinalang.update.util.ToolUtil;
import picocli.CommandLine;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.List;

/**
 * This class represents the "Remove" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "remove", description = "Remove Ballerina distribution")
public class RemoveCommand extends Command implements BLauncherCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> removeCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public RemoveCommand(PrintStream printStream) {
        super(printStream);
    }

    public void execute() {
        if (helpFlag) {
            printUsageInfo(BallerinaCliCommands.REMOVE);
            return;
        }

        if (removeCommands == null) {
            //    throw LauncherUtils.createUsageExceptionWithHelp("distribution is not provided");
        } else if (removeCommands.size() == 1) {
            remove(removeCommands.get(0));
            return;
        } else if (removeCommands.size() > 1) {
            //    throw LauncherUtils.createUsageExceptionWithHelp("too many arguments given");
        }

        String userCommand = removeCommands.get(0);
        if (parentCmdParser.getSubcommands().get(userCommand) == null) {
            //   throw LauncherUtils.createUsageExceptionWithHelp("unknown command " + userCommand);
        }
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.REMOVE;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  ballerina dist remove\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }

    public void remove(String version) {
        boolean isCurrentVersion = false;
        try {
            isCurrentVersion = version.equals(ToolUtil.BALLERINA_TYPE + "-" + ToolUtil.getCurrentBallerinaVersion());
        } catch (IOException e) {
            getPrintStream().println("There is no default version for current user");
        }

        try {
            if (isCurrentVersion) {
                getPrintStream().println("You cannot remove default Ballerina version");
            } else {
                File directory = new File(ToolUtil.getDistributionsPath() + File.separator + version);
                if (directory.exists()) {
                    if (directory.canWrite()) {
                        deleteFiles(directory.toPath(), getPrintStream(), version);
                        getPrintStream().println(version + " deleted successfully");
                    } else {
                        getPrintStream().println("Current user does not have write permissions to "
                                + directory.toPath() + " directory");
                    }
                } else {
                    getPrintStream().println(version + " does not exist");
                }
            }
        } catch (IOException e) {
            getPrintStream().println("Error occurred while removing");
        }
    }

    /**
     * Delete files inside directories.
     *
     * @param dirPath directory path
     * @param outStream output stream
     *      @param version deleting version
     * @throws IOException throw an exception if an issue occurs
     */
    public static void deleteFiles(Path dirPath, PrintStream outStream, String version) throws IOException {
        if (dirPath == null) {
            return;
        }
        Files.walk(dirPath)
                .sorted(Comparator.reverseOrder())
                .forEach(path -> {
                    try {
                        Files.delete(path);
                    } catch (IOException e) {
                        outStream.println(version + " cannot remove");
                    }
                });
    }
}
