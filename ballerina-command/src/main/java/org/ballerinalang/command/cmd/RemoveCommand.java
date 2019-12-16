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

package org.ballerinalang.command.cmd;

import org.ballerinalang.command.BallerinaCliCommands;
import org.ballerinalang.command.util.ErrorUtil;
import org.ballerinalang.command.util.ToolUtil;
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
public class RemoveCommand extends Command implements BCommand {

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

        if (removeCommands == null || removeCommands.size() == 0) {
            throw ErrorUtil.createDistributionRequiredException("remove");
        }

        if (removeCommands.size() > 1) {
            throw ErrorUtil.createUsageExceptionWithHelp("too many arguments given");
        }

        ToolUtil.handleInstallDirPermission();
        remove(removeCommands.get(0));
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

    private void remove(String version) {
        boolean isCurrentVersion =
                version.equals(ToolUtil.BALLERINA_TYPE + "-" + ToolUtil.getCurrentBallerinaVersion());
        try {
            if (isCurrentVersion) {
                getPrintStream().println("The default Ballerina distribution cannot be removed");
            } else {
                File directory = new File(ToolUtil.getDistributionsPath() + File.separator + version);
                if (directory.exists()) {
                        deleteFiles(directory.toPath(), getPrintStream(), version);
                    getPrintStream().println("Distribution '" + version + "' successfully removed");
                } else {
                    getPrintStream().println("Distribution '" + version + "' does not exist");
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
