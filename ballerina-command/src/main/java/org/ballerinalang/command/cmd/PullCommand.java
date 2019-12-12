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
 * This class represents the "Pull" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "pull", description = "Pull Ballerina distribution")
public class PullCommand extends Command implements BCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> pullCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public PullCommand(PrintStream printStream) {
        super(printStream);
    }


    public void execute() {
        if (helpFlag) {
            printUsageInfo("dist-" + BallerinaCliCommands.PULL);
            return;
        }

        if (pullCommands == null || pullCommands.size() == 0) {
            throw ErrorUtil.createUsageExceptionWithHelp("distribution is not provided");
        }

        if (pullCommands.size() > 1) {
            throw ErrorUtil.createUsageExceptionWithHelp("too many arguments given");
        }
        ToolUtil.handleInstallDirPermission();
        PrintStream printStream = getPrintStream();
        String distribution = pullCommands.get(0);
        String distributionType = distribution.split("-")[0];
        if (!distributionType.equals("ballerina") && !distributionType.equals("jballerina")) {
            throw ErrorUtil.createCommandException(distribution + " is not found");
        }
        String distributionVersion = distribution.replace(distributionType + "-", "");
        if (distributionVersion.equals(ToolUtil.getCurrentBallerinaVersion())) {
            printStream.println(distribution + " already in use");
            return;
        }
        ToolUtil.downloadDistribution(printStream, distribution, distributionType, distributionVersion);
        ToolUtil.useBallerinaVersion(printStream, distribution);
        printStream.println("Using distribution version: " + distribution);


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
        out.append("  ballerina dist pull\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }
}
