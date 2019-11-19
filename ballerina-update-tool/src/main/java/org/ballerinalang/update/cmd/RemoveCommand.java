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
import picocli.CommandLine;

import java.io.PrintStream;
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
            remove(getPrintStream(), removeCommands.get(0));
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

    public static void remove(PrintStream printStream, String version) {
        printStream.println("Removing" + version);
//        boolean isCurrentVersion = false;
//        try {
//            isCurrentVersion = version.equals(getCurrentBallerinaVersion());
//        } catch (IOException e) {
//            outStream.println("There is no default version for current user");
//        }
//
//        try {
//            if (isCurrentVersion) {
//                outStream.println("You cannot remove default Ballerina version");
//            } else {
//                File directory = new File(getDistributionsPath() + File.separator + version);
//                if (directory.exists()) {
//                    if (directory.canWrite()) {
//                        deleteFiles(directory.toPath(), outStream, version);
//                        outStream.println(version + " deleted successfully");
//                    } else {
//                        outStream.println("Current user does not have write permissions to "
//                                + directory.toPath() + " directory");
//                    }
//                } else {
//                    outStream.println(version + " does not exist");
//                }
//            }
//        } catch (IOException e) {
//            outStream.println("Error occurred while removing");
//        }
    }
}
