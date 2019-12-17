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
 * This class represents the "Fetch" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "fetch", description = "Fetch Ballerina distribution")
public class FetchCommand extends Command implements BCommand {

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
            printUsageInfo(BallerinaCliCommands.FETCH);
            return;
        }

        if (fetchCommands == null || fetchCommands.size() == 0) {
            throw ErrorUtil.createDistributionRequiredException("fetch");
        }

        if (fetchCommands.size() > 1) {
            throw ErrorUtil.createUsageExceptionWithHelp("too many arguments");
        }

        PrintStream printStream = getPrintStream();
        String distribution = fetchCommands.get(0);
        ToolUtil.handleInstallDirPermission();
        String distributionType = distribution.split("-")[0];
        if (!distributionType.equals("ballerina") && !distributionType.equals("jballerina")) {
            throw ErrorUtil.createDistributionNotFoundException(distribution);
        }
        String distributionVersion = distribution.replace(distributionType + "-", "");
        if (distributionVersion.equals(ToolUtil.getCurrentBallerinaVersion())) {
            printStream.println("'" + distribution + "' is the current distribution in use");
            return;
        }
        if (ToolUtil.downloadDistribution(printStream, distribution, distributionType, distributionVersion)) {
            printStream.println("Distribution '" + distribution + "' is available locally");
        } else {
            printStream.println("Fetched distribution: '" + distribution + "'");
        }
        printStream.println("Run 'ballerina dist use " + distribution + "' to set it as the current distribution");
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.FETCH;
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
