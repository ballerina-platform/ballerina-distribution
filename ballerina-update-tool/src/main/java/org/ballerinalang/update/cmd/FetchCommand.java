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

import java.io.PrintStream;
import java.util.List;

/**
 * This class represents the "Fetch" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "fetch", description = "Fetch Ballerina distribution")
public class FetchCommand extends Command implements BLauncherCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> fetchCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public FetchCommand(PrintStream printStream) {
        super(printStream);
    }


    public void execute() {
        if (helpFlag) {
            printUsageInfo("dist-" + BallerinaCliCommands.FETCH);
            return;
        }

        if (fetchCommands == null) {
            //    throw LauncherUtils.createUsageExceptionWithHelp("distribution is not provided");
        } else if (fetchCommands.size() == 1) {
            ToolUtil.downloadDistribution(getPrintStream(), fetchCommands.get(0), true);
            return;
        } else if (fetchCommands.size() > 1) {
            //    throw LauncherUtils.createUsageExceptionWithHelp("too many arguments given");
        }

        String userCommand = fetchCommands.get(0);
        if (parentCmdParser.getSubcommands().get(userCommand) == null) {
            //    throw LauncherUtils.createUsageExceptionWithHelp("unknown command " + userCommand);
        }
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.PULL;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  ballerina dist fetch\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }
}
