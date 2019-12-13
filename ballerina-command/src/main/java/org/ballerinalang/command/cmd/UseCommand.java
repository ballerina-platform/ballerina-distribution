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

import java.io.PrintStream;
import java.util.List;

/**
 * This class represents the "Update" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "use", description = "Use Ballerina distribution")
public class UseCommand extends Command implements BCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> useCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public UseCommand(PrintStream printStream) {
        super(printStream);
    }

    public void execute() {
        if (helpFlag) {
            printUsageInfo(BallerinaCliCommands.USE);
            return;
        }

        if (useCommands == null || useCommands.size() == 0) {
            throw ErrorUtil.createUsageExceptionWithHelp("distribution is not provided");
        }

        if (useCommands.size() > 1) {
            throw ErrorUtil.createUsageExceptionWithHelp("too many arguments given");
        }

        PrintStream printStream = getPrintStream();
        String distribution = useCommands.get(0);
        String distributionType = distribution.split("-")[0];
        if (!distributionType.equals("ballerina") && !distributionType.equals("jballerina")) {
            throw ErrorUtil.createCommandException(distribution + " is not found");
        }
        String distributionVersion = distribution.replace(distributionType + "-", "");
        if (distributionVersion.equals(ToolUtil.getCurrentBallerinaVersion())) {
            printStream.println(distribution + " already in use");
            return;
        }
        if (ToolUtil.checkDistributionAvailable(distribution)) {
            ToolUtil.useBallerinaVersion(printStream, distribution);
            printStream.println("Using distribution version: " + distribution);
            return;
        }
        printStream.println(distribution + " does not exist. Please use 'ballerina " +
                                    "dist fetch " + distribution + "' to download the distribution");
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.USE;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  ballerina dist use\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }
}
